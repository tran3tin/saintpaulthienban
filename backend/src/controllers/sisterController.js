const fs = require("fs");
const path = require("path");
const SisterModel = require("../models/SisterModel");
const { uploadToFirebase } = require("./uploadController");
const VocationJourneyModel = require("../models/VocationJourneyModel");
const CommunityAssignmentModel = require("../models/CommunityAssignmentModel");
const MissionModel = require("../models/MissionModel");
const AuditLogModel = require("../models/AuditLogModel");
const {
  applyScopeFilter,
  checkScopeAccess,
  getSisterCommunityIds,
} = require("../utils/scopeHelper");

const UPLOADS_ROOT = path.resolve(__dirname, "../uploads");

const permittedViewerRoles = [
  "admin",
  "superior_general",
  "superior_provincial",
  "superior_community",
  "secretary",
  "viewer",
];
const permittedEditorRoles = [
  "admin",
  "superior_general",
  "superior_provincial",
  "superior_community",
  "secretary",
];

const ensurePermission = (req, res, allowedRoles) => {
  if (!req.user) {
    res.status(401).json({ message: "Unauthorized" });
    return false;
  }

  // Permission-based access control - no admin bypass
  // Actual permission checking done by checkPermission middleware in routes
  return true;
};

const getPagination = (req) => {
  const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || 20, 1), 100);
  const offset = (page - 1) * limit;
  return { page, limit, offset };
};

const generateSisterCode = async () => {
  try {
    const rows = await SisterModel.executeQuery(
      "SELECT code FROM sisters WHERE code LIKE 'NT-%' ORDER BY LENGTH(code) DESC, code DESC LIMIT 1"
    );

    let nextNum = 1;
    if (rows.length > 0 && rows[0].code) {
      const lastCode = rows[0].code;
      const parts = lastCode.split("-");
      if (parts.length === 2 && !isNaN(parts[1])) {
        nextNum = parseInt(parts[1], 10) + 1;
      }
    }

    return `NT-${String(nextNum).padStart(3, "0")}`;
  } catch (error) {
    console.error("Error generating sister code:", error);
    // Fallback to timestamp-based to ensure uniqueness if DB query fails
    return `NT-${Date.now()}`;
  }
};

const logAudit = async (req, action, recordId, oldValue, newValue) => {
  try {
    await AuditLogModel.create({
      user_id: req.user ? req.user.id : null,
      action,
      table_name: "sisters",
      record_id: recordId,
      old_value: oldValue ? JSON.stringify(oldValue) : null,
      new_value: newValue ? JSON.stringify(newValue) : null,
      ip_address: req.ip,
    });
  } catch (error) {
    console.error("Failed to log audit entry:", error.message);
  }
};

const buildFilters = ({
  status,
  search,
  minAge,
  maxAge,
  excludeLeft = false,
}) => {
  const clauses = [];
  const params = [];

  if (excludeLeft) {
    // Exclude records with status 'left' (show active only)
    clauses.push("status = 'active'");
  } else if (status) {
    clauses.push("status = ?");
    params.push(status);
  }

  if (search) {
    clauses.push("(birth_name LIKE ? OR saint_name LIKE ? OR code LIKE ?)");
    params.push(`%${search}%`, `%${search}%`, `%${search}%`);
  }

  if (Number.isInteger(minAge)) {
    clauses.push("EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))::INT >= ?");
    params.push(minAge);
  }

  if (Number.isInteger(maxAge)) {
    clauses.push("EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth))::INT <= ?");
    params.push(maxAge);
  }

  return { clauses, params };
};

