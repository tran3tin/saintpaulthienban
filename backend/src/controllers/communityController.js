const CommunityModel = require("../models/CommunityModel");
const CommunityEventModel = require("../models/CommunityEventModel");
const { uploadToFirebase } = require("./uploadController");
const CommunityAssignmentModel = require("../models/CommunityAssignmentModel");
const AuditLogModel = require("../models/AuditLogModel");
const { clearCacheForResource } = require("../middlewares/cache");
const { applyScopeFilter, checkScopeAccess } = require("../utils/scopeHelper");

const viewerRoles = [
  "admin",
  "superior_general",
  "superior_provincial",
  "superior_community",
  "secretary",
  "viewer",
];
const editorRoles = [
  "admin",
  "superior_general",
  "superior_provincial",
  "superior_community",
  "secretary",
];

const ensurePermission = (req, res, roles) => {
  if (!req.user) {
    res.status(401).json({ message: "Unauthorized" });
    return false;
  }

  // Permission-based access control - no admin bypass
  // Actual permission checking done by checkPermission middleware in routes
  return true;
};

const logAudit = async (req, action, recordId, oldValue, newValue) => {
  try {
    await AuditLogModel.create({
      user_id: req.user ? req.user.id : null,
      action,
      table_name: "communities",
      record_id: recordId,
      old_value: oldValue ? JSON.stringify(oldValue) : null,
      new_value: newValue ? JSON.stringify(newValue) : null,
      ip_address: req.ip,
    });
  } catch (error) {
    console.error("Community audit log failed:", error.message);
  }
};

const getPagination = (req) => {
  const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || 20, 1), 100);
  const offset = (page - 1) * limit;
  return { page, limit, offset };
};

// Generate unique community code like CD001, CD002, ...
const generateCommunityCode = async () => {
  try {
    // Find the highest existing CD number
    const rows = await CommunityModel.executeQuery(
      "SELECT code FROM communities WHERE code REGEXP '^CD[0-9]+$' ORDER BY CAST(SUBSTRING(code, 3) AS UNSIGNED) DESC LIMIT 1",
    );

    let nextNum = 1;
    if (rows.length > 0 && rows[0].code) {
      const lastCode = rows[0].code;
      const numPart = lastCode.replace(/^CD/, "");
      if (!isNaN(numPart)) {
        nextNum = parseInt(numPart, 10) + 1;
      }
    }

    // Keep incrementing until we find an unused code
    let newCode = `CD${String(nextNum).padStart(3, "0")}`;
    let attempts = 0;
    while ((await isCodeExists(newCode)) && attempts < 100) {
      nextNum++;
      newCode = `CD${String(nextNum).padStart(3, "0")}`;
      attempts++;
    }

    return newCode;
  } catch (error) {
    console.error("Error generating community code:", error);
    return `CD${Date.now()}`;
  }
};

// Check if community code already exists
const isCodeExists = async (code, excludeId = null) => {
  let query = "SELECT id FROM communities WHERE code = ?";
  const params = [code];

  if (excludeId) {
    query += " AND id != ?";
    params.push(excludeId);
  }

  const rows = await CommunityModel.executeQuery(query, params);
  return rows.length > 0;
};

const getAllCommunities = async (req, res) => {
  try {
    const { page, limit, offset } = getPagination(req);
    const { status } = req.query;

    const whereClauses = [];
    const params = [];

    if (status && status !== "all") {
      whereClauses.push("c.status = ?");
      params.push(status);
    }

    // Apply data scope filter
    const { whereClause: scopeWhere, params: scopeParams } = applyScopeFilter(
      req.userScope,
      "c",
      {
        communityIdField: "c.id",
        useJoin: false,
      },
    );

    if (scopeWhere) {
      whereClauses.push(scopeWhere);
      params.push(...scopeParams);
    }

    const whereClause = whereClauses.length
      ? `WHERE ${whereClauses.join(" AND ")}`
      : "";

    const totalRows = await CommunityModel.executeQuery(
      `SELECT COUNT(*) AS total FROM communities c ${whereClause}`,
      params,
    );
    const total = totalRows[0] ? totalRows[0].total : 0;

    // Get communities with member count from vocation_journey
    const data = await CommunityModel.executeQuery(
      `SELECT c.*, 
        (SELECT COUNT(DISTINCT vj.sister_id) FROM vocation_journey vj 
         WHERE vj.community_id = c.id 
         AND (vj.end_date IS NULL OR vj.end_date >= CURRENT_DATE)) as member_count
       FROM communities c 
       ${whereClause} 
       ORDER BY c.created_at DESC 
       LIMIT ? OFFSET ?`,
      [...params, limit, offset],
    );

    return res.status(200).json({
      data,
      meta: {
        total,
        page,
        totalPages: Math.ceil(total / limit) || 1,
        limit,
      },
    });
  } catch (error) {
    console.error("getAllCommunities error:", error.message);
    return res.status(500).json({ message: "Failed to fetch communities" });
  }
};

