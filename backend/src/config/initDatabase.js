// src/config/initDatabase.js
// Auto-run migrations on server start

const pool = require("./database");
const { runMigrations } = require("../migrations/runner");

async function initCommunityRolesTable() {
  const connection = await pool.getConnection();
  try {
    console.log("[Migration] Checking community_roles table...");

    // Check if table exists (PostgreSQL syntax)
    const tables = await connection.query(
      `SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'community_roles'
      )`
    );

    const tableExists = tables.rows[0].exists;

    if (!tableExists) {
      console.log("[Migration] Creating community_roles table...");

      // Create table with PostgreSQL syntax
      await connection.query(`
        CREATE TABLE IF NOT EXISTS community_roles (
          id SERIAL PRIMARY KEY,
          code VARCHAR(50) NOT NULL UNIQUE,
          name VARCHAR(100) NOT NULL,
          description TEXT,
          display_order INT DEFAULT 0,
          color VARCHAR(20) DEFAULT '#6c757d',
          is_default BOOLEAN DEFAULT FALSE,
          is_active BOOLEAN DEFAULT TRUE,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        
        -- Trigger for auto-update updated_at
        CREATE OR REPLACE FUNCTION update_community_roles_updated_at()
        RETURNS TRIGGER AS $$
        BEGIN
          NEW.updated_at = CURRENT_TIMESTAMP;
          RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
        
        CREATE TRIGGER community_roles_updated_at_trigger
        BEFORE UPDATE ON community_roles
        FOR EACH ROW
        EXECUTE FUNCTION update_community_roles_updated_at();
      `);

      console.log("[Migration] community_roles table created!");
    }

    // Check if default roles exist
    const existingRoles = await connection.query(
      "SELECT COUNT(*) as count FROM community_roles"
    );

    if (existingRoles.rows[0].count == 0) {
      console.log("[Migration] Inserting default community roles...");

      const defaultRoles = [
        ["superior", "Bề trên", 1, "#d63031", true],
        ["assistant", "Phó bề trên", 2, "#2d3436", true],
        ["secretary", "Thư ký", 3, "#6c5ce7", true],
        ["treasurer", "Thủ quỹ", 4, "#e84393", true],
        ["member", "Thành viên", 5, "#0984e3", true],
      ];

      for (const role of defaultRoles) {
        await connection.query(
          `INSERT INTO community_roles (code, name, display_order, color, is_default, is_active) 
           VALUES ($1, $2, $3, $4, $5, TRUE)
           ON CONFLICT (code) DO NOTHING`,
          role
        );
      }

      console.log("[Migration] Default community roles inserted!");
    } else {
      console.log(
        `[Migration] community_roles table already has ${existingRoles.rows[0].count} roles`
      );
    }
  } catch (error) {
    console.error(
      "[Migration] Error initializing community_roles:",
      error.message
    );
  } finally {
    connection.release();
  }
}

async function initDatabase() {
  try {
    console.log("[Migration] Starting database initialization...");
    await initCommunityRolesTable();

    // Run full migration suite (idempotent via schema_migrations)
    console.log("[Migration] Running schema migrations...");
    await runMigrations({ direction: "up" });

    console.log("[Migration] Database initialization complete!");
  } catch (error) {
    console.error("[Migration] Database initialization failed:", error.message);
  }
}

module.exports = { initDatabase };
