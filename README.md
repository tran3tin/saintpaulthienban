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
│   │   └── utils/
│   ├── db/
│   ├── scripts/
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
│   │   ├── utils/
│   │   └── config/
│   ├── public/
│   └── package.json
│
├── frontend-legacy/        # Frontend cũ (HTML/CSS/JS) - Tham khảo
│
└── .gitignore
```

## Cài đặt

### Backend
```bash
cd backend
npm install
npm run dev
```

Chuẩn bị database (PostgreSQL):
- Tạo database `hr_records` (ví dụ bằng pgAdmin)
- Cấu hình `backend/.env` bằng `DATABASE_URL` hoặc `PGHOST/PGUSER/PGPASSWORD/PGDATABASE`
- Chạy migrations: `node src/migrations/runMigrations.js`

Ghi chú: file `backend/db/init.sql` là script MySQL cũ; dùng `backend/db/init_postgres.sql` để tham khảo khi setup PostgreSQL.

### Frontend
```bash
cd frontend
npm install
npm run dev
```

## Chạy ứng dụng

- Backend: http://localhost:5000
- Frontend: http://localhost:5173

## Công nghệ sử dụng

### Backend
- Node.js + Express 5
- PostgreSQL (pg)
- JWT Authentication
- bcryptjs, multer, exceljs, pdfkit

### Frontend
- React 19 + Vite
- React Router DOM
- Bootstrap 5 + React Bootstrap
- Axios
- Formik + Yup
- Recharts