const getAllSisters = async (req, res) => {
  try {
    const { page, limit, offset } = getPagination(req);
    const minAge = req.query.minAge
      ? parseInt(req.query.minAge, 10)
      : undefined;
    const maxAge = req.query.maxAge
      ? parseInt(req.query.maxAge, 10)
      : undefined;
    const search = req.query.search ? req.query.search.trim() : "";
    // By default, exclude 'left' sisters (show active only)
    const showAll = req.query.status === "all";
    const status = showAll ? "" : req.query.status || "";

    const { clauses, params } = buildFilters({
      status,
      search,
      minAge,
      maxAge,
      excludeLeft: !showAll && !req.query.status, // exclude 'left' by default
    });

    // Prefix clauses with 's.' for sisters table
    const prefixedClauses = clauses.map((clause) => {
      // Replace field names with s. prefix
      return clause
        .replace(/\bstatus\b/g, "s.status")
        .replace(/\bbirth_name\b/g, "s.birth_name")
        .replace(/\bsaint_name\b/g, "s.saint_name")
        .replace(/\bcode\b/g, "s.code")
        .replace(/\bdate_of_birth\b/g, "s.date_of_birth");
    });

    // Apply data scope filter - USE vocation_journey instead of community_assignments
    // Join with vocation_journey to get current community and filter by scope
    const {
      whereClause: scopeWhere,
      params: scopeParams,
      needsJoin,
    } = applyScopeFilter(req.userScope, "s", {
      communityJoinTable: "vocation_journey",
      communityJoinColumn: "sister_id",
      communityIdColumn: "vj_scope.community_id",
      currentOnly: false, // Use subquery to get latest journey
      useJoin: true,
    });

    console.log("[SisterController] userScope:", req.userScope);
    console.log("[SisterController] scopeWhere:", scopeWhere);
    console.log("[SisterController] scopeParams:", scopeParams);
    console.log("[SisterController] needsJoin:", needsJoin);

    // Build JOIN clause for vocation_journey if needed for scope filtering
    let joinClause = "";
    if (needsJoin && scopeWhere) {
      // Join ONLY with current vocation_journey (end_date IS NULL)
      joinClause = `
        INNER JOIN (
          SELECT sister_id, community_id
          FROM vocation_journey
          WHERE end_date IS NULL
        ) vj_scope ON s.id = vj_scope.sister_id
      `;
      prefixedClauses.push(scopeWhere);
      params.push(...scopeParams);
    } else if (scopeWhere) {
      prefixedClauses.push(scopeWhere);
      params.push(...scopeParams);
    }

    const whereClause = prefixedClauses.length
      ? `WHERE ${prefixedClauses.join(" AND ")}`
      : "";

    // Debug: Log the full query
    console.log("[SisterController] joinClause:", joinClause);
    console.log("[SisterController] whereClause:", whereClause);
    console.log("[SisterController] params:", params);

    const totalRows = await SisterModel.executeQuery(
      `SELECT COUNT(DISTINCT s.id) AS total FROM sisters s ${joinClause} ${whereClause}`,
      params
    );
    const total = totalRows[0] ? totalRows[0].total : 0;
    console.log("[SisterController] total sisters found:", total);

    // JOIN with communities and vocation_journey to get current stage and community
    // CHỈ lấy giai đoạn đang diễn ra (end_date IS NULL), không fallback về giai đoạn cũ
    const rows = await SisterModel.executeQuery(
      `SELECT DISTINCT s.*, 
              c.name AS current_community_name,
              vj_latest.stage AS current_stage_from_journey,
              vj_latest.community_id AS current_community_id_from_journey,
              c_journey.name AS current_community_name_from_journey
       FROM sisters s 
       ${joinClause}
       LEFT JOIN communities c ON s.current_community_id = c.id
       LEFT JOIN (
         SELECT sister_id, stage, community_id
         FROM vocation_journey
         WHERE end_date IS NULL
       ) vj_latest ON s.id = vj_latest.sister_id
       LEFT JOIN communities c_journey ON vj_latest.community_id = c_journey.id
       ${whereClause} 
       ORDER BY s.created_at DESC 
       LIMIT ? OFFSET ?`,
      [...params, limit, offset]
    );

    // Map the results to use journey data as primary source
    // current_community_name should ONLY come from vocation_journey, not from current_community_id
    // If sister has no vocation journey, community should be null/empty
    const mappedRows = rows.map((row) => ({
      ...row,
      current_stage: row.current_stage_from_journey || row.current_stage,
      // Only use community from vocation_journey, do NOT fallback to current_community_id
      current_community_name: row.current_community_name_from_journey || null,
    }));

    return res.status(200).json({
      success: true,
      data: mappedRows,
      meta: {
        total,
        page,
        totalPages: Math.ceil(total / limit) || 1,
        limit,
      },
    });
  } catch (error) {
    console.error("getAllSisters error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Failed to fetch sisters" });
  }
};

const getSisterById = async (req, res) => {
  try {
    const { id } = req.params;
    const sister = await SisterModel.findById(id);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get all communities from community_assignments
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to view this sister's details",
      });
    }

    const [profile, currentCommunity, currentMission] = await Promise.all([
      SisterModel.getFullProfile(id),
      CommunityAssignmentModel.getCurrentAssignment(id),
      MissionModel.executeQuery(
        `SELECT * FROM missions WHERE sister_id = ? AND (end_date IS NULL OR end_date >= CURRENT_DATE) ORDER BY start_date DESC LIMIT 1`,
        [id]
      ).then((rows) => rows[0] || null),
    ]);

    return res.status(200).json({
      success: true,
      data: {
        ...profile,
        currentCommunity,
        currentMission,
      },
    });
  } catch (error) {
    console.error("getSisterById error:", error.message);
    return res
      .status(500)
      .json({ success: false, message: "Failed to fetch sister detail" });
  }
};

