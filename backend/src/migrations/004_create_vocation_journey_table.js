const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS vocation_journey (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    stage VARCHAR(50) NOT NULL CHECK (stage IN ('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left')),
    start_date DATE NOT NULL,
    end_date DATE NULL,
    community_id INTEGER NULL,
    supervisor_id INTEGER NULL,
    notes TEXT NULL,
    CONSTRAINT fk_vocation_journey_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_vocation_journey_community FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_vocation_journey_supervisor FOREIGN KEY (supervisor_id) REFERENCES users(id)
      ON DELETE SET NULL ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_vocation_stage ON vocation_journey(stage);
  CREATE INDEX IF NOT EXISTS idx_vocation_sister ON vocation_journey(sister_id);
`;

const downQuery = "DROP TABLE IF EXISTS vocation_journey;";

module.exports = {
  name: "004_create_vocation_journey_table",
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
