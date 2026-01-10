const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS evaluations (
    id SERIAL PRIMARY KEY,
    sister_id INTEGER NOT NULL,
    evaluation_period VARCHAR(50) NOT NULL,
    evaluator_id INTEGER NULL,
    spiritual_life_score SMALLINT NULL,
    community_life_score SMALLINT NULL,
    mission_score SMALLINT NULL,
    personality_score SMALLINT NULL,
    obedience_score SMALLINT NULL,
    general_comments TEXT NULL,
    recommendations TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_evaluations_sister FOREIGN KEY (sister_id) REFERENCES sisters(id)
      ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_evaluations_evaluator FOREIGN KEY (evaluator_id) REFERENCES users(id)
      ON DELETE SET NULL ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_evaluations_period ON evaluations(evaluation_period);
  
  CREATE OR REPLACE FUNCTION update_evaluations_updated_at()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER evaluations_updated_at_trigger
  BEFORE UPDATE ON evaluations
  FOR EACH ROW
  EXECUTE FUNCTION update_evaluations_updated_at();
`;

const downQuery = `
  DROP TRIGGER IF EXISTS evaluations_updated_at_trigger ON evaluations;
  DROP FUNCTION IF EXISTS update_evaluations_updated_at();
  DROP TABLE IF EXISTS evaluations;
`;

module.exports = {
  name: "010_create_evaluations_table",
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
