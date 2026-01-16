// Migration: Add extra fields to communities table
const db = require("../config/database");

const up = async () => {
  const client = await db.getConnection();
  try {
    const columnsToAdd = [
      {
        name: "phone",
        definition: "VARCHAR(20) NULL",
      },
      {
        name: "email",
        definition: "VARCHAR(100) NULL",
      },
      {
        name: "established_date",
        definition: "DATE NULL",
      },
      {
        name: "status",
        definition: "VARCHAR(20) DEFAULT 'active'",
      },
      {
        name: "description",
        definition: "TEXT NULL",
      },
    ];

    for (const col of columnsToAdd) {
      await client.query(
        `ALTER TABLE communities ADD COLUMN IF NOT EXISTS ${col.name} ${col.definition}`
      );
      console.log(`✅ Ensured column '${col.name}' exists on communities`);
    }

    console.log("✅ Migration completed successfully");
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await db.getConnection();
  try {
    const columnsToDrop = [
      "phone",
      "email",
      "established_date",
      "status",
      "description",
    ];

    for (const col of columnsToDrop) {
      await client.query(
        `ALTER TABLE communities DROP COLUMN IF EXISTS ${col}`
      );
    }
  } finally {
    client.release();
  }
};

module.exports = { up, down };

// Run directly if executed as script
if (require.main === module) {
  up()
    .then(() => {
      process.exit(0);
    })
    .catch((err) => {
      console.error("Migration failed:", err);
      process.exit(1);
    });
}
