// Migration: Cleanup unused columns in sisters table
// Remove columns that are not used in SisterFormPage.jsx

const db = require("../config/database");

const up = async () => {
  console.log("Running migration 029: Cleanup unused sisters columns...");

  const columnsToRemove = [
    "religious_name",
    "prefer_name",
    "preferred_name",
    "hometown",
    "id_number",
    "documents_url",
  ];

  for (const column of columnsToRemove) {
    try {
      await db.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS ${column}`);
      console.log(`  ✓ Dropped column (if existed): ${column}`);
    } catch (error) {
      console.error(`  ✗ Error dropping column ${column}:`, error.message);
    }
  }

  console.log("Migration 029 completed.");
};

const down = async () => {
  console.log("Rolling back migration 029...");

  // Re-add the columns if needed
  const columnsToAdd = [
    { name: "religious_name", type: "VARCHAR(120) NULL" },
    { name: "prefer_name", type: "VARCHAR(120) NULL" },
    { name: "preferred_name", type: "VARCHAR(255) NULL" },
    { name: "hometown", type: "VARCHAR(200) NULL" },
    { name: "id_number", type: "VARCHAR(50) NULL" },
    { name: "documents_url", type: "TEXT NULL" },
  ];

  for (const col of columnsToAdd) {
    try {
      await db.query(
        `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS ${col.name} ${col.type}`
      );
      console.log(`  ✓ Ensured column exists: ${col.name}`);
    } catch (error) {
      console.error(`  ✗ Error adding column ${col.name}:`, error.message);
    }
  }

  console.log("Rollback 029 completed.");
};

module.exports = { up, down };

// Run directly if called from command line
if (require.main === module) {
  up()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
}
