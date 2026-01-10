const pool = require("../config/database");

const upStatements = [
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS graduation_year INTEGER NULL",
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS status VARCHAR(50) DEFAULT 'dang_hoc' CHECK (status IN ('dang_hoc', 'da_tot_nghiep', 'tam_nghi', 'da_nghi'))",
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS gpa VARCHAR(20) NULL",
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS thesis_title VARCHAR(500) NULL",
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS notes TEXT NULL",
  "ALTER TABLE education ADD COLUMN IF NOT EXISTS documents JSONB NULL",
];

const downStatements = [
  "ALTER TABLE education DROP COLUMN IF EXISTS graduation_year",
  "ALTER TABLE education DROP COLUMN IF EXISTS status",
  "ALTER TABLE education DROP COLUMN IF EXISTS gpa",
  "ALTER TABLE education DROP COLUMN IF EXISTS thesis_title",
  "ALTER TABLE education DROP COLUMN IF EXISTS notes",
  "ALTER TABLE education DROP COLUMN IF EXISTS documents",
];

module.exports = {
  name: "031_add_education_extra_fields",
  up: async () => {
    const client = await pool.connect();
    try {
      for (const stmt of upStatements) {
        await client.query(stmt);
      }
      console.log("Added extra fields to education table (PostgreSQL-safe)");
    } finally {
      client.release();
    }
  },
  down: async () => {
    const client = await pool.connect();
    try {
      for (const stmt of downStatements) {
        await client.query(stmt);
      }
    } finally {
      client.release();
    }
  },
};
