// Migration to remove role system and prepare for UBAC
const pool = require("../config/database");

async function up() {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    console.log("Starting migration to remove role system...");

    // 1. Remove role_id from users table (if present)
    console.log("Removing role_id column from users table (if exists)...");
    await client.query(`ALTER TABLE users DROP COLUMN IF EXISTS role_id`);

    // 2. Drop role_permissions table if exists
    console.log("Dropping role_permissions table...");
    await client.query("DROP TABLE IF EXISTS role_permissions");
    console.log("✓ Dropped role_permissions table");

    // 3. Drop roles table if exists
    console.log("Dropping roles table...");
    await client.query("DROP TABLE IF EXISTS roles");
    console.log("✓ Dropped roles table");

    await client.query("COMMIT");
    console.log("Migration completed successfully!");
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Migration failed:", error);
    throw error;
  } finally {
    client.release();
  }
}

async function down() {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    console.log("Rolling back role system removal...");

    // Recreate roles table
    await client.query(`
      CREATE TABLE IF NOT EXISTS roles (
        id SERIAL PRIMARY KEY,
        name VARCHAR(50) UNIQUE NOT NULL,
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);

    // Recreate role_permissions table
    await client.query(`
      CREATE TABLE IF NOT EXISTS role_permissions (
        id SERIAL PRIMARY KEY,
        role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
        permission_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (role_id, permission_id)
      )
    `);

    // Add role_id back to users
    await client.query(
      `ALTER TABLE users ADD COLUMN IF NOT EXISTS role_id INTEGER REFERENCES roles(id) ON DELETE SET NULL`
    );

    await client.query("COMMIT");
    console.log("Rollback completed!");
  } catch (error) {
    await client.query("ROLLBACK");
    console.error("Rollback failed:", error);
    throw error;
  } finally {
    client.release();
  }
}

module.exports = { up, down };