const getCommunityById = async (req, res) => {
  try {
    const { id } = req.params;
    const community = await CommunityModel.findById(id);
    if (!community) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to view this community",
      });
    }

    const members = await CommunityModel.getMembersList(id);

    return res.status(200).json({
      community,
      members,
    });
  } catch (error) {
    console.error("getCommunityById error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to fetch community detail" });
  }
};

const createCommunity = async (req, res) => {
  try {
    const payload = { ...req.body };

    // Auto-generate code if not provided
    if (!payload.code || payload.code.trim() === "") {
      payload.code = await generateCommunityCode();
    } else {
      // Check if code already exists
      const codeExists = await isCodeExists(payload.code);
      if (codeExists) {
        return res.status(400).json({
          message: `Mã cộng đoàn "${payload.code}" đã tồn tại. Vui lòng nhập mã khác hoặc để trống để hệ thống tự động tạo.`,
        });
      }
    }

    const created = await CommunityModel.create(payload);
    await logAudit(req, "CREATE", created.id, null, created);

    // Xóa cache để danh sách được cập nhật
    clearCacheForResource("communities");

    return res.status(201).json({ community: created });
  } catch (error) {
    console.error("createCommunity error:", error.message);
    return res.status(500).json({ message: "Failed to create community" });
  }
};

const updateCommunity = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await CommunityModel.findById(id);
    if (!existing) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to update this community",
      });
    }

    const payload = { ...req.body };

    // Check if code is being changed and if it already exists
    if (payload.code && payload.code !== existing.code) {
      const codeExists = await isCodeExists(payload.code, id);
      if (codeExists) {
        return res.status(400).json({
          message: `Mã cộng đoàn "${payload.code}" đã tồn tại. Vui lòng nhập mã khác.`,
        });
      }
    }

    const updated = await CommunityModel.update(id, payload);
    await logAudit(req, "UPDATE", id, existing, updated);

    // Xóa cache để danh sách được cập nhật
    clearCacheForResource("communities");

    return res.status(200).json({ community: updated });
  } catch (error) {
    console.error("updateCommunity error:", error.message);
    return res.status(500).json({ message: "Failed to update community" });
  }
};

const deleteCommunity = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await CommunityModel.findById(id);
    if (!existing) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to delete this community",
      });
    }

    // Check member count from vocation_journey
    const memberCountRows = await CommunityModel.executeQuery(
      `SELECT COUNT(DISTINCT sister_id) AS total FROM vocation_journey WHERE community_id = ? AND (end_date IS NULL OR end_date >= CURRENT_DATE)`,
      [id],
    );
    const memberCount = memberCountRows[0] ? memberCountRows[0].total : 0;
    if (memberCount > 0) {
      return res.status(400).json({
        message: "Cannot delete community while members are assigned",
      });
    }

    const deleted = await CommunityModel.delete(id);
    if (!deleted) {
      return res.status(500).json({ message: "Failed to delete community" });
    }

    await logAudit(req, "DELETE", id, existing, null);

    // Xóa cache để danh sách được cập nhật
    clearCacheForResource("communities");

    return res.status(200).json({ message: "Community deleted successfully" });
  } catch (error) {
    console.error("deleteCommunity error:", error.message);
    return res.status(500).json({ message: "Failed to delete community" });
  }
};

const getCommunityMembers = async (req, res) => {
  try {
    const { id } = req.params;
    const community = await CommunityModel.findById(id);
    if (!community) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to view this community's members",
      });
    }

    const members = await CommunityModel.getMembersList(id);
    return res.status(200).json({ members });
  } catch (error) {
    console.error("getCommunityMembers error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to fetch community members" });
  }
};

