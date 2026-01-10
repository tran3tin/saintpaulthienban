# Setup script for HR Records project

Write-Host "====================================" -ForegroundColor Green
Write-Host "KHỞI ĐỘNG DỰ ÁN HR RECORDS" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""

# Change to backend directory
Set-Location E:\project\01-hoi-dong-osp\backend

# Step 1: Test connection
Write-Host "[1/4] Kiểm tra kết nối PostgreSQL..." -ForegroundColor Yellow
node test_connection.js
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ FAILED: Không kết nối được PostgreSQL!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Run migrations
Write-Host "[2/4] Chạy migrations để tạo các bảng..." -ForegroundColor Yellow
node src/migrations/runMigrations.js up
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ FAILED: Migrations thất bại!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 3: Create admin user
Write-Host "[3/4] Tạo admin user..." -ForegroundColor Yellow
node src/scripts/create_admin_user.js
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ FAILED: Không tạo được admin user!" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 4: Check tables
Write-Host "[4/4] Kiểm tra kết quả..." -ForegroundColor Yellow
node check_tables.js
Write-Host ""

Write-Host "====================================" -ForegroundColor Green
Write-Host "✓ SETUP HOÀN TẤT!" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Để khởi động dự án, chạy 2 lệnh sau trong 2 terminal riêng biệt:" -ForegroundColor Cyan
Write-Host ""
Write-Host "Terminal 1 (Backend):" -ForegroundColor White
Write-Host "  cd E:\project\01-hoi-dong-osp\backend" -ForegroundColor Gray
Write-Host "  npm run dev" -ForegroundColor Gray
Write-Host ""
Write-Host "Terminal 2 (Frontend):" -ForegroundColor White
Write-Host "  cd E:\project\01-hoi-dong-osp\frontend" -ForegroundColor Gray
Write-Host "  npm run dev" -ForegroundColor Gray
Write-Host ""
Write-Host "Thông tin đăng nhập:" -ForegroundColor Cyan
Write-Host "  Username: admin" -ForegroundColor White
Write-Host "  Password: admin123" -ForegroundColor White
Write-Host ""
