const jwt = require("jsonwebtoken");
const path = require("path");
const dotenv = require("dotenv");
const UserModel = require("../models/UserModel");

dotenv.config({ path: path.resolve(__dirname, "../../.env") });

const JWT_SECRET = process.env.JWT_SECRET || "changeme";

const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ message: "Authorization header missing" });
  }

  const token = authHeader.startsWith("Bearer ")
    ? authHeader.slice(7)
    : authHeader;
  if (!token) {
    return res.status(401).json({ message: "Token not provided" });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);

    // PostgreSQL schema uses users.role + users.is_active
    const dbUser = await UserModel.findById(decoded.id);
    if (!dbUser) {
      return res.status(401).json({ message: "User not found" });
    }

    // Check if account is locked
    if (!dbUser.is_active) {
      return res.status(403).json({
        success: false,
        code: "ACCOUNT_LOCKED",
        message:
          "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên.",
      });
    }

    // Get user permissions
    const permissions = await UserModel.getPermissions(decoded.id);

    // Determine role from DB (fallback to user)
    const role = dbUser.role || "user";
    const isAdmin = role === "admin" || role === "superior_general";

    req.user = {
      ...decoded,
      role,
      // Keep legacy flags for compatibility with older code
      is_admin: isAdmin ? 1 : 0,
      is_super_admin: role === "superior_general" ? 1 : 0,
      // Use permission codes consistently (e.g. "posts.view")
      permissions: permissions.map((p) => p.code),
    };

    return next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid or expired token" });
  }
};

const authorize =
  (...roles) =>
  (req, res, next) => {
    if (!req.user || !req.user.role) {
      return res.status(401).json({ message: "User context missing" });
    }

    if (roles.length && !roles.includes(req.user.role)) {
      return res.status(403).json({ message: "Access denied" });
    }

    return next();
  };

/**
 * Check if user has required permission
 * Permission-based only - no admin bypass
 */
const checkPermission = (requiredPermission) => {
  return (req, res, next) => {
    console.log(`[CheckPermission] Required: ${requiredPermission}`);
    console.log(`[CheckPermission] User:`, {
      id: req.user?.id,
      permissionCount: req.user?.permissions?.length,
      hasRequired: req.user?.permissions?.includes(requiredPermission),
    });

    // Admin bypass: admins/superior generals can access all endpoints
    if (
      req.user &&
      (req.user.is_admin === 1 ||
        req.user.role === "admin" ||
        req.user.role === "superior_general")
    ) {
      console.log(`[CheckPermission] ✅ Admin bypass granted`);
      return next();
    }

    // Check if user has the specific required permission
    if (
      !req.user ||
      !req.user.permissions ||
      !req.user.permissions.includes(requiredPermission)
    ) {
      console.log(`[CheckPermission] ❌ Access denied`);
      return res.status(403).json({
        success: false,
        message: "Bạn không có quyền thực hiện thao tác này",
        requiredPermission,
      });
    }

    console.log(`[CheckPermission] ✅ Permission granted`);
    next();
  };
};

module.exports = {
  authenticateToken,
  authorize,
  checkPermission,
};
