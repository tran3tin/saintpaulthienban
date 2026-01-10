const pool = require("../config/database");

const up = async () => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    await client.query(`
      CREATE TABLE IF NOT EXISTS education_levels (
        id SERIAL PRIMARY KEY,
        code VARCHAR(50) NOT NULL UNIQUE,
        name VARCHAR(100) NOT NULL,
        description TEXT,
        display_order INTEGER DEFAULT 0,
        color VARCHAR(20) DEFAULT '#6c757d',
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );

      CREATE INDEX IF NOT EXISTS idx_education_levels_active_order
        ON education_levels (is_active, display_order, name);
    `);

    const defaultLevels = [
      ["secondary", "Trung học", 1, "#6c757d"],
      ["high_school", "Phổ thông", 2, "#17a2b8"],
      ["vocational", "Trung cấp", 3, "#20c997"],
      ["college", "Cao đẳng", 4, "#fd7e14"],
      ["bachelor", "Đại học", 5, "#0d6efd"],
      ["master", "Thạc sĩ", 6, "#6f42c1"],
      ["doctorate", "Tiến sĩ", 7, "#dc3545"],
      ["certificate", "Chứng chỉ", 8, "#ffc107"],
      ["other", "Khác", 99, "#adb5bd"],
    ];

    for (const level of defaultLevels) {
      await client.query(
        `
          INSERT INTO education_levels (code, name, display_order, color)
          VALUES ($1, $2, $3, $4)
          ON CONFLICT (code) DO UPDATE
          SET name = EXCLUDED.name,
              display_order = EXCLUDED.display_order,
              color = EXCLUDED.color
        `,
        level
      );
    }

    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

const down = async () => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    await client.query("DROP TABLE IF EXISTS education_levels");
    await client.query("COMMIT");
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

module.exports = {
  name: "042_create_education_levels_table",
  up,
  down,
};
