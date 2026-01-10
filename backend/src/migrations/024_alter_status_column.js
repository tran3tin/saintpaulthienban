// Migration: Change status column to VARCHAR (PostgreSQL-safe)
const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();

  try {
    console.log("Altering status column in sisters table...");
    await client.query(`
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM information_schema.columns
          WHERE table_schema = current_schema()
            AND table_name = 'sisters'
            AND column_name = 'status'
        ) THEN
          ALTER TABLE sisters ALTER COLUMN status TYPE VARCHAR(50);
          ALTER TABLE sisters ALTER COLUMN status SET DEFAULT 'active';
        END IF;
      END $$;
    `);
    console.log("✓ Status column ensured as VARCHAR(50)");
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
