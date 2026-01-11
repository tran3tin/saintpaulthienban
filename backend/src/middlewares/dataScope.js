// Middleware to attach data scope to request
// This determines which data the user can access based on their assigned communities

const userCommunityModel = require("../models/UserCommunityModel");

// Cache to avoid repeated database queries
const scopeCache = new Map();
const CACHE_TTL = 5 * 60 * 1000; // 5 minutes

/**
 * Attach data scope to request
 * Sets req.userScope with type and community_ids
 */
const attachDataScope = async (req, res, next) => {
  try {
    // Skip if no user (should not happen after authenticateToken)
    if (!req.user || !req.user.id) {
      return next();
    }

    const userId = req.user.id;

    // Check cache first
    const cacheKey = `scope:${userId}`;
    const cached = scopeCache.get(cacheKey);
    if (cached && Date.now() - cached.timestamp < CACHE_TTL) {
      req.userScope = cached.scope;
      return next();
    }

    // Get user's data_scope from database if not in JWT
    let dataScope = req.user.data_scope;
    if (!dataScope) {
      const db = require("../config/database");
      const [users] = await db.query(
        "SELECT data_scope FROM users WHERE id = ?",
        [userId]
      );
      dataScope = users[0]?.data_scope || "community";
    }

    // If user has 'all' scope, they can see all data
    if (dataScope === "all") {
      const scope = { type: "all" };
      scopeCache.set(cacheKey, { scope, timestamp: Date.now() });
      req.userScope = scope;
      return next();
    }

    // Build scope based on data_scope value
    let scope;

    switch (dataScope) {
      case "all":
        // User can see all data
        scope = { type: "all" };
        break;

      case "community":
        // User can only see data from assigned communities
        const communityIds = await userCommunityModel.getUserCommunityIds(
          userId
        );

        // Check if user has access to ALL communities
        const db = require("../config/database");
        const [allCommunities] = await db.query(
          "SELECT COUNT(*) as total FROM communities"
        );
        const totalCommunities = allCommunities[0]?.total || 0;

        // If user has all communities assigned, treat as 'all' scope
        if (communityIds.length >= totalCommunities && totalCommunities > 0) {
          scope = { type: "all" };
        } else {
          scope = {
            type: "community",
            community_ids: communityIds,
          };
        }
        break;

      case "own":
        // User can only see their own data
        scope = {
          type: "own",
          user_id: userId,
        };
        break;

      default:
        // Default to community scope
        const defaultCommunityIds =
          await userCommunityModel.getUserCommunityIds(userId);

        // Check if user has access to ALL communities
        const dbDefault = require("../config/database");
        const [allCommsDefault] = await dbDefault.query(
          "SELECT COUNT(*) as total FROM communities"
        );
        const totalCommsDefault = allCommsDefault[0]?.total || 0;

        // If user has all communities assigned, treat as 'all' scope
        if (
          defaultCommunityIds.length >= totalCommsDefault &&
          totalCommsDefault > 0
        ) {
          scope = { type: "all" };
        } else {
          scope = {
            type: "community",
            community_ids: defaultCommunityIds,
          };
        }
    }

    // Cache the result
    scopeCache.set(cacheKey, { scope, timestamp: Date.now() });

    // Attach to request
    req.userScope = scope;

    next();
  } catch (error) {
    console.error("Error in attachDataScope middleware:", error);
    // Don't fail the request, set a safe default scope.
    // Using 'community' with an empty list prevents accidental broad access and
    // avoids assuming tables have a created_by column.
    req.userScope = { type: "community", community_ids: [] };
    next();
  }
};

/**
 * Clear scope cache for a user
 * Call this when user's communities or data_scope changes
 */
const clearScopeCache = (userId) => {
  const cacheKey = `scope:${userId}`;
  scopeCache.delete(cacheKey);
};

/**
 * Clear all scope cache
 * Call this on major permission changes
 */
const clearAllScopeCache = () => {
  scopeCache.clear();
};

module.exports = {
  attachDataScope,
  clearScopeCache,
  clearAllScopeCache,
};
