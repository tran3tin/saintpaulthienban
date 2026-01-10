# MySQL to PostgreSQL Migration Guide

## Các thay đổi đã thực hiện

### 1. Dependencies (package.json)
✅ Đã thay thế:
- `mysql2` → `pg` (PostgreSQL driver)
- `mysqldump` → Loại bỏ (sẽ dùng `pg_dump` cho PostgreSQL)
- Thêm `pg-format` để format SQL queries

### 2. Database Configuration (src/config/database.js)
✅ Đã chuyển từ MySQL Pool sang PostgreSQL Pool:
- Sử dụng `pg` module thay vì `mysql2/promise`
- Hỗ trợ `DATABASE_URL` connection string
- Cấu hình SSL cho production
- Thay đổi port mặc định từ 3306 → 5432

### 3. Migration Files Converted
✅ Đã convert 6 migration files chính:
1. `001_create_users_table.js` - Bảng users
2. `002_create_communities_table.js` - Bảng communities  
3. `003_create_sisters_table.js` - Bảng sisters
4. `004_create_vocation_journey_table.js` - Bảng vocation_journey
5. `005_create_community_assignments_table.js` - Bảng community_assignments
6. `007_create_education_table.js` - Bảng education
7. `010_create_evaluations_table.js` - Bảng evaluations

### 4. Syntax Changes (MySQL → PostgreSQL)

#### Auto Increment
```sql
-- MySQL
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY

-- PostgreSQL
id SERIAL PRIMARY KEY
```

#### ENUM Types
```sql
-- MySQL
status ENUM('active','inactive')

-- PostgreSQL  
status VARCHAR(20) CHECK (status IN ('active','inactive'))
```

#### Data Types
- `INT UNSIGNED` → `INTEGER`
- `BIGINT UNSIGNED` → `BIGINT`
- `TINYINT(1)` → `SMALLINT`
- `DATETIME` → `TIMESTAMP`
- `LONGTEXT`/`MEDIUMTEXT` → `TEXT`

#### Auto-Update Timestamp
```sql
-- MySQL
updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

-- PostgreSQL (requires trigger)
CREATE FUNCTION update_table_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER table_updated_at_trigger
BEFORE UPDATE ON table_name
FOR EACH ROW
EXECUTE FUNCTION update_table_updated_at();
```

#### Indexes
```sql
-- MySQL (inline)
INDEX idx_name (column)

-- PostgreSQL (separate statement)
CREATE INDEX IF NOT EXISTS idx_name ON table_name(column);
```

#### Connection Pool API
```javascript
// MySQL
const connection = await pool.getConnection();
try {
  await connection.query(sql);
} finally {
  connection.release();
}

// PostgreSQL
const client = await pool.connect();
try {
  await client.query(sql);
} finally {
  client.release();
}
```

## Environment Variables

Cập nhật file `.env`:

```env
# PostgreSQL Connection
DATABASE_URL=postgresql://username:password@host:5432/database_name

# Hoặc dùng từng biến riêng
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=your_password
PGDATABASE=your_database_name

# Production (Railway/Render tự động set DATABASE_URL)
NODE_ENV=production
```

## Query Placeholders

### MySQL sử dụng `?`
```javascript
await connection.query('SELECT * FROM users WHERE id = ?', [userId]);
```

### PostgreSQL sử dụng `$1, $2, ...`
```javascript
await client.query('SELECT * FROM users WHERE id = $1', [userId]);
```

**Giải pháp:** Sử dụng `queryAdapter.js` để tự động convert:
```javascript
const { executeQuery } = require('../utils/queryAdapter');
await executeQuery(pool, 'SELECT * FROM users WHERE id = ?', [userId]);
```

## Các bước tiếp theo

### 1. Cập nhật các migration files còn lại
- Missions table
- Health records table
- Training courses table
- Audit logs table
- Lookup tables
- Permission tables

### 2. Cập nhật Models
Các file trong `src/models/` cần:
- Thay `pool.getConnection()` → `pool.connect()`
- Sử dụng `queryAdapter` để convert placeholders
- Xử lý PostgreSQL-specific errors

### 3. Cập nhật Controllers
- Kiểm tra các raw SQL queries
- Đảm bảo sử dụng correct placeholder syntax
- Test error handling

### 4. Testing
```bash
# Chạy migrations
npm run migrate

# Test connection
node -e "require('./src/config/database')"

# Test các endpoints
npm run dev
```

## Backup Strategy

### MySQL (old)
```bash
mysqldump -u user -p database > backup.sql
```

### PostgreSQL (new)
```bash
pg_dump -U user database > backup.sql

# Với Railway/Render
pg_dump $DATABASE_URL > backup.sql
```

## Common Issues

### 1. Case Sensitivity
PostgreSQL là case-sensitive với identifiers không có quotes.
- Dùng lowercase cho tên table/column
- Hoặc dùng double quotes: `"TableName"`

### 2. Boolean Values
- MySQL: `0`/`1`, `TRUE`/`FALSE`
- PostgreSQL: `TRUE`/`FALSE`, `'t'`/`'f'`

### 3. String Concatenation
- MySQL: `CONCAT(a, b)` hoặc `a || b`
- PostgreSQL: `a || b` hoặc `CONCAT(a, b)`

### 4. Limit/Offset
- MySQL: `LIMIT 10 OFFSET 20`
- PostgreSQL: `LIMIT 10 OFFSET 20` (giống nhau)

## Migration Checklist

- [x] Cài đặt `pg` package
- [x] Cập nhật database config
- [x] Tạo query adapter utility
- [x] Convert 6 main migration files
- [ ] Convert remaining migration files
- [ ] Update all models với query adapter
- [ ] Update all controllers
- [ ] Test all endpoints
- [ ] Update backup scripts
- [ ] Deploy to production

## Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [node-postgres (pg) Documentation](https://node-postgres.com/)
- [MySQL to PostgreSQL Migration Guide](https://wiki.postgresql.org/wiki/Converting_from_other_Databases_to_PostgreSQL)
