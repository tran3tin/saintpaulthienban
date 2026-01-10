// Deprecated legacy migration.
//
// This file previously contained a MySQL-specific migration implementation.
// The project has been migrated to PostgreSQL, and permissions are handled by:
// - src/migrations/100_remove_role_system.js
// - backend/setup_permissions.js
//
// It is intentionally left as an inert stub so that src/migrations/runMigrations.js
// can safely require it and skip it.

module.exports = {};
