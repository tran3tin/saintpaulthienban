/**
 * Migration: Add new fields to sisters table
 * - saint_name (tên thánh)
 * - prefer_name (tên thường gọi)
 * - permanent_address (địa chỉ thường trú)
 * - id_number (CCCD/Passport)
 * - hometown (nguyên quán)
 * - notes (ghi chú khác)
 * - documents_url (upload giấy tờ - JSONB array)
 */

const pool = require("../config/database");

async function up() {
  const client = await pool.connect();
  try {
    console.log("Adding new fields to sisters table...");

    // PostgreSQL: Add columns if they don't exist
    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS saint_name VARCHAR(120) NULL
    `);
    console.log("Added column: saint_name");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS prefer_name VARCHAR(120) NULL
    `);
    console.log("Added column: prefer_name");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS hometown VARCHAR(200) NULL
    `);
    console.log("Added column: hometown");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS permanent_address VARCHAR(255) NULL
    `);
    console.log("Added column: permanent_address");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS id_number VARCHAR(50) NULL
    `);
    console.log("Added column: id_number");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS notes TEXT NULL
    `);
    console.log("Added column: notes");

    await client.query(`
      ALTER TABLE sisters 
      ADD COLUMN IF NOT EXISTS documents_url JSONB NULL
    `);
    console.log("Added column: documents_url");

    console.log("Migration 014_add_sister_fields completed successfully!");
  } catch (error) {
    console.error("Migration failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
}

async function down() {
  const client = await pool.connect();
  try {
    console.log("Reverting migration 014_add_sister_fields...");

    // Drop added columns
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS saint_name`);
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS prefer_name`);
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS permanent_address`
    );
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS id_number`);
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS hometown`);
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS notes`);
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS documents_url`
    );

    console.log("Migration 014_add_sister_fields reverted successfully!");
  } catch (error) {
    console.error("Revert failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
}

module.exports = { up, down };

// Run migration if called directly
if (require.main === module) {
  up()
    .then(() => {
      console.log("Migration completed");
      process.exit(0);
    })
    .catch((err) => {
      console.error("Migration error:", err);
      process.exit(1);
    });
}
