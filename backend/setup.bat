@echo off
echo ===================================
echo KHOI DONG DU AN HR RECORDS
echo ===================================
echo.

cd /d E:\project\01-hoi-dong-osp\backend

echo [1/4] Kiem tra ket noi PostgreSQL...
node test_connection.js
if errorlevel 1 (
    echo.
    echo LOI: Khong ket noi duoc PostgreSQL!
    echo Kiem tra:
    echo   - PostgreSQL da khoi dong chua?
    echo   - Database hr_records da tao chua?
    pause
    exit /b 1
)

echo.
echo [2/4] Chay migrations de tao cac bang...
node src/migrations/runMigrations.js up
if errorlevel 1 (
    echo.
    echo LOI: Migrations that bai!
    pause
    exit /b 1
)

echo.
echo [3/4] Tao admin user...
node src/scripts/create_admin_user.js
if errorlevel 1 (
    echo.
    echo LOI: Khong tao duoc admin user!
    pause
    exit /b 1
)

echo.
echo [4/4] Kiem tra ket qua...
node check_tables.js

echo.
echo ===================================
echo SETUP HOAN TAT!
echo ===================================
echo.
echo De khoi dong du an:
echo   1. Backend:  npm run dev
echo   2. Frontend: cd ../frontend ^&^& npm run dev
echo.
echo Thong tin dang nhap:
echo   Username: admin
echo   Password: admin123
echo.
pause
