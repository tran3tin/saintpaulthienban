const MissionModel = require("../models/MissionModel");
const SisterModel = require("../models/SisterModel");
const AuditLogModel = require("../models/AuditLogModel");
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
      table_name: "missions",
      record_id: recordId,
      old_value: oldValue ? JSON.stringify(oldValue) : null,
      new_value: newValue ? JSON.stringify(newValue) : null,
      ip_address: req.ip,
    });
  } catch (error) {
    console.error("Mission audit log failed:", error.message);
  }
};

const getAllMissions = async (req, res) => {
  try {
    const { field, search, status, page = 1, limit = 20 } = req.query;
    const whereClauses = [];
    const params = [];

    // Filter by field
    if (field) {
      whereClauses.push("m.field = ?");
      params.push(field);
    }

    // Filter by status (active/completed based on end_date)
    if (status === "active") {
      whereClauses.push("(m.end_date IS NULL OR m.end_date >= CURRENT_DATE)");
    } else if (status === "completed") {
      whereClauses.push(
        "(m.end_date IS NOT NULL AND m.end_date < CURRENT_DATE)",
      );
    }

    // Search across multiple fields
    if (search && search.trim()) {
      const searchPattern = `%${search.trim()}%`;
      whereClauses.push(`(
        s.saint_name LIKE ? 
        OR s.birth_name LIKE ?
        OR CONCAT(COALESCE(s.saint_name, ''), ' ', COALESCE(s.birth_name, '')) LIKE ?
        OR m.specific_role LIKE ?
        OR m.field LIKE ?
        OR m.notes LIKE ?
      )`);
      params.push(
        searchPattern,
        searchPattern,
        searchPattern,
        searchPattern,
        searchPattern,
        searchPattern,
      );
    }

    // Apply data scope filter - missions are related to sisters via vocation_journey
    const { whereClause: scopeWhere, params: scopeParams } = applyScopeFilter(
      req.userScope,
      "s",
      {
        communityJoinTable: "vocation_journey",
        communityJoinColumn: "sister_id",
        communityIdColumn: "vj_scope.community_id",
        currentOnly: false,
        useJoin: true,
      },
    );

    let joinClause = "";
    if (scopeWhere) {
      joinClause = `
        LEFT JOIN (
          SELECT vj1.sister_id, vj1.community_id
          FROM vocation_journey vj1
          WHERE vj1.id = (
            SELECT vj2.id 
            FROM vocation_journey vj2 
            WHERE vj2.sister_id = vj1.sister_id 
            ORDER BY 
              CASE WHEN vj2.end_date IS NULL THEN 0 ELSE 1 END,
              vj2.start_date DESC,
              vj2.id DESC
            LIMIT 1
          )
        ) vj_scope ON s.id = vj_scope.sister_id
      `;
      whereClauses.push(scopeWhere);
      params.push(...scopeParams);
    }

    const whereClause = whereClauses.length
      ? `WHERE ${whereClauses.join(" AND ")}`
      : "";

    // Get total count for pagination
    const countQuery = `
      SELECT COUNT(*) as total
      FROM missions m
      INNER JOIN sisters s ON s.id = m.sister_id
      ${joinClause}
      ${whereClause}
    `;
    const countResult = await MissionModel.executeQuery(countQuery, params);
    const total = countResult[0]?.total || 0;

    // Get paginated results
    const offset = (parseInt(page) - 1) * parseInt(limit);
    const missions = await MissionModel.executeQuery(
      `SELECT m.*, s.saint_name as religious_name, s.birth_name, s.birth_name as sister_name
       FROM missions m
       INNER JOIN sisters s ON s.id = m.sister_id
       ${joinClause}
       ${whereClause}
       ORDER BY m.start_date DESC
       LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), offset],
    );

    return res.status(200).json({
      data: missions,
      total,
      page: parseInt(page),
      limit: parseInt(limit),
      totalPages: Math.ceil(total / parseInt(limit)),
    });
  } catch (error) {
    console.error("getAllMissions error:", error.message);
    return res.status(500).json({ message: "Failed to fetch missions" });
  }
};

const getMissionsBySister = async (req, res) => {
  try {
    const { sisterId } = req.params;
    const sister = await SisterModel.findById(sisterId);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access for the sister
    const hasAccess = await checkScopeAccess(
      req.userScope,
      sisterId,
      "sisters",
      async (sisterRecord) => sisterRecord.current_community_id,
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to view this sister's missions",
      });
    }

    const missions = await MissionModel.findBySisterId(sisterId);
    return res
      .status(200)
      .json({ sister: { id: sister.id, code: sister.code }, missions });
  } catch (error) {
    console.error("getMissionsBySister error:", error.message);
    return res.status(500).json({ message: "Failed to fetch missions" });
  }
};

const getMissionById = async (req, res) => {
  try {
    const { id } = req.params;
    const missions = await MissionModel.executeQuery(
      `SELECT m.*, 
              s.saint_name AS sister_saint_name,
              s.birth_name AS sister_name,
              s.code AS sister_code,
              s.date_of_birth AS sister_birth_date,
              s.phone AS sister_phone,
              s.email AS sister_email,
              s.photo_url AS sister_avatar,
              (
                SELECT c2.name 
                FROM vocation_journey vj2 
                LEFT JOIN communities c2 ON vj2.community_id = c2.id
                WHERE vj2.sister_id = s.id 
                  AND vj2.end_date IS NULL
                  AND vj2.community_id IS NOT NULL
                LIMIT 1
              ) as sister_community
       FROM missions m
       INNER JOIN sisters s ON s.id = m.sister_id
       WHERE m.id = ?`,
      [id],
    );

    if (!missions || missions.length === 0) {
      return res.status(404).json({ message: "Mission not found" });
    }

    // Parse documents JSON string to array
    const missionData = missions[0];
    if (missionData.documents) {
      try {
        missionData.documents =
          typeof missionData.documents === "string"
            ? JSON.parse(missionData.documents)
            : missionData.documents;
      } catch (e) {
        missionData.documents = [];
      }
    } else {
      missionData.documents = [];
    }

    return res.status(200).json({ data: missionData });
  } catch (error) {
    console.error("getMissionById error:", error.message);
    console.error("getMissionById stack:", error.stack);
    return res.status(500).json({ message: "Failed to fetch mission" });
  }
};

const createMission = async (req, res) => {
  try {
    const {
      sister_id: sisterId,
      field,
      specific_role: specificRole,
      organization,
      address,
      start_date: startDate,
      end_date: endDate,
      notes,
      documents,
    } = req.body;

    const normalizedEndDate = endDate ? endDate : null;

    if (!sisterId || !field || !startDate) {
      return res
        .status(400)
        .json({ message: "sister_id, field, start_date are required" });
    }

    const sister = await SisterModel.findById(sisterId);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Validate date range
    if (
      normalizedEndDate &&
      new Date(normalizedEndDate) < new Date(startDate)
    ) {
      return res
        .status(400)
        .json({ message: "end_date must be after start_date" });
    }

    const payload = {
      sister_id: sisterId,
      field,
      specific_role: specificRole || null,
      organization: organization || null,
      address: address || null,
      start_date: startDate,
      end_date: normalizedEndDate,
      notes: notes || null,
      documents: documents ? JSON.stringify(documents) : null,
    };

    const created = await MissionModel.create(payload);

    try {
      await logAudit(req, "CREATE", created.id, null, created);
    } catch (logErr) {
      console.error("Audit log failed but mission created:", logErr);
    }

    return res.status(201).json({ mission: created });
  } catch (error) {
    console.error("createMission error full:", error);
    return res.status(500).json({
      message: "Failed to create mission: " + error.message,
      stack: process.env.NODE_ENV === "development" ? error.stack : undefined,
    });
  }
};

const updateMission = async (req, res) => {
  try {
    const { id } = req.params;
    const existingRows = await MissionModel.executeQuery(
      "SELECT * FROM missions WHERE id = ?",
      [id],
    );
    const mission = existingRows[0];
    if (!mission) {
      return res.status(404).json({ message: "Mission not found" });
    }

    // Check scope access - check if user has access to the sister of this mission
    const sister = await SisterModel.findById(mission.sister_id);
    if (sister) {
      const hasAccess = await checkScopeAccess(
        req.userScope,
        mission.sister_id,
        "sisters",
        async (sisterRecord) => sisterRecord.current_community_id,
      );

      if (!hasAccess) {
        return res.status(403).json({
          success: false,
          message: "You don't have permission to update this mission",
        });
      }
    }

    const allowedFields = [
      "sister_id",
      "field",
      "specific_role",
      "organization",
      "address",
      "start_date",
      "end_date",
      "notes",
      "documents",
    ];

    const payload = {};
    allowedFields.forEach((field) => {
      if (req.body[field] !== undefined) {
        // Convert documents array to JSON string for storage
        if (field === "documents") {
          payload[field] = req.body[field]
            ? JSON.stringify(req.body[field])
            : null;
        } else {
          payload[field] = req.body[field];
        }
      }
    });

    if (payload.end_date === "") {
      payload.end_date = null;
    }

    if (!Object.keys(payload).length) {
      return res
        .status(400)
        .json({ message: "No valid fields provided to update" });
    }

    const startForValidation = payload.start_date ?? mission.start_date;
    const endForValidation = payload.end_date ?? mission.end_date;

    if (startForValidation && endForValidation) {
      if (new Date(endForValidation) < new Date(startForValidation)) {
        return res
          .status(400)
          .json({ message: "end_date must be after start_date" });
      }
    }

    if (payload.sister_id) {
      const sister = await SisterModel.findById(payload.sister_id);
      if (!sister) {
        return res.status(404).json({ message: "Sister not found" });
      }
    }

    const updated = await MissionModel.update(id, payload);
    await logAudit(req, "UPDATE", id, mission, updated);

    return res.status(200).json({ mission: updated });
  } catch (error) {
    console.error("updateMission error:", error.message);
    return res.status(500).json({ message: "Failed to update mission" });
  }
};

const endMission = async (req, res) => {
  try {
    const { id } = req.params;
    const existingRows = await MissionModel.executeQuery(
      "SELECT * FROM missions WHERE id = ?",
      [id],
    );
    const mission = existingRows[0];
    if (!mission) {
      return res.status(404).json({ message: "Mission not found" });
    }

    // Check scope access
    const sister = await SisterModel.findById(mission.sister_id);
    if (sister) {
      const hasAccess = await checkScopeAccess(
        req.userScope,
        mission.sister_id,
        "sisters",
        async (sisterRecord) => sisterRecord.current_community_id,
      );

      if (!hasAccess) {
        return res.status(403).json({
          success: false,
          message: "You don't have permission to end this mission",
        });
      }
    }

    const { end_date: endDate } = req.body;
    const finalDate = endDate || new Date().toISOString().split("T")[0];

    const updated = await MissionModel.update(id, { end_date: finalDate });
    await logAudit(req, "UPDATE", id, mission, updated);

    return res.status(200).json({ mission: updated });
  } catch (error) {
    console.error("endMission error:", error.message);
    return res.status(500).json({ message: "Failed to end mission" });
  }
};

const getSistersByMissionField = async (req, res) => {
  try {
    const { field } = req.params;
    if (!field) {
      return res.status(400).json({ message: "Mission field is required" });
    }

    const whereClauses = [
      "m.field = ?",
      "(m.end_date IS NULL OR m.end_date >= CURRENT_DATE)",
    ];
    const params = [field];

    // Apply data scope filter via vocation_journey
    const { whereClause: scopeWhere, params: scopeParams } = applyScopeFilter(
      req.userScope,
      "s",
      {
        communityJoinTable: "vocation_journey",
        communityJoinColumn: "sister_id",
        communityIdColumn: "vj_scope.community_id",
        currentOnly: false,
        useJoin: true,
      },
    );

    let joinClause = "";
    if (scopeWhere) {
      joinClause = `
        LEFT JOIN (
          SELECT vj1.sister_id, vj1.community_id
          FROM vocation_journey vj1
          WHERE vj1.id = (
            SELECT vj2.id 
            FROM vocation_journey vj2 
            WHERE vj2.sister_id = vj1.sister_id 
            ORDER BY 
              CASE WHEN vj2.end_date IS NULL THEN 0 ELSE 1 END,
              vj2.start_date DESC,
              vj2.id DESC
            LIMIT 1
          )
        ) vj_scope ON s.id = vj_scope.sister_id
      `;
      whereClauses.push(scopeWhere);
      params.push(...scopeParams);
    }

    const whereClause = `WHERE ${whereClauses.join(" AND ")}`;

    const sisters = await MissionModel.executeQuery(
      `SELECT DISTINCT s.id, s.code, s.religious_name, m.field
       FROM missions m
       INNER JOIN sisters s ON s.id = m.sister_id
       ${joinClause}
       ${whereClause}
       ORDER BY s.religious_name`,
      params,
    );

    return res.status(200).json({ data: sisters });
  } catch (error) {
    console.error("getSistersByMissionField error:", error.message);
    return res
      .status(500)
      .json({ message: "Failed to fetch mission field data" });
  }
};

const deleteMission = async (req, res) => {
  try {
    const { id } = req.params;
    const existingRows = await MissionModel.executeQuery(
      "SELECT * FROM missions WHERE id = ?",
      [id],
    );
    const mission = existingRows[0];
    if (!mission) {
      return res.status(404).json({ message: "Mission not found" });
    }

    await MissionModel.delete(id);
    await logAudit(req, "DELETE", id, mission, null);

    return res.status(200).json({ message: "Mission deleted successfully" });
  } catch (error) {
    console.error("deleteMission error:", error.message);
    return res.status(500).json({ message: "Failed to delete mission" });
  }
};

module.exports = {
  getAllMissions,
  getMissionsBySister,
  getMissionById,
  createMission,
  updateMission,
  deleteMission,
  endMission,
  getSistersByMissionField,
};
