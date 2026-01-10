/**
 * Kiểm tra database đã có bảng nào chưa
 */

const pool = require('./src/config/database');

async function checkTables() {
  const client = await pool.connect();
  
  try {
    console.log('Checking database tables...\n');
    
    const result = await client.query(`
      SELECT tablename 
      FROM pg_tables 
      WHERE schemaname = 'public'
      ORDER BY tablename
    `);
    
    if (result.rows.length === 0) {
      console.log('⚠️ No tables found. Run migrations first:');
      console.log('   node src/migrations/runMigrations.js up\n');
    } else {
      console.log(`✓ Found ${result.rows.length} tables:\n`);
      result.rows.forEach((row, i) => {
        console.log(`  ${i + 1}. ${row.tablename}`);
      });
      console.log('');
    }
    
    client.release();
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    client.release();
    process.exit(1);
  }
}

checkTables();
