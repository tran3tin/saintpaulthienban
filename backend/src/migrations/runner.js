const fs = require("fs");
const path = require("path");
const pool = require("../config/database");

const migrationsDir = __dirname;

const loadMigrationFiles = () => {
  return fs
    .readdirSync(migrationsDir)
    .filter(
      (file) =>
        file.endsWith(".js") &&
        file !== "runMigrations.js" &&
        file !== "runner.js" &&
        !file.endsWith(".bak")
    )
    .sort();
};

const ensureMigrationsTable = async (client) => {
  await client.query(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      file_name TEXT PRIMARY KEY,
      applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    )
  `);
};

const getAppliedMigrations = async (client) => {
  const result = await client.query(
    "SELECT file_name FROM schema_migrations ORDER BY applied_at ASC"
  );
  return new Set(result.rows.map((r) => r.file_name));
};

const runMigrations = async ({ direction = "up" } = {}) => {
  const dir = direction === "down" ? "down" : "up";
  const files = loadMigrationFiles();
  const ordered = dir === "up" ? files : files.slice().reverse();

  const client = await pool.connect();
  try {
    await ensureMigrationsTable(client);
    const applied = await getAppliedMigrations(client);

    for (const fileName of ordered) {
      const migrationPath = path.join(migrationsDir, fileName);
      // eslint-disable-next-line global-require, import/no-dynamic-require
      const migration = require(migrationPath);
      const handler = migration?.[dir];
      if (typeof handler !== "function") {
        console.warn(`Skipping ${fileName}; missing ${dir} handler.`);
        continue;
      }

      if (dir === "up" && applied.has(fileName)) {
        continue;
      }

      if (dir === "down" && !applied.has(fileName)) {
        continue;
      }

      console.log(`Running ${dir} for ${fileName}`);
      await handler();

      if (dir === "up") {
        await client.query(
          "INSERT INTO schema_migrations (file_name) VALUES ($1) ON CONFLICT (file_name) DO NOTHING",
          [fileName]
        );
        applied.add(fileName);
      } else {
        await client.query(
          "DELETE FROM schema_migrations WHERE file_name = $1",
          [fileName]
        );
        applied.delete(fileName);
      }
    }

    return { success: true, direction: dir, ranCount: undefined };
  } finally {
    client.release();
  }
};

module.exports = {
  runMigrations,
};
