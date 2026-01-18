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
    ssl:
      process.env.NODE_ENV === "production"
        ? { rejectUnauthorized: false }
        : false,
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 60000, // Increased to 60s for cold starts (Supabase/Render)
    statement_timeout: 60000, // Query timeout
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
      "Missing required database environment variables. Need either DATABASE_URL or DB_HOST/PGHOST, DB_USER/PGUSER, and DB_NAME/PGDATABASE",
    );
  }

  console.log(`Connecting to PostgreSQL at ${host}:${port}/${database}`);
  pool = new Pool({
    host,
    port: Number(port),
    user,
    password,
    database,
    ssl:
      process.env.NODE_ENV === "production"
        ? { rejectUnauthorized: false }
        : false,
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 60000, // Increased to 60s for cold starts
    statement_timeout: 60000,
  });
}

// Add compatibility layer for MySQL-style methods
// execute() - converts ? to $1, $2 and returns [rows, fields] format
pool.execute = async function (query, params = []) {
  const client = await pool.connect();
  try {
    // Convert MySQL ? placeholders to PostgreSQL $1, $2, etc.
    let pgQuery = query;
    let pgParams = params;

    if (query.includes("?")) {
      pgParams = [];
      let paramIndex = 1;
      pgQuery = query.replace(/\?/g, () => {
        pgParams.push(params[paramIndex - 1]);
        return `$${paramIndex++}`;
      });
    }

    const result = await client.query(pgQuery, pgParams);

    // Return in MySQL format: [rows, fields]
    // PostgreSQL doesn't have fields in the same way, so we return empty array
    return [result.rows, []];
  } finally {
    client.release();
  }
};

// query() - align with MySQL mysql2 API shape used across the codebase
// NOTE: pg already provides pool.query(sql, params) -> { rows }, but many files expect [rows, fields]
const _pgQuery = pool.query.bind(pool);
pool.query = async function (query, params = []) {
  // Convert MySQL ? placeholders to PostgreSQL $1, $2, etc.
  let pgQuery = query;
  let pgParams = params;

  if (typeof query === "string" && query.includes("?")) {
    pgParams = [];
    let paramIndex = 1;
    pgQuery = query.replace(/\?/g, () => {
      pgParams.push(params[paramIndex - 1]);
      return `$${paramIndex++}`;
    });
  }

  const result = await _pgQuery(pgQuery, pgParams);
  return [result.rows, []];
};

// getConnection() - returns a client (PostgreSQL equivalent)
pool.getConnection = async function () {
  return await pool.connect();
};

// Export function to test connection with retry logic (called from server startup)
const waitForConnection = async () => {
  const maxRetries = 5;
  const retryDelayMs = 5000;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      console.log(`[Database] Connection attempt ${attempt}/${maxRetries}...`);
      const client = await pool.connect();
      const result = await client.query("SELECT NOW()");
      console.log("✅ PostgreSQL connection pool established successfully.");
      console.log("📅 Server time:", result.rows[0].now);
      client.release();
      return true;
    } catch (error) {
      console.error(
        `❌ Database connection attempt ${attempt} failed:`,
        error.message,
      );

      if (attempt < maxRetries) {
        console.log(`⏳ Retrying in ${retryDelayMs / 1000} seconds...`);
        await new Promise((resolve) => setTimeout(resolve, retryDelayMs));
      } else {
        throw new Error(`Failed to connect to database after ${maxRetries} attempts`);
      }
    }
  }
};

module.exports = pool;
module.exports.waitForConnection = waitForConnection;
