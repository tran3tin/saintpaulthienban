const db = require("../src/config/database");

async function runMigration() {
  try {
    console.log(
      "Starting migration to add missing columns to 'missions' table...",
    );

    // Helper to check if column exists
    const columnExists = async (colName) => {
      const query = `
          SELECT column_name 
          FROM information_schema.columns 
          WHERE table_name = 'missions' AND column_name = '${colName}'
        `;
      const [rows] = await db.query(query);
      return rows.length > 0;
    };

    const columnsToAdd = [
      { name: "organization", type: "VARCHAR(200)", default: "NULL" },
      { name: "address", type: "TEXT", default: "NULL" },
      { name: "documents", type: "TEXT", default: "NULL" }, // efficient storage for JSON string
      { name: "notes", type: "TEXT", default: "NULL" },
    ];

    for (const col of columnsToAdd) {
      if (await columnExists(col.name)) {
        console.log(`Column '${col.name}' already exists. Skipping.`);
      } else {
        console.log(`Adding column '${col.name}'...`);
        // Postgres syntax: ALTER TABLE missions ADD COLUMN name type;
        // MySQL syntax: ALTER TABLE missions ADD COLUMN name type;
        // Both are similar for simple add.
        await db.query(
          `ALTER TABLE missions ADD COLUMN "${col.name}" ${col.type}`,
        );
        console.log(`Column '${col.name}' added successfully.`);
      }
    }

    console.log("Migration completed.");
    process.exit(0);
  } catch (error) {
    console.error("Migration failed:", error);
    process.exit(1);
  }
}

// Allow time for checking connection
setTimeout(runMigration, 1000);