// Add member to community
const addMember = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      sister_id,
      role,
      start_date,
      end_date,
      decision_number,
      notes,
      is_primary,
    } = req.body;

    // Check if community exists
    const community = await CommunityModel.findById(id);
    if (!community) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to add members to this community",
      });
    }

    // Validate required fields
    if (!sister_id) {
      return res.status(400).json({ message: "Sister ID is required" });
    }

    // Get file URL if uploaded
    let decision_file_url = null;
    if (req.file) {
      const uploadResult = await uploadToFirebase(req.file, "decisions");
      decision_file_url = uploadResult.url;
    }

    // Create assignment
    const assignmentData = {
      sister_id,
      community_id: id,
      role: role || "member",
      start_date: start_date || new Date().toISOString().split("T")[0],
      // Convert empty string to null for end_date
      end_date: end_date === "" ? null : end_date || null,
      decision_number: decision_number || null,
      decision_file_url: decision_file_url,
      notes: notes || null,
    };

    const newAssignment = await CommunityAssignmentModel.create(assignmentData);

    await logAudit(req, "ADD_MEMBER", id, null, newAssignment);
    clearCacheForResource("communities");

    return res.status(201).json({
      success: true,
      message: "Member added successfully",
      data: newAssignment,
    });
  } catch (error) {
    console.error("addMember error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to add member", error: error.message });
  }
};

// Remove member from community
const removeMember = async (req, res) => {
  try {
    const { id, memberId } = req.params;

    // Check if community exists
    const community = await CommunityModel.findById(id);
    if (!community) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message:
          "You don't have permission to remove members from this community",
      });
    }

    // Check if assignment exists
    const assignment = await CommunityAssignmentModel.findById(memberId);
    if (!assignment) {
      return res.status(404).json({ message: "Assignment not found" });
    }

    // Delete assignment
    await CommunityAssignmentModel.delete(memberId);

    await logAudit(req, "REMOVE_MEMBER", id, assignment, null);
    clearCacheForResource("communities");

    return res.status(200).json({
      success: true,
      message: "Member removed successfully",
    });
  } catch (error) {
    console.error("removeMember error:", error.message);
    return res.status(500).json({ message: "Failed to remove member" });
  }
};

// Update member role in community
const updateMemberRole = async (req, res) => {
  try {
    const { id, memberId } = req.params;
    const { role, start_date, end_date, decision_number, notes } = req.body;

    // Check if community exists
    const community = await CommunityModel.findById(id);
    if (!community) {
      return res.status(404).json({ message: "Community not found" });
    }

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message:
          "You don't have permission to update members in this community",
      });
    }

    // Check if assignment exists
    const assignment = await CommunityAssignmentModel.findById(memberId);
    if (!assignment) {
      return res.status(404).json({ message: "Assignment not found" });
    }

    // Update assignment
    const updateData = {};
    if (role !== undefined) updateData.role = role;
    if (start_date !== undefined) updateData.start_date = start_date;
    // Convert empty string to null for end_date
    if (end_date !== undefined) {
      updateData.end_date = end_date === "" ? null : end_date;
    }
    if (decision_number !== undefined)
      updateData.decision_number = decision_number;
    if (notes !== undefined) updateData.notes = notes;

    // Get file URL if uploaded
    if (req.file) {
      const uploadResult = await uploadToFirebase(req.file, "decisions");
      updateData.decision_file_url = uploadResult.url;
    }

    const updatedAssignment = await CommunityAssignmentModel.update(
      memberId,
      updateData,
    );

    await logAudit(req, "UPDATE_MEMBER", id, assignment, updatedAssignment);
    clearCacheForResource("communities");

    return res.status(200).json({
      success: true,
      message: "Member updated successfully",
      data: updatedAssignment,
    });
  } catch (error) {
    console.error("updateMemberRole error:", error.message);
    return res.status(500).json({ message: "Failed to update member" });
  }
};

