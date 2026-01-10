// Migration: Remove Role System
// Date: 2025-12-09
// Description: Remove role-based access control, switch to user-based permissions

const createMigration = (pool) => {
  const up = async () => {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      console.log("Starting role system removal migration...");

      // 1. Drop foreign key constraint from users table if exists
      console.log("Removing role_id from users table...");
      await connection.query(`
        ALTER TABLE users 
        DROP FOREIGN KEY IF EXISTS users_ibfk_1
      `);

      // 2. Drop role_id column from users
      await connection.query(`
        ALTER TABLE users 
        DROP COLUMN IF EXISTS role_id
      `);

      // 3. Drop role_permissions table
      console.log("Dropping role_permissions table...");
      await connection.query(`
        DROP TABLE IF EXISTS role_permissions
      `);

      // 4. Drop roles table
      console.log("Dropping roles table...");
      await connection.query(`
        DROP TABLE IF EXISTS roles
      `);

      // 5. Create permissions table if not exists
      console.log("Creating permissions table...");
      await connection.query(`
        CREATE TABLE IF NOT EXISTS permissions (
          id INT PRIMARY KEY AUTO_INCREMENT,
          code VARCHAR(50) UNIQUE NOT NULL,
          name VARCHAR(100) NOT NULL,
          description TEXT,
          module VARCHAR(50) NOT NULL,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          INDEX idx_code (code),
          INDEX idx_module (module)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);

      // 6. Create user_permissions table
      console.log("Creating user_permissions table...");
      await connection.query(`
        CREATE TABLE IF NOT EXISTS user_permissions (
          id INT PRIMARY KEY AUTO_INCREMENT,
          user_id INT NOT NULL,
          permission_id INT NOT NULL,
          granted_by INT,
          granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
          FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
          FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL,
          UNIQUE KEY unique_user_permission (user_id, permission_id),
          INDEX idx_user_id (user_id),
          INDEX idx_permission_id (permission_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);

      // 7. Create user_communities table for community-based filtering
      console.log("Creating user_communities table...");
      await connection.query(`
        CREATE TABLE IF NOT EXISTS user_communities (
          id INT PRIMARY KEY AUTO_INCREMENT,
          user_id INT NOT NULL,
          community_id INT NOT NULL,
          granted_by INT,
          granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
          FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE,
          FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL,
          UNIQUE KEY unique_user_community (user_id, community_id),
          INDEX idx_user_id (user_id),
          INDEX idx_community_id (community_id)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);

      // 8. Insert default permissions
      console.log("Inserting default permissions...");
      await connection.query(`
        INSERT IGNORE INTO permissions (code, name, description, module) VALUES
        -- Sisters
        ('sisters.view', 'Xem danh sách nữ tu', 'Cho phép xem danh sách và thông tin nữ tu', 'sisters'),
        ('sisters.create', 'Thêm nữ tu mới', 'Cho phép tạo hồ sơ nữ tu mới', 'sisters'),
        ('sisters.update', 'Chỉnh sửa nữ tu', 'Cho phép cập nhật thông tin nữ tu', 'sisters'),
        ('sisters.delete', 'Xóa nữ tu', 'Cho phép xóa hồ sơ nữ tu', 'sisters'),
        
        -- Communities
        ('communities.view', 'Xem cộng đoàn', 'Cho phép xem danh sách cộng đoàn', 'communities'),
        ('communities.create', 'Thêm cộng đoàn', 'Cho phép tạo cộng đoàn mới', 'communities'),
        ('communities.update', 'Chỉnh sửa cộng đoàn', 'Cho phép cập nhật thông tin cộng đoàn', 'communities'),
        ('communities.delete', 'Xóa cộng đoàn', 'Cho phép xóa cộng đoàn', 'communities'),
        
        -- Vocation Journey
        ('journey.view', 'Xem hành trình', 'Cho phép xem hành trình ơn gọi', 'journey'),
        ('journey.create', 'Thêm hành trình', 'Cho phép tạo giai đoạn mới', 'journey'),
        ('journey.update', 'Chỉnh sửa hành trình', 'Cho phép cập nhật hành trình', 'journey'),
        ('journey.delete', 'Xóa hành trình', 'Cho phép xóa hành trình', 'journey'),
        
        -- Missions
        ('missions.view', 'Xem sứ vụ', 'Cho phép xem danh sách sứ vụ', 'missions'),
        ('missions.create', 'Thêm sứ vụ', 'Cho phép tạo sứ vụ mới', 'missions'),
        ('missions.update', 'Chỉnh sửa sứ vụ', 'Cho phép cập nhật sứ vụ', 'missions'),
        ('missions.delete', 'Xóa sứ vụ', 'Cho phép xóa sứ vụ', 'missions'),
        
        -- Health
        ('health.view', 'Xem sức khỏe', 'Cho phép xem hồ sơ sức khỏe', 'health'),
        ('health.create', 'Thêm hồ sơ sức khỏe', 'Cho phép tạo hồ sơ sức khỏe', 'health'),
        ('health.update', 'Chỉnh sửa sức khỏe', 'Cho phép cập nhật hồ sơ sức khỏe', 'health'),
        ('health.delete', 'Xóa sức khỏe', 'Cho phép xóa hồ sơ sức khỏe', 'health'),
        
        -- Education
        ('education.view', 'Xem học vấn', 'Cho phép xem hồ sơ học vấn', 'education'),
        ('education.create', 'Thêm học vấn', 'Cho phép tạo hồ sơ học vấn', 'education'),
        ('education.update', 'Chỉnh sửa học vấn', 'Cho phép cập nhật học vấn', 'education'),
        ('education.delete', 'Xóa học vấn', 'Cho phép xóa học vấn', 'education'),
        
        -- Evaluations
        ('evaluations.view', 'Xem đánh giá', 'Cho phép xem đánh giá', 'evaluations'),
        ('evaluations.create', 'Thêm đánh giá', 'Cho phép tạo đánh giá mới', 'evaluations'),
        ('evaluations.update', 'Chỉnh sửa đánh giá', 'Cho phép cập nhật đánh giá', 'evaluations'),
        ('evaluations.delete', 'Xóa đánh giá', 'Cho phép xóa đánh giá', 'evaluations'),
        
        -- Reports
        ('reports.view', 'Xem báo cáo', 'Cho phép xem các báo cáo', 'reports'),
        ('reports.generate', 'Tạo báo cáo', 'Cho phép tạo báo cáo mới', 'reports'),
        ('reports.export', 'Xuất báo cáo', 'Cho phép xuất báo cáo', 'reports'),
        
        -- Settings
        ('settings.view', 'Xem cài đặt', 'Cho phép xem cài đặt hệ thống', 'settings'),
        ('settings.update', 'Chỉnh sửa cài đặt', 'Cho phép thay đổi cài đặt hệ thống', 'settings'),
        
        -- Users
        ('users.view', 'Xem người dùng', 'Cho phép xem danh sách người dùng', 'users'),
        ('users.create', 'Thêm người dùng', 'Cho phép tạo tài khoản mới', 'users'),
        ('users.update', 'Chỉnh sửa người dùng', 'Cho phép cập nhật thông tin người dùng', 'users'),
        ('users.delete', 'Xóa người dùng', 'Cho phép xóa tài khoản', 'users'),
        ('users.manage_permissions', 'Quản lý phân quyền', 'Cho phép gán quyền và cộng đoàn cho người dùng', 'users'),
        
        -- Audit
        ('audit.view', 'Xem nhật ký', 'Cho phép xem nhật ký hệ thống', 'audit')
      `);

      await connection.commit();
      console.log("Role system removal completed successfully!");
    } catch (error) {
      await connection.rollback();
      console.error("Migration failed:", error);
      throw error;
    } finally {
      connection.release();
    }
  };

  const down = async () => {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();

      console.log("Rolling back role system removal...");

      // Drop new tables
      await connection.query("DROP TABLE IF EXISTS user_communities");
      await connection.query("DROP TABLE IF EXISTS user_permissions");
      await connection.query("DROP TABLE IF EXISTS permissions");

      // Recreate old structure (basic version)
      await connection.query(`
        CREATE TABLE IF NOT EXISTS roles (
          id INT PRIMARY KEY AUTO_INCREMENT,
          name VARCHAR(50) NOT NULL,
          description TEXT,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      `);

      await connection.query(`
        ALTER TABLE users 
        ADD COLUMN role_id INT,
        ADD FOREIGN KEY (role_id) REFERENCES roles(id)
      `);

      await connection.commit();
      console.log("Rollback completed");
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  };

  return { up, down };
};

module.exports = createMigration;
