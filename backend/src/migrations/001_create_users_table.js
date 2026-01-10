const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'viewer' CHECK (role IN ('admin','superior_general','superior_provincial','superior_community','secretary','viewer')),
    last_login TIMESTAMP NULL,
    is_active SMALLINT NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL
  );
  
  CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
  CREATE INDEX IF NOT EXISTS idx_users_active ON users(is_active);
  
  -- Trigger to auto-update updated_at
  CREATE OR REPLACE FUNCTION update_users_updated_at()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;
  
  CREATE TRIGGER users_updated_at_trigger
  BEFORE UPDATE ON users
  FOR EACH ROW
  EXECUTE FUNCTION update_users_updated_at();
`;

const downQuery = `
  DROP TRIGGER IF EXISTS users_updated_at_trigger ON users;
  DROP FUNCTION IF EXISTS update_users_updated_at();
  DROP TABLE IF EXISTS users;
`;

module.exports = {
  name: "001_create_users_table",
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
