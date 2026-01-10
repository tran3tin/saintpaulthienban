const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS communities (
    id SERIAL PRIMARY KEY,
    code VARCHAR(30) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    address VARCHAR(255) NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('motherhouse','education','healthcare','media','social')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL
  );
  
  CREATE INDEX IF NOT EXISTS idx_communities_type ON communities(type);
  
  CREATE OR REPLACE FUNCTION update_communities_updated_at()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER communities_updated_at_trigger
  BEFORE UPDATE ON communities
  FOR EACH ROW
  EXECUTE FUNCTION update_communities_updated_at();
`;

const downQuery = `
  DROP TRIGGER IF EXISTS communities_updated_at_trigger ON communities;
  DROP FUNCTION IF EXISTS update_communities_updated_at();
  DROP TABLE IF EXISTS communities;
`;

module.exports = {
  name: "002_create_communities_table",
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
