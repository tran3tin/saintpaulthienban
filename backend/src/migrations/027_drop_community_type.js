// Migration: Drop type column from communities table
const db = require("../config/database");

const up = async () => {
  const client = await db.getConnection();
  try {
    await client.query(
      `ALTER TABLE communities DROP COLUMN IF EXISTS type`
    );
    console.log("✅ Dropped 'type' column from communities table (if it existed)");
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await db.getConnection();
  try {
    await client.query(
      `ALTER TABLE communities ADD COLUMN IF NOT EXISTS type VARCHAR(50) DEFAULT 'other'`
    );
    console.log("✅ Added 'type' column back to communities table");
  } finally {
    client.release();
  }
};

module.exports = { up, down };

// Run directly if executed as script
if (require.main === module) {
  up()
    .then(() => {
      console.log("Migration completed successfully");
      process.exit(0);
    })
    .catch((err) => {
      console.error("Migration failed:", err);
      process.exit(1);
    });
}
