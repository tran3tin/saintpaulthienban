# Script khởi động dự án sau khi cài PostgreSQL

Write-Host "=== KHỞI ĐỘNG DỰ ÁN HR RECORDS ===" -ForegroundColor Green

# Bước 1: Chạy migrations
Write-Host "`n[1/3] Đang chạy migrations để tạo các bảng..." -ForegroundColor Yellow
node src/migrations/runMigrations.js up

if ($LASTEXITCODE -ne 0) {
    Write-Host "Lỗi khi chạy migrations!" -ForegroundColor Red
    exit 1
}

# Bước 2: Tạo admin user
Write-Host "`n[2/3] Đang tạo admin user..." -ForegroundColor Yellow
node src/scripts/create_admin_user.js

if ($LASTEXITCODE -ne 0) {
    Write-Host "Lỗi khi tạo admin user!" -ForegroundColor Red
    exit 1
}

# Bước 3: Hướng dẫn khởi động server
Write-Host "`n[3/3] Setup hoàn tất!" -ForegroundColor Green
Write-Host "`nĐể khởi động dự án, chạy các lệnh sau:" -ForegroundColor Cyan
Write-Host "  1. Backend:  npm run dev    (port 5000)" -ForegroundColor White
Write-Host "  2. Frontend: cd ../frontend && npm run dev  (port 5173)" -ForegroundColor White
Write-Host "`nThông tin đăng nhập:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Password: admin123" -ForegroundColor White