const createSister = async (req, res) => {
  try {
    if (!ensurePermission(req, res, permittedEditorRoles)) {
      return;
    }

    const code = req.body.code || (await generateSisterCode());

    const payload = {
      ...req.body,
      code,
      status: req.body.status || "active",
      created_by: req.user ? req.user.id : null,
    };

    // Convert date fields from ISO format to MySQL DATE format (YYYY-MM-DD)
    const dateFields = [
      "date_of_birth",
      "id_card_date",
      "baptism_date",
      "confirmation_date",
      "first_communion_date",
    ];

    dateFields.forEach((field) => {
      if (payload[field]) {
        // Convert ISO date string to YYYY-MM-DD format
        const date = new Date(payload[field]);
        if (!isNaN(date.getTime())) {
          payload[field] = date.toISOString().split("T")[0];
        }
      }
    });

    // Convert documents array to JSON string if needed
    if (Array.isArray(payload.documents)) {
      payload.documents = JSON.stringify(payload.documents);
    }

    const newSister = await SisterModel.create(payload);
    await logAudit(req, "CREATE", newSister.id, null, newSister);

    return res.status(201).json({ success: true, data: newSister });
  } catch (error) {
    console.error("createSister error:", error.message);
    console.error("Full error:", error);
    console.error("Request body:", req.body);
    return res.status(500).json({
      success: false,
      message: "Failed to create sister",
      error: error.message,
    });
  }
};

const updateSister = async (req, res) => {
  try {
    const { id } = req.params;
    const existing = await SisterModel.findById(id);
    if (!existing) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get community from vocation_journey
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to update this sister",
      });
    }

    const allowedFields = [
      "code",
      "birth_name",
      "saint_name",
      "date_of_birth",
      "place_of_birth",
      "hometown",
      "permanent_address",
      "current_address",
      "nationality",
      "id_card",
      "id_card_date",
      "id_card_place",
      "father_name",
      "father_occupation",
      "mother_name",
      "mother_occupation",
      "siblings_count",
      "family_address",
      "family_religion",
      "baptism_date",
      "baptism_place",
      "confirmation_date",
      "first_communion_date",
      "phone",
      "email",
      "emergency_contact_name",
      "emergency_contact_phone",
      "photo_url",
      "documents",
      "notes",
      "status",
      "current_stage",
      "current_community_id",
      "created_by",
    ];

    const updateData = {};
    allowedFields.forEach((field) => {
      if (req.body[field] !== undefined) {
        updateData[field] = req.body[field];
      }
    });

    // Convert date fields from ISO format to MySQL DATE format (YYYY-MM-DD)
    const dateFields = [
      "date_of_birth",
      "id_card_date",
      "baptism_date",
      "confirmation_date",
      "first_communion_date",
    ];

    dateFields.forEach((field) => {
      if (updateData[field]) {
        // Convert ISO date string to YYYY-MM-DD format
        const date = new Date(updateData[field]);
        if (!isNaN(date.getTime())) {
          updateData[field] = date.toISOString().split("T")[0];
        }
      }
    });

    if (Array.isArray(req.body.documents)) {
      updateData.documents = JSON.stringify(req.body.documents);
    }

    if (
      Object.prototype.hasOwnProperty.call(updateData, "photo_url") &&
      updateData.photo_url &&
      typeof updateData.photo_url === "object"
    ) {
      console.warn(
        "updateSister: ignoring non-string photo_url payload",
        updateData.photo_url
      );
      delete updateData.photo_url;
    }

    if (Object.keys(updateData).length === 0) {
      return res
        .status(400)
        .json({ success: false, message: "No valid fields to update" });
    }

    const updated = await SisterModel.update(id, updateData);
    await logAudit(req, "UPDATE", id, existing, updated);

    return res.status(200).json({ success: true, data: updated });
  } catch (error) {
    console.error("updateSister error:", error.message, error.stack);
    return res.status(500).json({
      success: false,
      message: "Failed to update sister",
      error: error.message,
    });
  }
};

const deleteSister = async (req, res) => {
  try {
    const { id } = req.params;
    const sister = await SisterModel.findById(id);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get community from vocation_journey
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message: "You don't have permission to delete this sister",
      });
    }

    // Use 'left' status as defined in database ENUM('active','left')
    const leftStatus = "left";
    const updated = await SisterModel.update(id, { status: leftStatus });
    await logAudit(req, "DELETE", id, sister, updated);

    return res.status(200).json({ message: "Sister deactivated successfully" });
  } catch (error) {
    console.error("deleteSister error:", error.message);
    return res.status(500).json({ message: "Failed to deactivate sister" });
  }
};

