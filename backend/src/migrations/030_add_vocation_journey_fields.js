const db = require("../config/database");

const up = async () => {
  const client = await db.getConnection();
  try {
    // Add location, superior, and formation_director fields to vocation_journey table
    await client.query(`
      ALTER TABLE vocation_journey
        ADD COLUMN IF NOT EXISTS location VARCHAR(255) NULL,
        ADD COLUMN IF NOT EXISTS superior VARCHAR(255) NULL,
        ADD COLUMN IF NOT EXISTS formation_director VARCHAR(255) NULL
    `);
    console.log(
      "✅ Added location, superior, formation_director columns to vocation_journey table"
    );
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await db.getConnection();
  try {
    await client.query(`
      ALTER TABLE vocation_journey 
      DROP COLUMN IF EXISTS location,
      DROP COLUMN IF EXISTS superior,
      DROP COLUMN IF EXISTS formation_director
    `);
    console.log(
      "✅ Dropped location, superior, formation_director columns from vocation_journey table"
    );
  } finally {
    client.release();
  }
};

module.exports = { up, down };
