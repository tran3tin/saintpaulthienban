// Migration: Change current_stage column to VARCHAR (PostgreSQL-safe)
const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();
  try {
    console.log("Altering current_stage column in sisters table...");
    await client.query(`
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM information_schema.columns
          WHERE table_schema = current_schema()
            AND table_name = 'sisters'
            AND column_name = 'current_stage'
        ) THEN
          ALTER TABLE sisters ALTER COLUMN current_stage TYPE VARCHAR(50);
        END IF;
      END $$;
    `);
    console.log("✓ current_stage column ensured as VARCHAR(50)");
  } catch (error) {
    console.error("Migration failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
};

const down = async () => {
  // No-op (safe rollback)
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
