const pool = require('./src/config/database');

async function createPermissionsTables() {
  const client = await pool.connect();
  
  try {
    console.log('Creating permissions tables...');
    
    // Create permissions table
    await client.query(`
      CREATE TABLE IF NOT EXISTS permissions (
        id SERIAL PRIMARY KEY,
        code VARCHAR(50) UNIQUE NOT NULL,
        name VARCHAR(100) NOT NULL,
        description TEXT,
        module VARCHAR(50) NOT NULL,
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('✓ Created permissions table');
    
    // Create user_permissions table
    await client.query(`
      CREATE TABLE IF NOT EXISTS user_permissions (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        permission_id INTEGER NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
        granted_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
        granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(user_id, permission_id)
      )
    `);
    console.log('✓ Created user_permissions table');
    
    // Create user_communities table (if not exists)
    await client.query(`
      CREATE TABLE IF NOT EXISTS user_communities (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        community_id INTEGER NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
        granted_by INTEGER REFERENCES users(id) ON DELETE SET NULL,
        granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(user_id, community_id)
      )
    `);
    console.log('✓ Created user_communities table');
    
    // Insert default permissions
    const permissions = [
      // Sisters
      ['sisters.view', 'Xem danh sách nữ tu', 'Cho phép xem danh sách và thông tin nữ tu', 'sisters'],
      ['sisters.create', 'Thêm nữ tu mới', 'Cho phép tạo hồ sơ nữ tu mới', 'sisters'],
      ['sisters.update', 'Chỉnh sửa nữ tu', 'Cho phép cập nhật thông tin nữ tu', 'sisters'],
      ['sisters.delete', 'Xóa nữ tu', 'Cho phép xóa hồ sơ nữ tu', 'sisters'],
      
      // Communities
      ['communities.view', 'Xem cộng đoàn', 'Cho phép xem danh sách cộng đoàn', 'communities'],
      ['communities.create', 'Thêm cộng đoàn', 'Cho phép tạo cộng đoàn mới', 'communities'],
      ['communities.update', 'Chỉnh sửa cộng đoàn', 'Cho phép cập nhật thông tin cộng đoàn', 'communities'],
      ['communities.delete', 'Xóa cộng đoàn', 'Cho phép xóa cộng đoàn', 'communities'],
      
      // Vocation Journey
      ['journey.view', 'Xem hành trình', 'Cho phép xem hành trình ơn gọi', 'journey'],
      ['journey.create', 'Thêm hành trình', 'Cho phép tạo giai đoạn mới', 'journey'],
      ['journey.update', 'Chỉnh sửa hành trình', 'Cho phép cập nhật hành trình', 'journey'],
      ['journey.delete', 'Xóa hành trình', 'Cho phép xóa hành trình', 'journey'],
      
      // Missions
      ['missions.view', 'Xem sứ vụ', 'Cho phép xem danh sách sứ vụ', 'missions'],
      ['missions.create', 'Thêm sứ vụ', 'Cho phép tạo sứ vụ mới', 'missions'],
      ['missions.update', 'Chỉnh sửa sứ vụ', 'Cho phép cập nhật sứ vụ', 'missions'],
      ['missions.delete', 'Xóa sứ vụ', 'Cho phép xóa sứ vụ', 'missions'],
      
      // Health
      ['health.view', 'Xem sức khỏe', 'Cho phép xem hồ sơ sức khỏe', 'health'],
      ['health.create', 'Thêm hồ sơ sức khỏe', 'Cho phép tạo hồ sơ sức khỏe', 'health'],
      ['health.update', 'Chỉnh sửa sức khỏe', 'Cho phép cập nhật hồ sơ sức khỏe', 'health'],
      ['health.delete', 'Xóa sức khỏe', 'Cho phép xóa hồ sơ sức khỏe', 'health'],
      
      // Education
      ['education.view', 'Xem học vấn', 'Cho phép xem hồ sơ học vấn', 'education'],
      ['education.create', 'Thêm học vấn', 'Cho phép tạo hồ sơ học vấn', 'education'],
      ['education.update', 'Chỉnh sửa học vấn', 'Cho phép cập nhật học vấn', 'education'],
      ['education.delete', 'Xóa học vấn', 'Cho phép xóa học vấn', 'education'],
      
      // Evaluations
      ['evaluations.view', 'Xem đánh giá', 'Cho phép xem đánh giá', 'evaluations'],
      ['evaluations.create', 'Thêm đánh giá', 'Cho phép tạo đánh giá mới', 'evaluations'],
      ['evaluations.update', 'Chỉnh sửa đánh giá', 'Cho phép cập nhật đánh giá', 'evaluations'],
      ['evaluations.delete', 'Xóa đánh giá', 'Cho phép xóa đánh giá', 'evaluations'],
      
      // Reports
      ['reports.view', 'Xem báo cáo', 'Cho phép xem các báo cáo', 'reports'],
      ['reports.generate', 'Tạo báo cáo', 'Cho phép tạo báo cáo mới', 'reports'],
      ['reports.export', 'Xuất báo cáo', 'Cho phép xuất báo cáo', 'reports'],
      
      // Settings
      ['settings.view', 'Xem cài đặt', 'Cho phép xem cài đặt hệ thống', 'settings'],
      ['settings.update', 'Chỉnh sửa cài đặt', 'Cho phép thay đổi cài đặt hệ thống', 'settings'],
      
      // Users
      ['users.view', 'Xem người dùng', 'Cho phép xem danh sách người dùng', 'users'],
      ['users.create', 'Thêm người dùng', 'Cho phép tạo tài khoản mới', 'users'],
      ['users.update', 'Chỉnh sửa người dùng', 'Cho phép cập nhật thông tin người dùng', 'users'],
      ['users.delete', 'Xóa người dùng', 'Cho phép xóa tài khoản', 'users'],
      ['users.manage_permissions', 'Quản lý phân quyền', 'Cho phép gán quyền và cộng đoàn cho người dùng', 'users'],
      
      // Audit
      ['audit.view', 'Xem nhật ký', 'Cho phép xem nhật ký hệ thống', 'audit'],
      
      // Dashboard
      ['dashboard.view', 'Xem tổng quan', 'Cho phép xem trang tổng quan', 'dashboard'],

      // Posts
      ['posts.view', 'Xem bài đăng', 'Cho phép xem danh sách và chi tiết bài đăng', 'posts'],
      ['posts.create', 'Tạo bài đăng', 'Cho phép tạo bài đăng mới', 'posts'],
      ['posts.update', 'Cập nhật bài đăng', 'Cho phép cập nhật bài đăng', 'posts'],
      ['posts.delete', 'Xóa bài đăng', 'Cho phép xóa bài đăng', 'posts'],
    ];
    
    for (const [code, name, description, module] of permissions) {
      await client.query(`
        INSERT INTO permissions (code, name, description, module)
        VALUES ($1, $2, $3, $4)
        ON CONFLICT (code) DO UPDATE SET 
          name = EXCLUDED.name, 
          description = EXCLUDED.description
      `, [code, name, description, module]);
    }
    console.log(`✓ Inserted ${permissions.length} default permissions`);
    
    // Grant all permissions to admin user (id=1)
    const allPerms = await client.query('SELECT id FROM permissions');
    for (const perm of allPerms.rows) {
      await client.query(`
        INSERT INTO user_permissions (user_id, permission_id, granted_by)
        VALUES (1, $1, 1)
        ON CONFLICT (user_id, permission_id) DO NOTHING
      `, [perm.id]);
    }
    console.log(`✓ Granted all permissions to admin user`);
    
    console.log('\n✅ Permissions setup complete!');
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    client.release();
    process.exit();
  }
}

createPermissionsTables();