const removeOldPhoto = (photoUrl) => {
  if (!photoUrl) {
    return;
  }

  try {
    const relativePath = photoUrl.startsWith("/uploads")
      ? photoUrl.replace("/uploads", "")
      : photoUrl;
    const absolutePath = path.join(UPLOADS_ROOT, relativePath);
    if (fs.existsSync(absolutePath)) {
      fs.unlinkSync(absolutePath);
    }
  } catch (error) {
    console.error("Failed to remove old photo:", error.message);
  }
};

const updateSisterPhoto = async (req, res) => {
  try {
    const { id } = req.params;

    console.log(`📸 Uploading photo for sister ID: ${id}`);
    console.log(
      `📁 File received:`,
      req.file
        ? {
            originalname: req.file.originalname,
            mimetype: req.file.mimetype,
            size: req.file.size,
            buffer: req.file.buffer ? "Buffer present" : "No buffer",
          }
        : "No file"
    );

    const sister = await SisterModel.findById(id);
    if (!sister) {
      console.error(`❌ Sister not found: ${id}`);
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get all communities from community_assignments
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      console.error(`❌ Access denied for sister ID: ${id}`);
      return res.status(403).json({
        success: false,
        message: "You don't have permission to update this sister's photo",
      });
    }

    if (!req.file) {
      console.error(`❌ No file in request`);
      return res.status(400).json({ message: "Photo file is required" });
    }

    // Upload to Firebase
    console.log(`🚀 Starting Firebase upload...`);
    const uploadResult = await uploadToFirebase(req.file, "photos");
    console.log(`✅ Firebase upload successful:`, uploadResult);

    const photoUrl = uploadResult.url;

    console.log(`💾 Updating database with photo URL...`);
    const updated = await SisterModel.update(id, { photo_url: photoUrl });
    await logAudit(req, "UPDATE", id, sister, updated);

    console.log(`✅ Photo update complete for sister ID: ${id}`);
    return res.status(200).json({ photoUrl });
  } catch (error) {
    console.error("❌ updateSisterPhoto error:", error);
    console.error("Error stack:", error.stack);
    return res.status(500).json({
      message: "Failed to update photo",
      error: error.message,
      details: process.env.NODE_ENV === "development" ? error.stack : undefined,
    });
  }
};

const uploadSisterDocuments = async (req, res) => {
  try {
    const { id } = req.params;
    const sister = await SisterModel.findById(id);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get all communities from community_assignments
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message:
          "You don't have permission to upload documents for this sister",
      });
    }

    if (!req.files || req.files.length === 0) {
      return res
        .status(400)
        .json({ message: "At least one document file is required" });
    }

    // Parse existing documents
    let existingDocs = [];
    if (sister.documents_url) {
      try {
        existingDocs = JSON.parse(sister.documents_url);
      } catch (e) {
        existingDocs = [];
      }
    }

    // Add new documents to Firebase
    const uploadPromises = req.files.map((file) =>
      uploadToFirebase(file, "documents")
    );
    const uploadResults = await Promise.all(uploadPromises);

    const newDocs = uploadResults.map((result) => ({
      name: result.originalName,
      url: result.url,
      uploadedAt: new Date().toISOString(),
    }));

    const allDocs = [...existingDocs, ...newDocs];
    const documentsUrl = JSON.stringify(allDocs);

    const updated = await SisterModel.update(id, {
      documents_url: documentsUrl,
    });
    await logAudit(req, "UPDATE", id, sister, updated);

    return res.status(200).json({
      documents: allDocs,
      message: `${newDocs.length} document(s) uploaded successfully`,
    });
  } catch (error) {
    console.error("uploadSisterDocuments error:", error.message);
    return res.status(500).json({ message: "Failed to upload documents" });
  }
};

