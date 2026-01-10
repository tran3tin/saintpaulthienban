# Hướng dẫn khởi động dự án HR Records

## Bạn đã hoàn thành:
✓ Cài đặt PostgreSQL
✓ Tạo database `hr_records`
✓ Cấu hình file .env

## Các bước tiếp theo:

### Bước 1: Kiểm tra kết nối PostgreSQL
Mở PowerShell mới và chạy:
```powershell
cd e:\project\01-hoi-dong-osp\backend
node test_connection.js
```

Nếu thấy "✓ Kết nối PostgreSQL hoạt động tốt!" thì chuyển sang bước 2.

### Bước 2: Chạy migrations để tạo các bảng
```powershell
node src/migrations/runMigrations.js up
```

Lệnh này sẽ tạo tất cả các bảng trong database hr_records.

### Bước 3: Tạo tài khoản admin
```powershell
node src/scripts/create_admin_user.js
```

Tài khoản admin sẽ được tạo với:
- Username: `admin`
- Password: `admin123`

### Bước 4: Khởi động Backend server
```powershell
npm run dev
```

Backend sẽ chạy tại: `http://localhost:5000`

### Bước 5: Khởi động Frontend (Terminal mới)
Mở PowerShell mới và chạy:
```powershell
cd e:\project\01-hoi-dong-osp\frontend
npm run dev
```

Frontend sẽ chạy tại: `http://localhost:5173`

## Hoặc chạy tất cả bằng 1 lệnh:
```powershell
cd e:\project\01-hoi-dong-osp\backend
node setup.js
```

Script này sẽ tự động chạy migrations và tạo admin user.

## Đăng nhập vào hệ thống:
1. Truy cập: `http://localhost:5173`
2. Đăng nhập với:
   - Username: `admin`
   - Password: `admin123`

## Nếu gặp lỗi:

### Lỗi "connect ECONNREFUSED"
- PostgreSQL chưa khởi động
- Mở pgAdmin 4 hoặc khởi động PostgreSQL service

### Lỗi "password authentication failed"
- Kiểm tra lại password trong file `.env`
- Password mặc định: `140293NgocDiem!`

### Lỗi "database does not exist"
- Tạo database `hr_records` trong pgAdmin 4:
  - Right click "Databases" → Create → Database
  - Name: `hr_records`

### Lỗi "relation does not exist"
- Migrations chưa chạy
- Chạy lại: `node src/migrations/runMigrations.js up`
