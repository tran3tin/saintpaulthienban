// Migration: Add documents JSONB field to sisters table
const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();

  try {
    console.log("Adding documents field to sisters table...");
    await client.query(`ALTER TABLE sisters ADD COLUMN IF NOT EXISTS documents JSONB`);
    try {
      await client.query(
        `COMMENT ON COLUMN sisters.documents IS 'JSON array of document files'`
      );
    } catch {
      // Ignore comment failures (e.g. permissions or older PG setups)
    }
    console.log("✓ Ensured sisters.documents exists");
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
    await client.query("ALTER TABLE sisters DROP COLUMN IF EXISTS documents");
  } finally {
    client.release();
  }
};

module.exports = { up, down };

if (require.main === module) {
  up()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
}