const getCommunityEvents = async (req, res) => {
  try {
    const { id } = req.params;

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to view events in this community",
      });
    }

    // 1. Fetch manual events
    const manualEventModel = new CommunityEventModel();
    const manualEvents = await manualEventModel.executeQuery(
      "SELECT * FROM community_events WHERE community_id = ? ORDER BY event_date DESC",
      [id],
    );

    // 2. Fetch assignments for "auto" events
    const assignments = await CommunityAssignmentModel.executeQuery(
      `SELECT ca.*, s.birth_name, s.saint_name 
       FROM community_assignments ca
       JOIN sisters s ON ca.sister_id = s.id
       WHERE ca.community_id = ?`,
      [id],
    );

    // 2.1 Fetch Vocation Journey assignments (Sisters assigned via Journey)
    const journeyAssignments = await CommunityModel.executeQuery(
      `SELECT vj.*, s.birth_name, s.saint_name 
       FROM vocation_journey vj
       JOIN sisters s ON vj.sister_id = s.id
       WHERE vj.community_id = ?`,
      [id],
    );

    const autoEvents = [];
    // Combine sister IDs from assignments AND vocation journeys
    const assignedSisterIds = assignments.map((a) => a.sister_id);
    const journeySisterIds = journeyAssignments.map((a) => a.sister_id);
    const sisterIds = [...new Set([...assignedSisterIds, ...journeySisterIds])];

    // Helper to check if a date falls within any assignment period of the sister TO THIS COMMUNITY
    const isDateInCommunity = (sisterId, dateStr) => {
      if (!dateStr) return false;
      const date = new Date(dateStr);

      // Check community_assignments
      const sisterAssignments = assignments.filter(
        (a) => a.sister_id === sisterId,
      );
      const inAssignment = sisterAssignments.some((a) => {
        const start = new Date(a.start_date);
        const end = a.end_date ? new Date(a.end_date) : new Date("9999-12-31");
        return date >= start && date <= end;
      });
      if (inAssignment) return true;

      // Check vocation_journey assignments
      const sisterJourneys = journeyAssignments.filter(
        (a) => a.sister_id === sisterId,
      );
      const inJourney = sisterJourneys.some((a) => {
        const start = new Date(a.start_date);
        const end = a.end_date ? new Date(a.end_date) : new Date("9999-12-31");
        return date >= start && date <= end;
      });
      return inJourney;
    };

    if (sisterIds.length > 0) {
      // Prepare IDs for SQL IN clause
      const idPlaceholders = sisterIds.map(() => "?").join(",");

      // 2.2 Fetch Education
      const educations = await CommunityModel.executeQuery(
        `SELECT e.*, s.birth_name, s.saint_name 
         FROM education e
         JOIN sisters s ON e.sister_id = s.id
         WHERE e.sister_id IN (${idPlaceholders})`,
        sisterIds,
      );

      educations.forEach((edu) => {
        const name = `${edu.saint_name ? edu.saint_name + " " : ""}${
          edu.birth_name
        }`;
        // Education Start
        if (
          edu.start_date &&
          isDateInCommunity(edu.sister_id, edu.start_date)
        ) {
          autoEvents.push({
            id: `edu-start-${edu.id}`,
            community_id: parseInt(id),
            title: `Học vấn - Bắt đầu: ${name}`,
            description: `${edu.level}${
              edu.major ? " - " + edu.major : ""
            } tại ${edu.institution || "CS Đào tạo"}`,
            event_date: edu.start_date,
            type: "auto",
            category: "education",
          });
        }
        // Education End
        if (edu.end_date && isDateInCommunity(edu.sister_id, edu.end_date)) {
          autoEvents.push({
            id: `edu-end-${edu.id}`,
            community_id: parseInt(id),
            title: `Học vấn - Hoàn thành: ${name}`,
            description: `${edu.level}${
              edu.major ? " - " + edu.major : ""
            } tại ${edu.institution || "CS Đào tạo"}`,
            event_date: edu.end_date,
            type: "auto",
            category: "education",
          });
        }
      });

      // 2.3 Fetch Missions
      const missions = await CommunityModel.executeQuery(
        `SELECT m.*, s.birth_name, s.saint_name 
         FROM missions m
         JOIN sisters s ON m.sister_id = s.id
         WHERE m.sister_id IN (${idPlaceholders})`,
        sisterIds,
      );

      missions.forEach((miss) => {
        const name = `${miss.saint_name ? miss.saint_name + " " : ""}${
          miss.birth_name
        }`;
        const fieldMap = {
          education: "Giáo dục",
          pastoral: "Mục vụ",
          publishing: "Xuất bản",
          media: "Truyền thông",
          healthcare: "Y tế",
          social: "Xã hội",
        };
        const fieldName = fieldMap[miss.field] || miss.field;

        // Mission Start
        if (
          miss.start_date &&
          isDateInCommunity(miss.sister_id, miss.start_date)
        ) {
          autoEvents.push({
            id: `miss-start-${miss.id}`,
            community_id: parseInt(id),
            title: `Sứ vụ - Bắt đầu: ${name}`,
            description: `${fieldName}. Vai trò: ${
              miss.specific_role || "Thành viên"
            }`,
            event_date: miss.start_date,
            type: "auto",
            category: "mission",
          });
        }
        // Mission End
        if (miss.end_date && isDateInCommunity(miss.sister_id, miss.end_date)) {
          autoEvents.push({
            id: `miss-end-${miss.id}`,
            community_id: parseInt(id),
            title: `Sứ vụ - Kết thúc: ${name}`,
            description: `${fieldName}. Vai trò: ${
              miss.specific_role || "Thành viên"
            }`,
            event_date: miss.end_date,
            type: "auto",
            category: "mission",
          });
        }
      });

      // 2.4 Fetch Health Records
      const healths = await CommunityModel.executeQuery(
        `SELECT h.*, s.birth_name, s.saint_name 
         FROM health_records h
         JOIN sisters s ON h.sister_id = s.id
         WHERE h.sister_id IN (${idPlaceholders})`,
        sisterIds,
      );

      healths.forEach((hlth) => {
        const name = `${hlth.saint_name ? hlth.saint_name + " " : ""}${
          hlth.birth_name
        }`;
        if (
          hlth.checkup_date &&
          isDateInCommunity(hlth.sister_id, hlth.checkup_date)
        ) {
          autoEvents.push({
            id: `health-${hlth.id}`,
            community_id: parseInt(id),
            title: `Sức khỏe - Khám bệnh: ${name}`,
            description: `Tình trạng: ${
              hlth.general_health === "good"
                ? "Tốt"
                : hlth.general_health === "average"
                  ? "Trung bình"
                  : "Yếu"
            }. ${hlth.diagnosis ? "Chẩn đoán: " + hlth.diagnosis : ""}`,
            event_date: hlth.checkup_date,
            type: "auto",
            category: "health",
          });
        }
      });

      // 2.5 Fetch Training Courses
      const courses = await CommunityModel.executeQuery(
        `SELECT t.*, s.birth_name, s.saint_name 
         FROM training_courses t
         JOIN sisters s ON t.sister_id = s.id
         WHERE t.sister_id IN (${idPlaceholders})`,
        sisterIds,
      );

      courses.forEach((course) => {
        const name = `${course.saint_name ? course.saint_name + " " : ""}${
          course.birth_name
        }`;
        if (
          course.start_date &&
          isDateInCommunity(course.sister_id, course.start_date)
        ) {
          autoEvents.push({
            id: `course-${course.id}`,
            community_id: parseInt(id),
            title: `Đào tạo - Khóa học: ${name}`,
            description: `${course.course_name}. ${
              course.organizer ? "TC: " + course.organizer : ""
            }`,
            event_date: course.start_date,
            type: "auto",
            category: "education", // Group with education
          });
        }
      });

      // 2.6 Fetch Vocation Journey (Stages/Vows)
      const stages = await CommunityModel.executeQuery(
        `SELECT v.*, s.birth_name, s.saint_name 
         FROM vocation_journey v
         JOIN sisters s ON v.sister_id = s.id
         WHERE v.sister_id IN (${idPlaceholders})`,
        sisterIds,
      );

      const stageMap = {
        inquiry: "Tìm hiểu",
        postulant: "Thỉnh sinh",
        aspirant: "Thanh tuyển",
        novice: "Tập viện",
        temporary_vows: "Khấn tạm",
        perpetual_vows: "Khấn trọn",
        left: "Hồi tục",
      };

      stages.forEach((stage) => {
        const name = `${stage.saint_name ? stage.saint_name + " " : ""}${
          stage.birth_name
        }`;

        // IMPORTANT: If this stage IS the assignment to this community, mark it as proper Arrival/Departure
        const isAssignmentToThisCommunity = stage.community_id === parseInt(id);

        if (
          stage.start_date &&
          (isAssignmentToThisCommunity ||
            isDateInCommunity(stage.sister_id, stage.start_date))
        ) {
          autoEvents.push({
            id: `stage-${stage.id}`,
            community_id: parseInt(id),
            title: `${isAssignmentToThisCommunity ? "Thuyên chuyển đến - " : "Ơn gọi - "}${stageMap[stage.stage] || stage.stage}: ${name}`,
            description: `Bắt đầu giai đoạn ${
              stageMap[stage.stage] || stage.stage
            }${isAssignmentToThisCommunity ? " tại cộng đoàn" : ""}`,
            event_date: stage.start_date,
            type: "auto",
            category: isAssignmentToThisCommunity ? "arrival" : "mission",
          });
        }
        // Handle End Date (Departure or just end of stage)
        if (
          stage.end_date &&
          (isAssignmentToThisCommunity ||
            isDateInCommunity(stage.sister_id, stage.end_date))
        ) {
          autoEvents.push({
            id: `stage-end-${stage.id}`,
            community_id: parseInt(id),
            title: `${isAssignmentToThisCommunity ? "Thuyên chuyển đi - " : "Kết thúc - "}${stageMap[stage.stage] || stage.stage}: ${name}`,
            description: `Kết thúc giai đoạn ${
              stageMap[stage.stage] || stage.stage
            }`,
            event_date: stage.end_date,
            type: "auto",
            category: isAssignmentToThisCommunity ? "departure" : "mission",
          });
        }
      });
    }

    assignments.forEach((assign) => {
      const name = `${
        assign.saint_name ? assign.saint_name + " " : ""
      }${assign.birth_name}`;

      // Arrival event
      if (assign.start_date) {
        autoEvents.push({
          id: `arrival-${assign.id}`,
          community_id: assign.community_id,
          title: `Thuyên chuyển đến: ${name}`,
          description: `Nữ tu ${name} được bài sai đến cộng đoàn.${
            assign.role ? " Vai trò: " + assign.role : ""
          }`,
          event_date: assign.start_date,
          type: "auto",
          category: "arrival",
        });
      }

      // Departure event
      if (assign.end_date) {
        autoEvents.push({
          id: `departure-${assign.id}`,
          community_id: assign.community_id,
          title: `Thuyên chuyển đi: ${name}`,
          description: `Nữ tu ${name} kết thúc bài sai tại cộng đoàn.`,
          event_date: assign.end_date,
          type: "auto",
          category: "departure",
        });
      }
    });

    // Merge and sort
    const allEvents = [
      ...manualEvents.map((e) => ({ ...e, type: "manual" })),
      ...autoEvents,
    ];
    allEvents.sort((a, b) => new Date(b.event_date) - new Date(a.event_date));

    return res.json({ success: true, data: allEvents });
  } catch (error) {
    console.error("getCommunityEvents error:", error.message);
    return res.status(500).json({
      message: "Failed to fetch community events",
      error: error.message,
    });
  }
};

