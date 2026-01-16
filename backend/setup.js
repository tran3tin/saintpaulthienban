/**
 * Script khởi động dự án - Chạy migrations và tạo admin user
 */

const { execSync } = require("child_process");

console.log("=== KHỞI ĐỘNG DỰ ÁN HR RECORDS ===\n");

try {
  // Bước 1: Chạy migrations
  console.log("[1/2] Đang chạy migrations để tạo các bảng...");
  execSync("node src/migrations/runMigrations.js up", {
    stdio: "inherit",
    cwd: __dirname,
  });
  console.log("✓ Migrations hoàn tất\n");

  // Bước 2: Tạo admin user
  console.log("[2/2] Đang tạo admin user...");
  execSync("node src/scripts/create_admin_user.js", {
    stdio: "inherit",
    cwd: __dirname,
  });
  console.log("✓ Admin user đã được tạo\n");

  // Hướng dẫn tiếp theo
  console.log("=== SETUP HOÀN TẤT! ===\n");
  console.log("Để khởi động dự án, chạy các lệnh sau:");
  console.log("  1. Backend:  npm run dev    (port 5000)");
  console.log("  2. Frontend: cd ../frontend && npm run dev  (port 5173)\n");
  console.log("Thông tin đăng nhập:");
  console.log("  Username: admin");
  console.log("  Password: admin123\n");
} catch (error) {
  console.error("\n❌ Lỗi khi chạy setup:", error.message);
  process.exit(1);
}
