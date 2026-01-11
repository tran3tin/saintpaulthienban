# 🚀 Hướng Dẫn Deploy Lên Render + Supabase

## 📋 Tổng Quan

Dự án này sẽ được deploy với:
- **Backend**: Render (Node.js)
- **Frontend**: Render (Static Site hoặc Web Service)
- **Database**: Supabase (PostgreSQL)

---

## 1️⃣ Chuẩn Bị Database Trên Supabase

### Bước 1: Tạo Project Mới
1. Đăng nhập [Supabase](https://supabase.com)
2. Tạo project mới
3. Chọn region gần nhất (Singapore/Tokyo)
4. Đặt mật khẩu database (lưu lại an toàn!)

### Bước 2: Lấy Connection String
1. Vào **Project Settings** → **Database**
2. Tìm **Connection string** → chọn tab **URI**
3. Copy connection string có dạng:
   ```
   postgresql://postgres.xxxxx:[YOUR-PASSWORD]@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres
   ```
4. Thay `[YOUR-PASSWORD]` bằng mật khẩu database của bạn

### Bước 3: Tạo Database (Nếu Cần)
Mở SQL Editor trên Supabase và chạy:
```sql
CREATE DATABASE hr_records;
```

**Lưu ý**: Supabase mặc định tạo sẵn database `postgres`, bạn có thể dùng luôn hoặc tạo mới.

---

## 2️⃣ Deploy Backend Lên Render

### Bước 1: Tạo Web Service Mới
1. Đăng nhập [Render](https://render.com)
2. Click **New** → **Web Service**
3. Kết nối với GitHub repository của bạn
4. Chọn repository `saintpaulthienban`

### Bước 2: Cấu Hình Build Settings
```yaml
Name: saintpaul-backend
Region: Singapore (hoặc gần nhất)
Branch: main
Root Directory: backend
Runtime: Node
Build Command: npm install
Start Command: npm start
```

### Bước 3: Thêm Environment Variables
Vào tab **Environment** và thêm các biến sau:

```bash
# Database (quan trọng nhất!)
DATABASE_URL=postgresql://postgres.xxxxx:[YOUR-PASSWORD]@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres

# Node Environment
NODE_ENV=production

# JWT Secret (tạo random string mạnh)
JWT_SECRET=your_very_strong_random_secret_key_here_min_32_chars

# JWT Expiration
JWT_EXPIRE=7d

# CORS (sẽ cập nhật sau khi có frontend URL)
CORS_ORIGIN=https://saintpaulthienban.onrender.com

# Port (Render tự set, để mặc định)
# PORT=10000
```

**Tạo JWT_SECRET mạnh:**
```bash
# Trên terminal/PowerShell:
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

### Bước 4: Deploy
1. Click **Create Web Service**
2. Đợi build xong (~5-10 phút lần đầu)
3. Kiểm tra logs xem có lỗi không
4. Test endpoint: `https://your-backend.onrender.com/healthz`

---

## 3️⃣ Deploy Frontend Lên Render

### Bước 1: Cấu Hình API URL
Sửa file `frontend/.env.production`:
```bash
VITE_API_URL=https://your-backend.onrender.com/api
```

Hoặc sửa trực tiếp trong `frontend/src/services/api.js`:
```javascript
const RENDER_API = "https://your-backend.onrender.com/api";
let baseURL = import.meta.env.DEV ? LOCALHOST_API : RENDER_API;
```

### Bước 2: Tạo Static Site
1. Render Dashboard → **New** → **Static Site**
2. Chọn repository
3. Cấu hình:
   ```yaml
   Name: saintpaulthienban
   Branch: main
   Root Directory: frontend
   Build Command: npm install && npm run build
   Publish Directory: dist
   ```

### Bước 3: Deploy
1. Click **Create Static Site**
2. Đợi build (~3-5 phút)
3. Lấy URL: `https://saintpaulthienban.onrender.com`

### Bước 4: Cập Nhật CORS Backend
Quay lại **Backend Web Service** → **Environment**:
```bash
CORS_ORIGIN=https://saintpaulthienban.onrender.com
```
Click **Save Changes** → Backend sẽ tự redeploy

---

## 4️⃣ Kiểm Tra & Khởi Tạo Database

### Bước 1: Migrations Tự Động Chạy
Backend đã được cấu hình để tự chạy migrations khi khởi động:
- File `backend/src/config/initDatabase.js` sẽ tự gọi `runMigrations()`
- Kiểm tra logs trên Render xem có lỗi migrations không

### Bước 2: Tạo Admin User
Nếu chưa có admin, chạy script qua Render Shell:
1. Vào Backend Service → **Shell** tab
2. Chạy:
   ```bash
   cd /opt/render/project/src
   node src/scripts/create_admin_user.js
   ```

Hoặc kết nối trực tiếp vào Supabase SQL Editor và chạy:
```sql
INSERT INTO users (username, password, email, role, is_active, data_scope)
VALUES (
  'admin',
  '$2b$10$...', -- hash của 'admin123' (dùng bcrypt)
  'admin@ospsisters.vn',
  'admin',
  1,
  'all'
);
```

---

## 5️⃣ Troubleshooting

### ❌ Backend không kết nối được Database
**Triệu chứng**: Logs báo `"Missing required database environment variables"`

**Giải pháp**:
1. Kiểm tra `DATABASE_URL` đã set đúng chưa
2. Đảm bảo đã thay `[YOUR-PASSWORD]` bằng mật khẩu thật
3. Kiểm tra connection string có dấu `:` và `@` đúng vị trí
4. Test connection qua Supabase Dashboard → SQL Editor

### ❌ CORS Error từ Frontend
**Triệu chứng**: Console báo `"Access to fetch has been blocked by CORS"`

**Giải pháp**:
1. Kiểm tra `CORS_ORIGIN` ở backend có đúng URL frontend không
2. Đảm bảo **không có dấu `/` cuối URL**: 
   - ✅ `https://saintpaulthienban.onrender.com`
   - ❌ `https://saintpaulthienban.onrender.com/`
3. Redeploy backend sau khi đổi CORS_ORIGIN

### ❌ Frontend gọi sai API URL
**Triệu chứng**: Network tab báo 404 hoặc gọi `localhost:5000`

**Giải pháp**:
1. Kiểm tra `frontend/src/services/api.js`:
   ```javascript
   const RENDER_API = "https://your-backend.onrender.com/api";
   ```
2. Rebuild frontend: Render → **Manual Deploy** → **Clear build cache & deploy**

### ❌ Migrations không chạy
**Triệu chứng**: Bảng chưa được tạo, backend báo lỗi `"relation does not exist"`

**Giải pháp**:
1. Kiểm tra logs backend lúc startup
2. Chạy migrations thủ công qua Shell:
   ```bash
   node src/migrations/runMigrations.js
   ```
3. Kiểm tra bảng `schema_migrations` xem migration nào đã chạy

---

## 6️⃣ Checklist Sau Khi Deploy

- [ ] Backend healthz trả về `{"status":"ok"}`
- [ ] Frontend mở được trang login
- [ ] Login với `admin/admin123` thành công
- [ ] Dashboard hiển thị số liệu (hoặc 0 nếu DB trống)
- [ ] Không có CORS errors trong Console
- [ ] Database có đầy đủ bảng (check qua Supabase Table Editor)
- [ ] Tạo được user/sister/community mới

---

## 7️⃣ Bảo Mật Production

### Thay Đổi Mật Khẩu Admin Mặc Định
```sql
-- Chạy qua Supabase SQL Editor
UPDATE users 
SET password = '$2b$10$NEW_BCRYPT_HASH_HERE'
WHERE username = 'admin';
```

### Tạo JWT_SECRET Mới Định Kỳ
Mỗi 3-6 tháng nên đổi JWT_SECRET mới (users sẽ phải login lại).

### Giới Hạn CORS Chặt Chẽ
Chỉ cho phép đúng domain production:
```bash
CORS_ORIGIN=https://saintpaulthienban.onrender.com
```

Không dùng `*` trong production!

---

## 8️⃣ Monitoring & Logs

### Xem Logs Realtime
- **Backend**: Render Dashboard → Service → **Logs** tab
- **Database**: Supabase Dashboard → **Logs** → Database/API

### Set Alerts
1. Render → Service → **Notifications**
2. Thêm email/Slack webhook
3. Chọn events: Deploy Failed, Service Down

---

## 🎉 Hoàn Thành!

Sau khi làm xong các bước trên:
- Frontend: `https://saintpaulthienban.onrender.com`
- Backend API: `https://your-backend.onrender.com/api`
- Database: Supabase PostgreSQL

Mọi thay đổi code push lên GitHub sẽ tự động trigger deploy mới trên Render!
