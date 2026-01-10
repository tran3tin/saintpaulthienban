const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    await client.query(`
      CREATE TABLE IF NOT EXISTS notifications (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        type VARCHAR(50) NOT NULL DEFAULT 'info',
        title VARCHAR(255) NOT NULL,
        message TEXT,
        link TEXT,
        is_read BOOLEAN NOT NULL DEFAULT FALSE,
        read_at TIMESTAMP,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      );

      CREATE INDEX IF NOT EXISTS idx_notifications_user_created_at
        ON notifications (user_id, created_at DESC);

      CREATE INDEX IF NOT EXISTS idx_notifications_user_is_read
        ON notifications (user_id, is_read);
    `);

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    await client.query("DROP TABLE IF EXISTS notifications");
    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

module.exports = {
  name: "041_create_notifications_table",
  up,
  down,
};
