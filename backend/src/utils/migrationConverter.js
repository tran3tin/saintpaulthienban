/**
 * Migration Converter - Converts MySQL migration syntax to PostgreSQL
 */

function convertMySQLToPostgreSQL(mysqlQuery) {
  let pgQuery = mysqlQuery;

  // 1. AUTO_INCREMENT -> SERIAL
  pgQuery = pgQuery.replace(
    /INT\s+UNSIGNED\s+AUTO_INCREMENT\s+PRIMARY\s+KEY/gi,
    "SERIAL PRIMARY KEY"
  );
  pgQuery = pgQuery.replace(
    /BIGINT\s+UNSIGNED\s+AUTO_INCREMENT\s+PRIMARY\s+KEY/gi,
    "BIGSERIAL PRIMARY KEY"
  );
  pgQuery = pgQuery.replace(
    /INT\s+AUTO_INCREMENT\s+PRIMARY\s+KEY/gi,
    "SERIAL PRIMARY KEY"
  );

  // 2. Remove UNSIGNED
  pgQuery = pgQuery.replace(/INT\s+UNSIGNED/gi, "INTEGER");
  pgQuery = pgQuery.replace(/BIGINT\s+UNSIGNED/gi, "BIGINT");

  // 3. TINYINT -> SMALLINT or BOOLEAN
  pgQuery = pgQuery.replace(/TINYINT\(1\)/gi, "SMALLINT");
  pgQuery = pgQuery.replace(/TINYINT/gi, "SMALLINT");

  // 4. DATETIME -> TIMESTAMP
  pgQuery = pgQuery.replace(/DATETIME/gi, "TIMESTAMP");

  // 5. ENUM -> CHECK constraint or VARCHAR
  const enumPattern = /ENUM\s*\((.*?)\)/gi;
  pgQuery = pgQuery.replace(enumPattern, (match, values) => {
    const valuesArray = values.split(",").map((v) => v.trim());
    return `VARCHAR(50) CHECK (column_name IN (${valuesArray.join(",")}))`;
  });

  // 6. Remove ENGINE and CHARSET
  pgQuery = pgQuery.replace(/ENGINE\s*=\s*InnoDB/gi, "");
  pgQuery = pgQuery.replace(/DEFAULT\s+CHARSET\s*=\s*utf8mb4/gi, "");
  pgQuery = pgQuery.replace(/CHARACTER\s+SET\s+utf8mb4/gi, "");
  pgQuery = pgQuery.replace(/COLLATE\s+\w+/gi, "");

  // 7. ON UPDATE CURRENT_TIMESTAMP -> trigger (need manual handling)
  pgQuery = pgQuery.replace(/ON\s+UPDATE\s+CURRENT_TIMESTAMP/gi, "");

  // 8. INDEX syntax
  pgQuery = pgQuery.replace(/,\s*INDEX\s+(\w+)\s*\((.*?)\)/gi, "");

  // 9. Backticks to double quotes (for identifiers)
  pgQuery = pgQuery.replace(/`/g, '"');

  // 10. LONGTEXT/MEDIUMTEXT -> TEXT
  pgQuery = pgQuery.replace(/LONGTEXT/gi, "TEXT");
  pgQuery = pgQuery.replace(/MEDIUMTEXT/gi, "TEXT");

  // Clean up extra commas and spaces
  pgQuery = pgQuery.replace(/,\s*\)/g, ")");
  pgQuery = pgQuery.replace(/\s+/g, " ");

  return pgQuery.trim();
}

module.exports = {
  convertMySQLToPostgreSQL,
};
