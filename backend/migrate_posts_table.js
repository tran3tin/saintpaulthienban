const pool = require('./src/config/database');

async function migratePostsTable() {
  const client = await pool.connect();
  try {
    console.log('Migrating posts table for PostgreSQL...');

    await client.query(`
      ALTER TABLE posts
        ADD COLUMN IF NOT EXISTS summary TEXT,
        ADD COLUMN IF NOT EXISTS is_important BOOLEAN DEFAULT FALSE,
        ADD COLUMN IF NOT EXISTS tags JSONB DEFAULT '[]'::jsonb;
    `);

    // Ensure updated_at has a default
    await client.query(`
      ALTER TABLE posts
        ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;
    `);

    console.log('✓ Posts table migration complete');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    client.release();
    process.exit();
  }
}

migratePostsTable();
