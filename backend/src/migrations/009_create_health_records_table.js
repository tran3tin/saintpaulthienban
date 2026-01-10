const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS health_records (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    general_health VARCHAR(20) NOT NULL CHECK (general_health IN ('good','average','weak')),
    chronic_diseases TEXT NULL,
    work_limitations TEXT NULL,
    checkup_date DATE NULL,
    checkup_place VARCHAR(150) NULL,
    diagnosis TEXT NULL,
    treatment TEXT NULL,
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_health_records_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_health_sister ON health_records(sister_id);
  
  CREATE OR REPLACE FUNCTION update_health_records_updated_at()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;

  DROP TRIGGER IF EXISTS health_records_updated_at_trigger ON health_records;
  
  CREATE TRIGGER health_records_updated_at_trigger
  BEFORE UPDATE ON health_records
  FOR EACH ROW
  EXECUTE FUNCTION update_health_records_updated_at();
`;

const downQuery = `
  DROP TRIGGER IF EXISTS health_records_updated_at_trigger ON health_records;
  DROP FUNCTION IF EXISTS update_health_records_updated_at();
  DROP TABLE IF EXISTS health_records;
`;

module.exports = {
  name: "009_create_health_records_table",
  up: async () => {
    const client = await pool.connect();
    try {
      await client.query(upQuery);
    } finally {
      client.release();
    }
  },
  down: async () => {
    const client = await pool.connect();
    try {
      await client.query(downQuery);
    } finally {
      client.release();
    }
  },
};
