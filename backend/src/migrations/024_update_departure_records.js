// Migration to add temporary absence (đi vắng) fields to departure_records table
const pool = require("../config/database");

const upQueries = [
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS type VARCHAR(50) NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS expected_return_date DATE NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS return_date DATE NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS destination VARCHAR(255) NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS contact_phone VARCHAR(50) NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS contact_address TEXT NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS approved_by INTEGER NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS notes TEXT NULL`,
  `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS documents JSONB NULL`,
  `DO $$ BEGIN IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = current_schema() AND table_name='departure_records' AND column_name='stage_at_departure') THEN ALTER TABLE departure_records ALTER COLUMN stage_at_departure DROP NOT NULL; END IF; END $$;`,
];

const downQueries = [
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS type`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS expected_return_date`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS return_date`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS destination`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS contact_phone`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS contact_address`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS approved_by`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS notes`,
  `ALTER TABLE departure_records DROP COLUMN IF EXISTS documents`,
];

module.exports = {
  name: "024_update_departure_records",
  up: async () => {
    const client = await pool.connect();
    try {
      for (const query of upQueries) {
        try {
          await client.query(query);
          console.log("  ✓ " + query.substring(0, 60) + "...");
        } catch (err) {
          console.log("  ⚠ Skipped: " + err.message);
        }
      }
    } finally {
      client.release();
    }
  },
  down: async () => {
    const client = await pool.connect();
    try {
      for (const query of downQueries) {
        try {
          await client.query(query);
        } catch (err) {
          console.log("  ⚠ Skipped: " + err.message);
        }
      }
    } finally {
      client.release();
    }
  },
};
