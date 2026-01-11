const db = require('./src/config/database');

(async () => {
  const [cols] = await db.execute(
    "SELECT column_name, data_type FROM information_schema.columns WHERE table_schema='public' AND table_name='permissions' ORDER BY ordinal_position",
    []
  );
  console.log('columns:', cols);

  const [sample] = await db.execute('SELECT * FROM permissions LIMIT 3', []);
  console.log('sample:', sample);

  process.exit(0);
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
