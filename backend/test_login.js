const pool = require('./src/config/database');
const UserModel = require('./src/models/UserModel');
const bcrypt = require('bcryptjs');

async function test() {
  try {
    console.log('Testing database connection...');
    
    // Check users table structure
    const client = await pool.connect();
    const cols = await client.query(
      "SELECT column_name FROM information_schema.columns WHERE table_name = 'users'"
    );
    console.log('Users table columns:', cols.rows.map(x => x.column_name));
    client.release();
    
    // Find admin user
    console.log('\nFinding admin user...');
    const user = await UserModel.findByUsername('admin');
    console.log('User:', {
      id: user?.id,
      username: user?.username,
      email: user?.email,
      role: user?.role,
      is_admin: user?.is_admin,
      is_active: user?.is_active
    });
    
    // Test password
    if (user) {
      const passwordMatch = await bcrypt.compare('admin123', user.password);
      console.log('Password match:', passwordMatch);
    }
    
    // Test getPermissions
    if (user) {
      console.log('\nGetting permissions...');
      const permissions = await UserModel.getPermissions(user.id);
      console.log('Permissions:', permissions);
    }
    
  } catch (e) {
    console.error('Error:', e);
  }
  process.exit();
}

test();
