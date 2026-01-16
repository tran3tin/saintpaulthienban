# Hội Dòng OSP - Hệ Thống Quản Lý Nhân Sự

Hệ thống quản lý nhân sự cho Hội Dòng OSP (Mến Thánh Giá).

## Cấu trúc dự án

```
01-hoi-dong-osp/
├── backend/                # API Server (Node.js/Express)
│   ├── src/
│   │   ├── controllers/
│   │   ├── middlewares/
│   │   ├── migrations/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   └── utils/
│   ├── db/
│   ├── server.js
│   └── package.json
│
├── frontend/               # React Frontend (Vite)
│   ├── src/
│   │   ├── components/
│   │   ├── features/
│   │   ├── layouts/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── hooks/
│   │   ├── context/
│   │   └── utils/
│   ├── public/
│   └── package.json
│
└── database/               # Database backup files
```

## Cài đặt nhanh

### 1. Cài đặt PostgreSQL

- Tải và cài đặt PostgreSQL từ: https://www.postgresql.org/download/
- Tạo database `hr_records`

### 2. Cấu hình Backend

```bash
cd backend
npm install
```

Tạo file `.env` từ `.env.example`:

```env
DATABASE_URL=postgresql://postgres:password@localhost:5432/hr_records
JWT_SECRET=your_jwt_secret_key
```

### 3. Chạy Migrations & Tạo Admin

```bash
node setup.js
```

Script này sẽ tự động:

- Chạy migrations để tạo các bảng
- Tạo tài khoản admin (username: `admin`, password: `admin123`)

### 4. Khởi động Backend

```bash
npm run dev
```

Backend chạy tại: http://localhost:5000

### 5. Cài đặt & Khởi động Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend chạy tại: http://localhost:5173

## Đăng nhập

- **Username:** admin
- **Password:** admin123

## Công nghệ sử dụng

### Backend

- Node.js + Express 5
- PostgreSQL
- JWT Authentication
- Firebase Storage (upload files)

### Frontend

- React 19 + Vite
- React Router DOM
- Bootstrap 5 + React Bootstrap
- Axios
- Formik + Yup
