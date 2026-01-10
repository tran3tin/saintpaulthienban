const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS departure_records (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    departure_date DATE NOT NULL,
    stage_at_departure VARCHAR(50) NOT NULL CHECK (stage_at_departure IN ('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left')),
    reason TEXT NULL,
    support_notes TEXT NULL,
    CONSTRAINT fk_departure_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_departure_date ON departure_records(departure_date);
`;

const downQuery = "DROP TABLE IF EXISTS departure_records;";

module.exports = {
  name: "011_create_departure_records_table",
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
