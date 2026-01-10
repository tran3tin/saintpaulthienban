const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS community_assignments (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    community_id INTEGER NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'member' CHECK (role IN ('superior','assistant','vice_superior','deputy','secretary','treasurer','member')),
    start_date DATE NOT NULL,
    end_date DATE NULL,
    decision_number VARCHAR(50) NULL,
    decision_date DATE NULL,
    decision_file_url VARCHAR(255) NULL,
    notes TEXT NULL,
    CONSTRAINT fk_assignments_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_assignments_community FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE CASCADE ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_assignments_role ON community_assignments(role);
  CREATE INDEX IF NOT EXISTS idx_assignments_sister ON community_assignments(sister_id);
  CREATE INDEX IF NOT EXISTS idx_assignments_community ON community_assignments(community_id);
`;

const downQuery = "DROP TABLE IF EXISTS community_assignments;";

module.exports = {
  name: "005_create_community_assignments_table",
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
