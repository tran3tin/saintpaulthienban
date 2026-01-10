const pool = require("../config/database");

async function check() {
  try {
    const [tables] = await pool.query("SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE 'community_roles'");
    console.log("Tables found:", tables);
    process.exit(0);
  } catch (err) {
    console.error("Error:", err.message);
    process.exit(1);
  }
}

check();
