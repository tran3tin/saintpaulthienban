const db = require("../src/config/database");

async function removeConstraint() {
  try {
    console.log("Removing 'missions_field_check' constraint...");

    // 1. Drop the constraint
    await db.query(
      `ALTER TABLE missions DROP CONSTRAINT IF EXISTS missions_field_check`,
    );
    console.log("Constraint dropped.");

    // 2. Modify the column to just be VARCHAR(255) to be safe (it currently is VARCHAR(50))
    // Increasing length to allow flexible input
    await db.query(`ALTER TABLE missions ALTER COLUMN field TYPE VARCHAR(255)`);
    console.log("Column 'field' modified to VARCHAR(255).");

    process.exit(0);
  } catch (error) {
    console.error("Migration failed:", error);
    process.exit(1);
  }
}

removeConstraint();
