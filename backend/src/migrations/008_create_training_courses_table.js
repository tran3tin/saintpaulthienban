const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS training_courses (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    course_name VARCHAR(180) NOT NULL,
    organizer VARCHAR(180) NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    content TEXT NULL,
    notes TEXT NULL,
    CONSTRAINT fk_training_courses_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_training_courses_sister ON training_courses(sister_id);
`;

const downQuery = "DROP TABLE IF EXISTS training_courses;";

module.exports = {
  name: "008_create_training_courses_table",
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
