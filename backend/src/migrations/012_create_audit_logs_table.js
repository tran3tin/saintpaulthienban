const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS audit_logs (
    id BIGSERIAL PRIMARY KEY,
    user_id INTEGER NULL,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(100) NOT NULL,
    record_id BIGINT NULL,
    old_value JSONB NULL,
    new_value JSONB NULL,
    ip_address VARCHAR(50) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_audit_logs_user FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE SET NULL ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_audit_table ON audit_logs(table_name);
  CREATE INDEX IF NOT EXISTS idx_audit_user ON audit_logs(user_id);
`;

const downQuery = "DROP TABLE IF EXISTS audit_logs;";

module.exports = {
  name: "012_create_audit_logs_table",
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
