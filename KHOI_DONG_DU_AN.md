# HƯỚNG DẪN KHỞI ĐỘNG DỰ ÁN (Sau khi cài PostgreSQL)

## ✅ Bạn đã hoàn thành:
- Cài đặt PostgreSQL
- Tạo database `hr_records`

## 📋 Các bước tiếp theo:

### **Bước 1: Mở PowerShell trong thư mục backend**
```powershell
cd E:\project\01-hoi-dong-osp\backend
```

### **Bước 2: Chạy script setup tự động**

Chạy file batch sau (click đúp hoặc chạy trong PowerShell):
```powershell
.\setup.bat
```

Script này sẽ tự động:
1. Kiểm tra kết nối PostgreSQL  
2. Chạy migrations để tạo tất cả các bảng
3. Tạo tài khoản admin (username: admin, password: admin123)
4. Hiển thị kết quả

### **Hoặc chạy từng bước riêng:**

#### 2.1. Kiểm tra kết nối
```powershell
node test_connection.js
```
**Kết quả mong đợi:** "✓ Kết nối PostgreSQL hoạt động tốt!"

#### 2.2. Chạy migrations
```powershell
node src/migrations/runMigrations.js up
```
**Kết quả:** Tạo khoảng 15-20 bảng (users, communities, sisters, v.v.)

#### 2.3. Tạo admin user
```powershell
node src/scripts/create_admin_user.js
```
**Kết quả:** "✓ Admin user created successfully"

#### 2.4. Kiểm tra kết quả
```powershell
node check_tables.js
```
**Kết quả:** Danh sách các bảng đã tạo

### **Bước 3: Khởi động Backend Server**
```powershell
npm run dev
```
**Kết quả:** "Server running on port 5000"

### **Bước 4: Khởi động Frontend Server (Terminal mới)**

Mở PowerShell mới:
```powershell
cd E:\project\01-hoi-dong-osp\frontend
npm run dev
```
**Kết quả:** "Local: http://localhost:5173"

### **Bước 5: Đăng nhập vào hệ thống**

1. Mở trình duyệt: `http://localhost:5173`
2. Đăng nhập với:
   - **Username:** `admin`
   - **Password:** `admin123`

---

## 🔧 Xử lý lỗi phổ biến

### ❌ Lỗi: "connect ECONNREFUSED"
**Nguyên nhân:** PostgreSQL chưa khởi động

**Giải pháp:**
- Mở **pgAdmin 4** hoặc **Services** (services.msc)
- Tìm "postgresql-x64-16" và Start

### ❌ Lỗi: "password authentication failed"
**Nguyên nhân:** Sai mật khẩu trong file .env

**Giải pháp:**
- Mở `backend/.env`
- Kiểm tra `PGPASSWORD=140293NgocDiem!`
- Nếu sai, sửa lại đúng mật khẩu bạn đã đặt khi cài PostgreSQL

### ❌ Lỗi: "database \"hr_records\" does not exist"
**Nguyên nhân:** Chưa tạo database

**Giải pháp:**
- Mở **pgAdmin 4**
- Right-click "Databases" → Create → Database
- Name: `hr_records` → Save

### ❌ Lỗi khi chạy migrations
**Nguyên nhân:** Cú pháp migration chưa chuẩn PostgreSQL

**Giải pháp:**
- Chạy script fix: `node fix_mysql_syntax.js`
- Sau đó chạy lại migrations

### ❌ Lỗi: "relation does not exist"
**Nguyên nhân:** Migrations chưa chạy hoặc chạy thất bại

**Giải pháp:**
- Xóa tất cả tables trong database (nếu có)
- Chạy lại: `node src/migrations/runMigrations.js up`

---

## 📝 Ghi chú quan trọng

1. **Backend phải chạy trước Frontend**
2. **Cần 2 terminal riêng biệt** (1 cho backend, 1 cho frontend)
3. **Không tắt terminal** khi server đang chạy
4. **Port 5000 & 5173** phải available (không bị chiếm bởi app khác)

## 🎯 Checklist hoàn thành

- [ ] PostgreSQL đã khởi động
- [ ] Database `hr_records` đã tạo
- [ ] Migrations chạy thành công (có tables)
- [ ] Admin user đã được tạo
- [ ] Backend server đang chạy (port 5000)
- [ ] Frontend server đang chạy (port 5173)
- [ ] Đăng nhập thành công với admin/admin123

---

**Nếu gặp vấn đề, hãy chạy từng lệnh một và gửi lại thông báo lỗi cụ thể!**
