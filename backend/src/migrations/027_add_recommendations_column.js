// Migration to add recommendations column to evaluations table
const pool = require("../config/database");

async function up() {
  const client = await pool.connect();
  try {
    console.log("Adding recommendations column to evaluations table...");

    await client.query(
      `ALTER TABLE evaluations ADD COLUMN IF NOT EXISTS recommendations TEXT NULL`
    );
    console.log("✓ Ensured evaluations.recommendations exists");

    console.log(
      "Migration 027_add_recommendations_column completed successfully"
    );
  } catch (error) {
    console.error("Migration failed:", error);
    throw error;
  } finally {
    client.release();
  }
}

async function down() {
  const client = await pool.connect();
  try {
    console.log("Rolling back recommendations column...");

    await client.query(
      `ALTER TABLE evaluations DROP COLUMN IF EXISTS recommendations`
    );

    console.log("Rollback completed");
  } finally {
    client.release();
  }
}

if (require.main === module) {
  up()
    .then(() => {
      console.log("Done");
      process.exit(0);
    })
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
}

module.exports = { up, down };
