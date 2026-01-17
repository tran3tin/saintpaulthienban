const db = require("../src/config/database");

async function checkConstraints() {
  try {
    console.log("Checking constraints for 'missions' table...");

    const query = `
      SELECT con.conname, pg_get_constraintdef(con.oid) as definition
      FROM pg_catalog.pg_constraint con
      INNER JOIN pg_catalog.pg_class rel ON rel.oid = con.conrelid
      WHERE rel.relname = 'missions';
    `;

    const [rows] = await db.query(query);
    console.log("Constraints found:");
    console.table(rows);

    // Also check column type
    const colQuery = `
      SELECT column_name, data_type, character_maximum_length
      FROM information_schema.columns 
      WHERE table_name = 'missions' AND column_name = 'field'
    `;
    const [cols] = await db.query(colQuery);
    console.log("Column definition:");
    console.table(cols);

    process.exit(0);
  } catch (error) {
    console.error("Error:", error);
    process.exit(1);
  }
}

checkConstraints();
