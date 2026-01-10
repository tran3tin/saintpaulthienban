const pool = require("../config/database");

module.exports = {
  name: "024_add_extra_health_record_fields",
  up: async () => {
    const client = await pool.connect();
    try {
      await client.query(`
        DO $$
        BEGIN
          IF EXISTS (
            SELECT 1
            FROM information_schema.columns
            WHERE table_schema = current_schema()
              AND table_name = 'health_records'
              AND column_name = 'general_health'
          ) THEN
            ALTER TABLE health_records ALTER COLUMN general_health TYPE VARCHAR(50);
            ALTER TABLE health_records ALTER COLUMN general_health SET DEFAULT 'good';
            ALTER TABLE health_records ALTER COLUMN general_health SET NOT NULL;
          END IF;
        END $$;
      `);

      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS doctor VARCHAR(150) NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS blood_pressure VARCHAR(20) NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS heart_rate VARCHAR(20) NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS weight NUMERIC(5,2) NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS height NUMERIC(5,2) NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS next_checkup_date DATE NULL`
      );
      await client.query(
        `ALTER TABLE health_records ADD COLUMN IF NOT EXISTS documents JSONB NULL`
      );
    } finally {
      client.release();
    }
  },
  down: async () => {
    const client = await pool.connect();
    try {
      await client.query("ALTER TABLE health_records DROP COLUMN IF EXISTS doctor");
      await client.query(
        "ALTER TABLE health_records DROP COLUMN IF EXISTS blood_pressure"
      );
      await client.query("ALTER TABLE health_records DROP COLUMN IF EXISTS heart_rate");
      await client.query("ALTER TABLE health_records DROP COLUMN IF EXISTS weight");
      await client.query("ALTER TABLE health_records DROP COLUMN IF EXISTS height");
      await client.query(
        "ALTER TABLE health_records DROP COLUMN IF EXISTS next_checkup_date"
      );
      await client.query("ALTER TABLE health_records DROP COLUMN IF EXISTS documents");
    } finally {
      client.release();
    }
  },
};
