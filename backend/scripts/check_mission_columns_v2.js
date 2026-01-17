const db = require("../src/config/database");

async function checkColumns() {
  try {
    console.log("Checking for 'documents' column in 'missions' table...");

    const query = `
      SELECT column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name = 'missions' AND column_name = 'documents'
    `;

    // db.query in database.js returns [rows, fields] to mimic mysql2
    const [rows] = await db.query(query);

    if (rows.length > 0) {
      console.log("FOUND 'documents' column!");
      console.log(rows[0]);
    } else {
      console.log("NOT FOUND 'documents' column.");
    }
  } catch (error) {
    console.error("Error checking columns:", error);
  } finally {
    if (db.end) await db.end();
    process.exit();
  }
}

// Give it a moment to connect
setTimeout(checkColumns, 1000);
