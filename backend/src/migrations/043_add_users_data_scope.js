const pool = require("../config/database");

const upQuery = `
  ALTER TABLE users
    ADD COLUMN IF NOT EXISTS data_scope VARCHAR(20) NOT NULL DEFAULT 'community'
    CHECK (data_scope IN ('all','community','own'));

  CREATE INDEX IF NOT EXISTS idx_users_data_scope ON users(data_scope);

  UPDATE users
  SET data_scope = 'all'
  WHERE role IN ('admin', 'superior_general');
`;

const downQuery = `
  DROP INDEX IF EXISTS idx_users_data_scope;
  ALTER TABLE users DROP COLUMN IF EXISTS data_scope;
`;

module.exports = {
  name: "043_add_users_data_scope",
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