const addCommunityEvent = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, event_date } = req.body;

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to add events to this community",
      });
    }

    if (!title || !event_date) {
      return res.status(400).json({
        success: false,
        message: "Title and event date are required",
      });
    }

    const eventModel = new CommunityEventModel();
    const newEvent = await eventModel.create({
      community_id: id,
      title,
      description,
      event_date,
    });

    // Log audit
    await logAudit(req, "ADD_EVENT", id, null, { id: newEvent.id, title });

    return res.json({ success: true, data: newEvent });
  } catch (error) {
    console.error("addCommunityEvent error:", error.message);
    return res.status(500).json({ message: "Failed to add community event" });
  }
};

const deleteCommunityEvent = async (req, res) => {
  try {
    const { id, eventId } = req.params;

    // Check scope access
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "communities",
      async () => id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message:
          "You don't have permission to delete events from this community",
      });
    }

    const eventModel = new CommunityEventModel();
    const event = await eventModel.findById(eventId);
    if (!event) {
      return res.status(404).json({ message: "Event not found" });
    }

    // Ensure event belongs to community
    if (String(event.community_id) !== String(id)) {
      return res
        .status(400)
        .json({ message: "Event does not belong to this community" });
    }

    await eventModel.delete(eventId);

    // Log audit
    await logAudit(req, "DELETE_EVENT", id, event, null);

    return res.json({ success: true, message: "Event deleted successfully" });
  } catch (error) {
    console.error("deleteCommunityEvent error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to delete community event" });
  }
};

module.exports = {
  getAllCommunities,
  getCommunityById,
  createCommunity,
  updateCommunity,
  deleteCommunity,
  getCommunityMembers,
  addMember,
  removeMember,
  updateMemberRole,
  getCommunityEvents,
  addCommunityEvent,
  deleteCommunityEvent,
};
