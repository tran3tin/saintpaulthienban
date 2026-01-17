const fs = require("fs");
const pool = require("../src/config/database");

const createTableSQL = `
-- Create community_events table for manual events
CREATE TABLE IF NOT EXISTS community_events (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE
);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_community_events_community_id ON community_events(community_id);
CREATE INDEX IF NOT EXISTS idx_community_events_event_date ON community_events(event_date);
`;

async function setup() {
  const logStream = fs.createWriteStream("setup_debug.log", { flags: "a" });
  const log = (msg) => {
    console.log(msg);
    logStream.write(msg + "\n");
  };

  log("Starting setup...");
  try {
    const client = await pool.connect();
    log("Connected!");
    try {
      log("Creating table...");
      await client.query(createTableSQL);
      log("Table created successfully!");

      const res = await client.query("SELECT * FROM community_events LIMIT 1");
      log(`Verification SELECT success. Rows: ${res.rowCount}`);
    } catch (err) {
      log(`Error creating table: ${err.message}`);
    } finally {
      client.release();
      log("Released client");
      pool.end();
    }
  } catch (err) {
    log(`Connection Error: ${err.message}`);
    if (err.message.includes("does not exist")) {
      // Log environment info
      log(`Current Dir: ${process.cwd()}`);
    }
  }
}

setup();
