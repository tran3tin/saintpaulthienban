const { db } = require("../src/config/database");

async function checkColumns() {
  try {
    const [rows] = await db.query("SHOW COLUMNS FROM missions");
    console.log("Columns in 'missions' table:");
    rows.forEach((row) => console.log(`- ${row.Field} (${row.Type})`));
    process.exit(0);
  } catch (error) {
    console.error("Error:", error);
    process.exit(1);
  }
}

checkColumns();
