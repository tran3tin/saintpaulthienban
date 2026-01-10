const pool = require("../config/database");

const adminPasswordHash =
  "$2a$10$CwTycUXWue0Thq9StjUM0uJ8czPz7YT6CX4hY0MQipoZf7cFTdO2W"; // bcrypt hash for "password"

const up = async () => {
  const client = await pool.connect();
  try {
    // PostgreSQL doesn't have beginTransaction, use BEGIN
    await client.query('BEGIN');
    
    // PostgreSQL uses ON CONFLICT instead of ON DUPLICATE KEY UPDATE
    await client.query(
      `INSERT INTO users (username, password, email, role, is_active)
       VALUES ($1, $2, $3, $4, $5)
       ON CONFLICT (username) DO NOTHING`,
      ['admin', adminPasswordHash, 'admin@example.com', 'admin', 1]
    );

    await client.query(
      `INSERT INTO communities (code, name, address, type)
       VALUES
         ('MH-001', 'Motherhouse Headquarters', '123 Main St, City', 'motherhouse'),
         ('EDU-001', 'St. Joseph Education Center', '45 School Ave, City', 'education')
       ON CONFLICT (code) DO NOTHING`
    );

    await client.query('COMMIT');
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    await client.query(
      "DELETE FROM communities WHERE code IN ('MH-001','EDU-001')"
    );
    await client.query("DELETE FROM users WHERE username = 'admin'");
    await client.query('COMMIT');
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
};

module.exports = {
  name: "013_seed_initial_data",
  up,
  down,
};
