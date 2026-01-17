const PermissionModel = require("../models/PermissionModel");
const UserPermissionModel = require("../models/UserPermissionModel");
const AuditLogModel = require("../models/AuditLogModel");

// Helper to ensure user is authenticated
const ensureAuthenticated = (req, res) => {
  if (!req.user) {
    res.status(401).json({ message: "Unauthorized" });
    return false;
  }
  return true;
};

// Helper to ensure user has permission management access
const ensureAdmin = (req, res) => {
  if (!ensureAuthenticated(req, res)) {
    return false;
  }

  // Admin bypass - admins can access all permission management
  if (req.user.is_admin === 1 || req.user.role === "admin" || req.user.role === "superior_general") {
    return true;
  }

  // Permission-based check - user must have users.manage_permissions permission
  if (
    !req.user.permissions ||
    !req.user.permissions.includes("users.manage_permissions")
  ) {
    res
      .status(403)
      .json({
        message: "Permission denied - requires users.manage_permissions",
      });
    return false;
  }

  return true;
};

// Get all permissions grouped by module
const getAllPermissions = async (req, res) => {
  try {
    if (!ensureAdmin(req, res)) {
      return;
    }

    const permissions = await PermissionModel.getAllGroupedByModule();

    return res.status(200).json({
      success: true,
      data: permissions,
    });
  } catch (error) {
    console.error("getAllPermissions error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải danh sách quyền",
    });
  }
};

// Get permissions by module
const getPermissionsByModule = async (req, res) => {
  try {
    if (!ensureAdmin(req, res)) {
      return;
    }

    const { module } = req.params;
    const permissions = await PermissionModel.getByModule(module);

    return res.status(200).json({
      success: true,
      data: permissions,
    });
  } catch (error) {
    console.error("getPermissionsByModule error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải quyền theo module",
    });
  }
};

// Get current user's permissions
const getMyPermissions = async (req, res) => {
  try {
    if (!ensureAuthenticated(req, res)) {
      return;
    }

    const permissions = await UserPermissionModel.getUserPermissions(
      req.user.id
    );
    const permissionCodes = await UserPermissionModel.getUserPermissionCodes(
      req.user.id
    );

    return res.status(200).json({
      success: true,
      data: {
        permissions,
        codes: permissionCodes,
      },
    });
  } catch (error) {
    console.error("getMyPermissions error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi tải quyền của bạn",
    });
  }
};

// Check if current user has a specific permission
const checkPermission = async (req, res) => {
  try {
    if (!ensureAuthenticated(req, res)) {
      return;
    }

    const { code } = req.params;
    const hasPermission = await UserPermissionModel.hasPermission(
      req.user.id,
      code
    );

    return res.status(200).json({
      success: true,
      data: {
        code,
        hasPermission,
      },
    });
  } catch (error) {
    console.error("checkPermission error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi kiểm tra quyền",
    });
  }
};

// Check if current user has any of the specified permissions
const checkAnyPermission = async (req, res) => {
  try {
    if (!ensureAuthenticated(req, res)) {
      return;
    }

    const { codes } = req.body;

    if (!Array.isArray(codes)) {
      return res.status(400).json({
        success: false,
        message: "codes phải là một mảng",
      });
    }

    const hasPermission = await UserPermissionModel.hasAnyPermission(
      req.user.id,
      codes
    );

    return res.status(200).json({
      success: true,
      data: {
        codes,
        hasPermission,
      },
    });
  } catch (error) {
    console.error("checkAnyPermission error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi kiểm tra quyền",
    });
  }
};

// Check if current user has all of the specified permissions
const checkAllPermissions = async (req, res) => {
  try {
    if (!ensureAuthenticated(req, res)) {
      return;
    }

    const { codes } = req.body;

    if (!Array.isArray(codes)) {
      return res.status(400).json({
        success: false,
        message: "codes phải là một mảng",
      });
    }

    const hasPermission = await UserPermissionModel.hasAllPermissions(
      req.user.id,
      codes
    );

    return res.status(200).json({
      success: true,
      data: {
        codes,
        hasPermission,
      },
    });
  } catch (error) {
    console.error("checkAllPermissions error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Lỗi khi kiểm tra quyền",
    });
  }
};

module.exports = {
  getAllPermissions,
  getPermissionsByModule,
  getMyPermissions,
  checkPermission,
  checkAnyPermission,
  checkAllPermissions,
};
