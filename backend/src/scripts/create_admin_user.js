const pool = require("../config/database");
const bcrypt = require("bcryptjs");

async function createAdminUser() {
  const client = await pool.connect();

  try {
    console.log("Creating admin user...");

    // Check if admin exists
    const checkSql = "SELECT * FROM users WHERE username = $1";
    const checkResult = await client.query(checkSql, ["admin"]);

    if (checkResult.rows.length > 0) {
      console.log("✓ Admin user already exists");
      console.log("  Username: admin");
      return;
    }

    // Create admin
    const hashedPassword = await bcrypt.hash("admin123", 10);

    const insertSql = `
      INSERT INTO users (username, password, email, role, is_active)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id, username, email, role
    `;

    const result = await client.query(insertSql, [
      "admin",
      hashedPassword,
      "admin@ospsisters.vn",
      "admin",
      1,
    ]);

    console.log("✅ Admin user created successfully!");
    console.log("   Username: admin");
    console.log("   Password: admin123");
    console.log("   Email: admin@ospsisters.vn");
    console.log("   Role: admin");
    console.log("\n⚠️  IMPORTANT: Change password after first login!");
  } catch (error) {
    console.error("❌ Error creating admin user:", error.message);
    throw error;
  } finally {
    client.release();
    await pool.end();
  }
}

createAdminUser()
  .then(() => process.exit(0))
  .catch(() => process.exit(1));
