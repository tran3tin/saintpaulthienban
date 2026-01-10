# Hướng dẫn khởi động dự án trên Local

## Bước 1: Cài đặt PostgreSQL

### Cách 1: Cài đặt PostgreSQL trực tiếp (Khuyến nghị cho Windows)

1. **Download PostgreSQL:**
   - Truy cập: https://www.postgresql.org/download/windows/
   - Tải PostgreSQL 16 (hoặc 15)
   - Chạy installer

2. **Cài đặt:**
   - Chọn password: `140293NgocDiem!`
   - Port: `5432` (default)
   - Locale: `Default`

3. **Tạo Database:**
   Mở **pgAdmin 4** hoặc **SQL Shell (psql)**:
   ```sql
   CREATE DATABASE hr_records;
   ```

### Cách 2: Dùng Docker (Nếu đã có Docker Desktop)

```bash
# Download và cài Docker Desktop từ: https://www.docker.com/products/docker-desktop

# Sau khi cài Docker, chạy:
docker run --name postgres-hr -e POSTGRES_PASSWORD=140293NgocDiem! -e POSTGRES_DB=hr_records -p 5432:5432 -d postgres:16

# Kiểm tra đã chạy chưa:
docker ps
```

## Bước 2: Cài đặt Dependencies

```bash
# Backend
cd e:\project\01-hoi-dong-osp\backend
npm install

# Frontend
cd e:\project\01-hoi-dong-osp\frontend
npm install
```

## Bước 3: Cấu hình môi trường

File `.env` trong `backend/` đã được cấu hình:
```env
DATABASE_URL=postgresql://postgres:140293NgocDiem!@localhost:5432/hr_records
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=140293NgocDiem!
PGDATABASE=hr_records
```

## Bước 4: Chạy Migrations

```bash
cd e:\project\01-hoi-dong-osp\backend

# Kiểm tra kết nối database
node -e "require('./src/config/database')"

# Chạy migrations (tạo tables)
node src/migrations/runMigrations.js
```

## Bước 5: Khởi động Server

### Backend:
```bash
cd e:\project\01-hoi-dong-osp\backend
npm run dev
```
Backend sẽ chạy tại: http://localhost:5000

### Frontend:
```bash
cd e:\project\01-hoi-dong-osp\frontend
npm run dev
```
Frontend sẽ chạy tại: http://localhost:5173 (hoặc 5174)

## Bước 6: Tạo User Admin đầu tiên

```bash
cd e:\project\01-hoi-dong-osp\backend

# Chạy script tạo admin
node src/scripts/create_admin_user.js
```

## Kiểm tra kết nối

1. **Test Backend:**
   - Mở browser: http://localhost:5000
   - Hoặc: http://localhost:5000/api/health

2. **Test Frontend:**
   - Mở browser: http://localhost:5173
   - Login với admin user vừa tạo

## Troubleshooting

### Lỗi: "connection refused"
- Kiểm tra PostgreSQL đang chạy:
  ```bash
  # Windows Services: tìm "postgresql"
  # Hoặc trong pgAdmin 4
  ```

### Lỗi: "password authentication failed"
- Kiểm tra password trong `.env` khớp với PostgreSQL password

### Lỗi: "database does not exist"
```sql
-- Mở pgAdmin 4 hoặc psql và chạy:
CREATE DATABASE hr_records;
```

### Lỗi migrations
```bash
# Reset database (XÓA TẤT CẢ DỮ LIỆU!)
cd backend
node src/scripts/reset_database.js

# Chạy lại migrations
node src/migrations/runMigrations.js
```

## Ports đang sử dụng

- PostgreSQL: `5432`
- Backend API: `5000`
- Frontend: `5173` hoặc `5174`

## Lệnh hữu ích

```bash
# Xem logs PostgreSQL
# Windows: C:\Program Files\PostgreSQL\16\data\log\

# Backup database
pg_dump -U postgres hr_records > backup.sql

# Restore database
psql -U postgres hr_records < backup.sql

# Kết nối vào database
psql -U postgres -d hr_records
```

## Tài liệu tham khảo

- [PostgreSQL Migration Guide](./POSTGRESQL_MIGRATION.md)
- Backend API: http://localhost:5000/api-docs (nếu có Swagger)
