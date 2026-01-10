/**
 * Test PostgreSQL connection
 */

const pool = require('./src/config/database');

async function testConnection() {
  try {
    console.log('Đang kết nối PostgreSQL...');
    const client = await pool.connect();
    console.log('✓ Kết nối thành công!');
    
    const result = await client.query('SELECT NOW()');
    console.log('✓ Thời gian server:', result.rows[0].now);
    
    // Kiểm tra database
    const dbResult = await client.query('SELECT current_database()');
    console.log('✓ Database:', dbResult.rows[0].current_database);
    
    client.release();
    console.log('\n✓ Kết nối PostgreSQL hoạt động tốt!');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ Lỗi kết nối:', error.message);
    console.error('\nKiểm tra:');
    console.error('  - PostgreSQL đã khởi động chưa?');
    console.error('  - Database "hr_records" đã tạo chưa?');
    console.error('  - File .env có đúng thông tin kết nối không?');
    process.exit(1);
  }
}

testConnection();
