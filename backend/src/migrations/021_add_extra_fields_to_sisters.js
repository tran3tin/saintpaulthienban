// Migration: Add extra fields to sisters table
// Run: node src/migrations/021_add_extra_fields_to_sisters.js

const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();
  try {
    console.log("Adding extra fields to sisters table...");

    // Add id_card fields
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card VARCHAR(20) NULL`
    );
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card_date DATE NULL`
    );
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card_place VARCHAR(150) NULL`
    );

    // Add current_address
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS current_address VARCHAR(255) NULL`
    );

    // Add family-related fields
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS father_occupation VARCHAR(100) NULL`
    );
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS mother_occupation VARCHAR(100) NULL`
    );
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS siblings_count INTEGER NULL`
    );
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS family_address VARCHAR(255) NULL`
    );

    // Add current_stage field for quick access (denormalized from vocation_journey)
    await client.query(
      `
      ALTER TABLE sisters
      ADD COLUMN IF NOT EXISTS current_stage VARCHAR(50) NULL
      CHECK (current_stage IN ('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left'))
    `
    );

    // Add community_id for current community (denormalized)
    await client.query(
      `ALTER TABLE sisters ADD COLUMN IF NOT EXISTS current_community_id INTEGER NULL`
    );

    // Add foreign key for current_community_id
    await client.query(`
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1
          FROM pg_constraint
          WHERE conname = 'fk_sisters_current_community'
            AND conrelid = 'sisters'::regclass
        ) THEN
          ALTER TABLE sisters
            ADD CONSTRAINT fk_sisters_current_community
            FOREIGN KEY (current_community_id) REFERENCES communities(id)
            ON DELETE SET NULL ON UPDATE CASCADE;
        END IF;
      END $$;
    `);

    console.log("Extra fields added successfully!");
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
    console.log("Removing extra fields from sisters table...");

    await client.query(
      `ALTER TABLE sisters DROP CONSTRAINT IF EXISTS fk_sisters_current_community`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS current_community_id`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS current_stage`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS family_address`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS siblings_count`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS mother_occupation`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS father_occupation`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS current_address`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS id_card_place`
    );
    await client.query(
      `ALTER TABLE sisters DROP COLUMN IF EXISTS id_card_date`
    );
    await client.query(`ALTER TABLE sisters DROP COLUMN IF EXISTS id_card`);

    console.log("Extra fields removed!");
  } catch (error) {
    console.error("Rollback failed:", error.message);
    throw error;
  } finally {
    client.release();
  }
};

// Run migration
if (require.main === module) {
  up()
    .then(() => {
      console.log("Migration completed!");
      process.exit(0);
    })
    .catch((err) => {
      console.error("Migration error:", err);
      process.exit(1);
    });
}

module.exports = { up, down };
