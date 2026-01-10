const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS education (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    level VARCHAR(50) NOT NULL CHECK (level IN ('secondary','bachelor','master','doctorate')),
    major VARCHAR(150) NULL,
    institution VARCHAR(200) NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    certificate_url VARCHAR(255) NULL,
    CONSTRAINT fk_education_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_education_level ON education(level);
`;

const downQuery = "DROP TABLE IF EXISTS education;";

module.exports = {
  name: "007_create_education_table",
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
