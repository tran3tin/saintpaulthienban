// Migration to remove role system and prepare for UBAC
const pool = require("../config/database");

async function up() {
  const connection = await pool.getConnection();

  try {
    await connection.beginTransaction();

    console.log("Starting migration to remove role system...");

    // 1. Remove role_id from users table
    const checkRoleIdColumn = await connection.query(`
      SELECT COLUMN_NAME 
      FROM INFORMATION_SCHEMA.COLUMNS 
      WHERE TABLE_SCHEMA = DATABASE() 
      AND TABLE_NAME = 'users' 
      AND COLUMN_NAME = 'role_id'
    `);

    if (checkRoleIdColumn[0].length > 0) {
      console.log("Removing role_id column from users table...");
      await connection.query(`
        ALTER TABLE users 
        DROP FOREIGN KEY IF EXISTS users_ibfk_1,
        DROP COLUMN role_id
      `);
      console.log("✓ Removed role_id from users");
    }

    // 2. Drop role_permissions table if exists
    console.log("Dropping role_permissions table...");
    await connection.query("DROP TABLE IF EXISTS role_permissions");
    console.log("✓ Dropped role_permissions table");

    // 3. Drop roles table if exists
    console.log("Dropping roles table...");
    await connection.query("DROP TABLE IF EXISTS roles");
    console.log("✓ Dropped roles table");

    await connection.commit();
    console.log("Migration completed successfully!");
  } catch (error) {
    await connection.rollback();
    console.error("Migration failed:", error);
    throw error;
  } finally {
    connection.release();
  }
}

async function down() {
  const connection = await pool.getConnection();

  try {
    await connection.beginTransaction();

    console.log("Rolling back role system removal...");

    // Recreate roles table
    await connection.query(`
      CREATE TABLE IF NOT EXISTS roles (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) UNIQUE NOT NULL,
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    `);

    // Recreate role_permissions table
    await connection.query(`
      CREATE TABLE IF NOT EXISTS role_permissions (
        id INT PRIMARY KEY AUTO_INCREMENT,
        role_id INT NOT NULL,
        permission_id INT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
        UNIQUE KEY unique_role_permission (role_id, permission_id)
      )
    `);

    // Add role_id back to users
    await connection.query(`
      ALTER TABLE users 
      ADD COLUMN role_id INT,
      ADD FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
    `);

    await connection.commit();
    console.log("Rollback completed!");
  } catch (error) {
    await connection.rollback();
    console.error("Rollback failed:", error);
    throw error;
  } finally {
    connection.release();
  }
}

module.exports = { up, down };