const deleteSisterDocument = async (req, res) => {
  try {
    const { id, docIndex } = req.params;
    const sister = await SisterModel.findById(id);
    if (!sister) {
      return res.status(404).json({ message: "Sister not found" });
    }

    // Check scope access - use getSisterCommunityIds to get all communities from community_assignments
    const hasAccess = await checkScopeAccess(
      req.userScope,
      id,
      "sisters",
      getSisterCommunityIds
    );

    if (!hasAccess) {
      return res.status(403).json({
        success: false,
        message:
          "You don't have permission to delete documents for this sister",
      });
    }

    let documents = [];
    if (sister.documents_url) {
      try {
        documents = JSON.parse(sister.documents_url);
      } catch (e) {
        return res.status(400).json({ message: "Invalid documents data" });
      }
    }

    const index = parseInt(docIndex, 10);
    if (isNaN(index) || index < 0 || index >= documents.length) {
      return res.status(400).json({ message: "Invalid document index" });
    }

    // Remove file from disk
    const docToRemove = documents[index];
    if (docToRemove && docToRemove.url) {
      try {
        const relativePath = docToRemove.url.startsWith("/uploads")
          ? docToRemove.url.replace("/uploads", "")
          : docToRemove.url;
        const absolutePath = path.join(UPLOADS_ROOT, relativePath);
        if (fs.existsSync(absolutePath)) {
          fs.unlinkSync(absolutePath);
        }
      } catch (err) {
        console.error("Failed to remove document file:", err.message);
      }
    }

    // Remove from array
    documents.splice(index, 1);
    const documentsUrl = JSON.stringify(documents);

    const updated = await SisterModel.update(id, {
      documents_url: documentsUrl,
    });
    await logAudit(req, "UPDATE", id, sister, updated);

    return res.status(200).json({
      documents,
      message: "Document deleted successfully",
    });
  } catch (error) {
    console.error("deleteSisterDocument error:", error.message);
    return res.status(500).json({ message: "Failed to delete document" });
  }
};

const searchSisters = async (req, res) => {
  try {
    if (!ensurePermission(req, res, permittedViewerRoles)) {
      return;
    }

    const { page, limit, offset } = getPagination(req);
    const filters = [];
    const params = [];

    if (req.query.name) {
      filters.push(
        "(s.birth_name LIKE ? OR s.religious_name LIKE ? OR s.code LIKE ?)"
      );
      params.push(
        `%${req.query.name}%`,
        `%${req.query.name}%`,
        `%${req.query.name}%`
      );
    }

    if (req.query.code) {
      filters.push("s.code = ?");
      params.push(req.query.code);
    }

    if (req.query.community) {
      filters.push("ca.community_id = ?");
      params.push(req.query.community);
    }

    if (req.query.stage) {
      filters.push("vj.stage = ?");
      params.push(req.query.stage);
    }

    if (req.query.missionField) {
      filters.push("mi.field = ?");
      params.push(req.query.missionField);
    }

    // Default to 'active' if status is not provided
    if (req.query.status !== undefined) {
      if (req.query.status) {
        filters.push("s.status = ?");
        params.push(req.query.status);
      }
    } else {
      filters.push("s.status = 'active'");
    }

    const minAge = req.query.minAge
      ? parseInt(req.query.minAge, 10)
      : undefined;
    const maxAge = req.query.maxAge
      ? parseInt(req.query.maxAge, 10)
      : undefined;
    if (Number.isInteger(minAge)) {
      filters.push("EXTRACT(YEAR FROM AGE(CURRENT_DATE, s.date_of_birth))::INT >= ?");
      params.push(minAge);
    }
    if (Number.isInteger(maxAge)) {
      filters.push("EXTRACT(YEAR FROM AGE(CURRENT_DATE, s.date_of_birth))::INT <= ?");
      params.push(maxAge);
    }

    const whereClause = filters.length ? `WHERE ${filters.join(" AND ")}` : "";

    const baseQuery = `
      FROM sisters s
      LEFT JOIN community_assignments ca
        ON ca.sister_id = s.id AND (ca.end_date IS NULL OR ca.end_date >= CURRENT_DATE)
      LEFT JOIN vocation_journey vj
        ON vj.sister_id = s.id AND (vj.end_date IS NULL OR vj.end_date >= CURRENT_DATE)
      LEFT JOIN missions mi
        ON mi.sister_id = s.id AND (mi.end_date IS NULL OR mi.end_date >= CURRENT_DATE)
      ${whereClause}
    `;

    const totalRows = await SisterModel.executeQuery(
      `SELECT COUNT(DISTINCT s.id) AS total ${baseQuery}`,
      params
    );
    const total = totalRows[0] ? totalRows[0].total : 0;

    const data = await SisterModel.executeQuery(
      `SELECT DISTINCT s.* ${baseQuery} ORDER BY s.created_at DESC LIMIT ? OFFSET ?`,
      [...params, limit, offset]
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
    console.error("searchSisters error:", error.message);
    return res.status(500).json({ message: "Failed to search sisters" });
  }
};

module.exports = {
  getAllSisters,
  getSisterById,
  createSister,
  updateSister,
  updateSisterPhoto,
  uploadSisterDocuments,
  deleteSisterDocument,
  deleteSister,
  searchSisters,
};
