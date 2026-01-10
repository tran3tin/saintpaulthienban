// Migration to update evaluations table to match form fields and add documents
const pool = require("../config/database");

async function up() {
  const client = await pool.connect();
  try {
    console.log("Updating evaluations table...");

    const columnsToAdd = [
      { name: "evaluation_type", definition: "VARCHAR(50) NULL" },
      { name: "period", definition: "VARCHAR(100) NULL" },
      { name: "evaluation_date", definition: "DATE NULL" },
      { name: "evaluator", definition: "VARCHAR(255) NULL" },
      { name: "spiritual_life", definition: "SMALLINT NULL" },
      { name: "community_life", definition: "SMALLINT NULL" },
      { name: "apostolic_work", definition: "SMALLINT NULL" },
      { name: "personal_development", definition: "SMALLINT NULL" },
      { name: "overall_rating", definition: "SMALLINT NULL" },
      { name: "strengths", definition: "TEXT NULL" },
      { name: "weaknesses", definition: "TEXT NULL" },
      { name: "notes", definition: "TEXT NULL" },
      { name: "documents", definition: "JSONB NULL" },
    ];

    for (const col of columnsToAdd) {
      console.log(`Ensuring column exists: ${col.name}`);
      await client.query(
        `ALTER TABLE evaluations ADD COLUMN IF NOT EXISTS ${col.name} ${col.definition}`
      );
    }

    console.log(
      "Migration 026_update_evaluations_table completed successfully"
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
    console.log("Rolling back evaluations table changes...");

    const columnsToRemove = [
      "documents",
      "notes",
      "weaknesses",
      "strengths",
      "overall_rating",
      "personal_development",
      "apostolic_work",
      "community_life",
      "spiritual_life",
      "evaluator",
      "evaluation_date",
      "period",
      "evaluation_type",
    ];

    for (const col of columnsToRemove) {
      try {
        await client.query(
          `ALTER TABLE evaluations DROP COLUMN IF EXISTS ${col}`
        );
      } catch (e) {
        console.log(`Could not drop column ${col}:`, e.message);
      }
    }

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
