// Migration: Alter community type column to allow more values and be nullable
const db = require("../config/database");

const up = async () => {
  const client = await db.getConnection();
  try {
    await client.query(`
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM information_schema.columns
          WHERE table_schema = current_schema()
            AND table_name = 'communities'
            AND column_name = 'type'
        ) THEN
          ALTER TABLE communities ALTER COLUMN type DROP NOT NULL;
          ALTER TABLE communities ALTER COLUMN type SET DEFAULT 'other';

          -- drop the old inline check constraint if it exists
          BEGIN
            ALTER TABLE communities DROP CONSTRAINT IF EXISTS communities_type_check;
          EXCEPTION WHEN undefined_object THEN
            NULL;
          END;

          -- re-add a more permissive check constraint (if not already present)
          IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'communities_type_check'
              AND conrelid = 'communities'::regclass
          ) THEN
            ALTER TABLE communities
              ADD CONSTRAINT communities_type_check
              CHECK (type IS NULL OR type IN ('motherhouse','education','healthcare','media','social','other'));
          END IF;
        END IF;
      END $$;
    `);
    console.log("✅ Updated communities.type defaults/constraints");
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await db.getConnection();
  try {
    await client.query(`
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM information_schema.columns
          WHERE table_schema = current_schema()
            AND table_name = 'communities'
            AND column_name = 'type'
        ) THEN
          ALTER TABLE communities ALTER COLUMN type SET DEFAULT NULL;
          ALTER TABLE communities ALTER COLUMN type SET NOT NULL;

          BEGIN
            ALTER TABLE communities DROP CONSTRAINT IF EXISTS communities_type_check;
          EXCEPTION WHEN undefined_object THEN
            NULL;
          END;

          IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = 'communities_type_check'
              AND conrelid = 'communities'::regclass
          ) THEN
            ALTER TABLE communities
              ADD CONSTRAINT communities_type_check
              CHECK (type IN ('motherhouse','education','healthcare','media','social'));
          END IF;
        END IF;
      END $$;
    `);
    console.log("✅ Reverted communities.type constraint");
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
