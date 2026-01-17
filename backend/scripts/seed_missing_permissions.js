const path = require("path");
const { Pool } = require("pg");
require("dotenv").config({ path: path.resolve(__dirname, "../.env") });

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl:
    process.env.NODE_ENV === "production"
      ? { rejectUnauthorized: false }
      : false,
});

async function run() {
  const client = await pool.connect();
  try {
    console.log("Checking permissions table structure...");
    const res = await client.query(`
      SELECT column_name
      FROM information_schema.columns
      WHERE table_name = 'permissions';
    `);
    const columns = res.rows.map((r) => r.column_name);
    console.log("Columns:", columns);

    const keyCol = columns.includes("code") ? "code" : "key_col_not_found";
    // If 'name' exists and 'display_name' does NOT, then 'name' is likely the label column,
    // assuming 'code' is the unique key.
    const labelCol = columns.includes("display_name")
      ? "display_name"
      : columns.includes("name")
        ? "name"
        : null;

    console.log(`Using key column: ${keyCol}`);
    console.log(`Using label column: ${labelCol}`);

    if (keyCol === "key_col_not_found") {
      console.error("Could not determine key column (code). Aborting.");
      return;
    }

    const permissions = [
      // Departures
      {
        key: "departure.view",
        name: "Xem lịch đi vắng",
        module: "Quản lý Đi vắng",
      },
      {
        key: "departure.create",
        name: "Thêm lịch đi vắng",
        module: "Quản lý Đi vắng",
      },
      {
        key: "departure.update",
        name: "Chỉnh sửa lịch đi vắng",
        module: "Quản lý Đi vắng",
      },
      {
        key: "departure.delete",
        name: "Xóa lịch đi vắng",
        module: "Quản lý Đi vắng",
      },
      // Assignment
      {
        key: "community_assignment.view",
        name: "Xem thông tin bổ nhiệm",
        module: "Bổ nhiệm & Phân công",
      },
      {
        key: "community_assignment.create",
        name: "Phân bổ chị em",
        module: "Bổ nhiệm & Phân công",
      },
      {
        key: "community_assignment.update",
        name: "Chỉnh sửa phân bổ",
        module: "Bổ nhiệm & Phân công",
      },
      {
        key: "community_assignment.delete",
        name: "Kết thúc/Xóa phân bổ",
        module: "Bổ nhiệm & Phân công",
      },
    ];

    for (const p of permissions) {
      let query;
      let params;
      if (labelCol) {
        query = `
                INSERT INTO permissions (${keyCol}, ${labelCol}, module, is_active)
                VALUES ($1, $2, $3, true)
                ON CONFLICT (${keyCol}) DO UPDATE
                SET ${labelCol} = EXCLUDED.${labelCol},
                    module = EXCLUDED.module,
                    is_active = true;
            `;
        params = [p.key, p.name, p.module];
      } else {
        query = `
                INSERT INTO permissions (${keyCol}, module, is_active)
                VALUES ($1, $2, true)
                ON CONFLICT (${keyCol}) DO UPDATE
                SET module = EXCLUDED.module;
            `;
        params = [p.key, p.module];
      }

      await client.query(query, params);
      console.log(`Upserted ${p.key}`);
    }
  } catch (err) {
    console.error(err);
  } finally {
    client.release();
    pool.end();
  }
}

run();
