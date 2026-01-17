const pool = require("../src/config/database");

async function checkTable() {
  const client = await pool.connect();
  console.log("Connected to DB.");
  try {
    const res = await client.query("SELECT * FROM community_events LIMIT 1");
    console.log("Success! Table exists.");
    console.log(
      "Fields:",
      res.fields.map((f) => f.name),
    );
  } catch (err) {
    console.error("SQL Error:", err.message);
  } finally {
    client.release();
    pool.end();
  }
}

checkTable();
