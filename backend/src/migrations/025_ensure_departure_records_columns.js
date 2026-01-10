// Migration: Ensure departure_records has all required columns for Đi vắng features
// Run: node src/migrations/025_ensure_departure_records_columns.js

const pool = require("../config/database");

const columnsToAdd = [
  {
    name: "type",
    definition: "VARCHAR(50) NULL",
  },
  {
    name: "expected_return_date",
    definition: "DATE NULL",
  },
  {
    name: "return_date",
    definition: "DATE NULL",
  },
  {
    name: "destination",
    definition: "VARCHAR(255) NULL",
  },
  {
    name: "contact_phone",
    definition: "VARCHAR(50) NULL",
  },
  {
    name: "contact_address",
    definition: "TEXT NULL",
  },
  {
    name: "approved_by",
    definition: "INTEGER NULL",
  },
  {
    name: "notes",
    definition: "TEXT NULL",
  },
  {
    name: "documents",
    definition: "JSONB NULL",
  },
];

async function up() {
  const client = await pool.connect();
  try {
    console.log("Checking departure_records columns...");

    for (const col of columnsToAdd) {
      console.log(`Ensuring column ${col.name} exists...`);
      await client.query(
        `ALTER TABLE departure_records ADD COLUMN IF NOT EXISTS ${col.name} ${col.definition}`
      );
    }

    console.log("Ensuring stage_at_departure allows NULL (if column exists)...");
    await client.query(`
      DO $$
      BEGIN
        IF EXISTS (
          SELECT 1
          FROM information_schema.columns
          WHERE table_schema = current_schema()
            AND table_name = 'departure_records'
            AND column_name = 'stage_at_departure'
        ) THEN
          ALTER TABLE departure_records ALTER COLUMN stage_at_departure DROP NOT NULL;
        END IF;
      END $$;
    `);

    console.log("Migration 025_ensure_departure_records_columns completed.");
  } catch (err) {
    console.error("Migration failed:", err.message);
    throw err;
  } finally {
    client.release();
  }
}

async function down() {
  const client = await pool.connect();
  try {
    console.log("Down migration: no columns dropped (safe migration).");
  } finally {
    client.release();
  }
}

if (require.main === module) {
  up()
    .then(() => {
      console.log("Done");
      process.exit(0);
    })
    .catch((err) => {
      console.error(err);
      process.exit(1);
    });
}

module.exports = { up, down };
