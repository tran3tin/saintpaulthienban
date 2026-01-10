const { runMigrations } = require("./runner");

const direction =
  (process.argv[2] || "up").toLowerCase() === "down" ? "down" : "up";

const main = async () => {
  await runMigrations({ direction });
  console.log(`All migrations ${direction} executed.`);
};

if (require.main === module) {
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error("Migration run failed:", error);
      process.exit(1);
    });
}
