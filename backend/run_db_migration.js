const fs = require("fs");
const path = require("path");
const { Pool } = require("pg");
require("dotenv").config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl:
    process.env.NODE_ENV === "production"
      ? { rejectUnauthorized: false }
      : false,
});

async function runMigration() {
  try {
    const sqlPath = path.join(
      __dirname,
      "db",
      "migrations",
      "create_user_communities_table.sql",
    );
    const sql = fs.readFileSync(sqlPath, "utf8");
    console.log("Running migration:", sqlPath);
    await pool.query(sql);
    console.log("Migration completed successfully.");
  } catch (err) {
    console.error("Migration failed:", err);
  } finally {
    await pool.end();
  }
}

runMigration();
