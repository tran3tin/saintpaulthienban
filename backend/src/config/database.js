const { Pool } = require("pg");
const path = require("path");
const dotenv = require("dotenv");

// Ensure environment variables are loaded when this module is imported
dotenv.config({ path: path.resolve(__dirname, "../../.env") });

const {
  DATABASE_URL,
  PGHOST,
  PGPORT,
  PGUSER,
  PGPASSWORD,
  PGDATABASE,
  DB_HOST,
  DB_PORT,
  DB_USER,
  DB_PASSWORD,
  DB_NAME,
} = process.env;

let pool;

// Priority 1: Use connection URL if available (Railway/Render preferred method)
if (DATABASE_URL) {
  console.log("Using PostgreSQL connection URL");
  pool = new Pool({
    connectionString: DATABASE_URL,
    ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 10000,
  });
} else {
  // Priority 2: Use individual connection parameters
  const host = PGHOST || DB_HOST;
  const port = PGPORT || DB_PORT || 5432;
  const user = PGUSER || DB_USER;
  const password = PGPASSWORD || DB_PASSWORD;
  const database = PGDATABASE || DB_NAME;

  if (!host || !user || !database) {
    throw new Error(
      "Missing required database environment variables. Need either DATABASE_URL or DB_HOST/PGHOST, DB_USER/PGUSER, and DB_NAME/PGDATABASE"
    );
  }

  console.log(`Connecting to PostgreSQL at ${host}:${port}/${database}`);
  pool = new Pool({
    host,
    port: Number(port),
    user,
    password,
    database,
    ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false,
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 10000,
  });
}

(async () => {
  try {
    const client = await pool.connect();
    const result = await client.query('SELECT NOW()');
    console.log("PostgreSQL connection pool established successfully.");
    console.log("Server time:", result.rows[0].now);
    client.release();
  } catch (error) {
    console.error("Failed to initialize PostgreSQL connection pool:", error.message);
    throw error;
  }
})();

module.exports = pool;
