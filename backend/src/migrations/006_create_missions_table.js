const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS missions (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    field VARCHAR(50) NOT NULL CHECK (field IN ('education','pastoral','publishing','media','healthcare','social')),
    specific_role VARCHAR(150) NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    notes TEXT NULL,
    CONSTRAINT fk_missions_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_missions_field ON missions(field);
  CREATE INDEX IF NOT EXISTS idx_missions_sister ON missions(sister_id);
`;

const downQuery = "DROP TABLE IF EXISTS missions;";

module.exports = {
  name: "006_create_missions_table",
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
