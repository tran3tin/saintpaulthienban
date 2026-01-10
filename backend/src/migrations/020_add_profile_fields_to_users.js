// Migration: Add profile fields to users table
// Run: node src/migrations/020_add_profile_fields_to_users.js

const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();
  try {
    console.log("Adding profile fields to users table...");

    // PostgreSQL doesn't support AFTER keyword, columns are added at the end
    // Add full_name column
    await client.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS full_name VARCHAR(150) NULL
    `);

    // Add phone column
    await client.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS phone VARCHAR(30) NULL
    `);

    // Add avatar column
    await client.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS avatar VARCHAR(500) NULL
    `);

    console.log("Profile fields added successfully!");
  } catch (error) {
    console.error("Migration failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await pool.connect();
  try {
    console.log("Removing profile fields from users table...");

    await client.query(`ALTER TABLE users DROP COLUMN IF EXISTS avatar`);
    await client.query(`ALTER TABLE users DROP COLUMN IF EXISTS phone`);
    await client.query(`ALTER TABLE users DROP COLUMN IF EXISTS full_name`);

    console.log("Profile fields removed!");
  } catch (error) {
    console.error("Rollback failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
};

// Run migration
if (require.main === module) {
  up()
    .then(() => {
      console.log("Migration completed!");
      process.exit(0);
    })
    .catch((err) => {
      console.error("Migration error:", err);
      process.exit(1);
    });
}

module.exports = { up, down };
