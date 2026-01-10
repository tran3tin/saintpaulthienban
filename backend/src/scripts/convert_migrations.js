const fs = require('fs');
const path = require('path');

const migrationsDir = path.join(__dirname, '../migrations');

// Convert MySQL to PostgreSQL syntax
function convertMigration(content) {
  let converted = content;
  
  // 1. AUTO_INCREMENT -> SERIAL
  converted = converted.replace(/INT\s+UNSIGNED\s+AUTO_INCREMENT\s+PRIMARY\s+KEY/gi, 'SERIAL PRIMARY KEY');
  converted = converted.replace(/BIGINT\s+UNSIGNED\s+AUTO_INCREMENT\s+PRIMARY\s+KEY/gi, 'BIGSERIAL PRIMARY KEY');
  
  // 2. INT UNSIGNED -> INTEGER
  converted = converted.replace(/INT\s+UNSIGNED/gi, 'INTEGER');
  converted = converted.replace(/BIGINT\s+UNSIGNED/gi, 'BIGINT');
  
  // 3. TINYINT -> SMALLINT
  converted = converted.replace(/TINYINT\(\d+\)/gi, 'SMALLINT');
  converted = converted.replace(/TINYINT/gi, 'SMALLINT');
  
  // 4. DATETIME -> TIMESTAMP
  converted = converted.replace(/DATETIME/gi, 'TIMESTAMP');
  
  // 5. ENUM to CHECK constraint (simple cases)
  converted = converted.replace(/ENUM\s*\((.*?)\)\s+NOT\s+NULL/gi, (match, values) => {
    return `VARCHAR(50) NOT NULL CHECK (column_name IN (${values}))`;
  });
  converted = converted.replace(/ENUM\s*\((.*?)\)/gi, (match, values) => {
    return `VARCHAR(50) CHECK (column_name IN (${values}))`;
  });
  
  // 6. Remove ENGINE and CHARSET
  converted = converted.replace(/ENGINE\s*=\s*InnoDB/gi, '');
  converted = converted.replace(/DEFAULT\s+CHARSET\s*=\s*utf8mb4/gi, '');
  converted = converted.replace(/CHARACTER\s+SET\s+utf8mb4/gi, '');
  
  // 7. ON UPDATE CURRENT_TIMESTAMP
  converted = converted.replace(/ON\s+UPDATE\s+CURRENT_TIMESTAMP/gi, '');
  
  // 8. Inline INDEX to CREATE INDEX
  converted = converted.replace(/,\s*INDEX\s+(\w+)\s*\((.*?)\)/gi, '');
  
  // 9. JSON -> JSONB for better performance in PostgreSQL
  converted = converted.replace(/\s+JSON\s+/gi, ' JSONB ');
  
  // 10. pool.getConnection() -> pool.connect()
  converted = converted.replace(/pool\.getConnection\(\)/g, 'pool.connect()');
  converted = converted.replace(/const\s+connection\s*=/g, 'const client =');
  converted = converted.replace(/connection\.query/g, 'client.query');
  converted = converted.replace(/connection\.release/g, 'client.release');
  
  // 11. ALTER TABLE MODIFY -> ALTER TABLE ALTER COLUMN
  converted = converted.replace(/ALTER\s+TABLE\s+(\w+)\s+MODIFY\s+COLUMN\s+(\w+)/gi, 
    'ALTER TABLE $1 ALTER COLUMN $2 TYPE');
  
  // 12. Clean up
  converted = converted.replace(/,\s*\)/g, ')');
  converted = converted.replace(/;\s*;/g, ';');
  
  return converted;
}

// Get all migration files
const files = fs.readdirSync(migrationsDir)
  .filter(f => f.endsWith('.js'))
  .sort();

console.log(`Found ${files.length} migration files`);

let converted = 0;
let skipped = 0;

files.forEach(file => {
  const filePath = path.join(migrationsDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  
  // Skip if already converted (check for 'pool.connect')
  if (content.includes('pool.connect()')) {
    console.log(`✓ Skip ${file} (already converted)`);
    skipped++;
    return;
  }
  
  // Skip if no MySQL syntax found
  if (!content.match(/AUTO_INCREMENT|ENUM\(|ENGINE=|getConnection/i)) {
    console.log(`✓ Skip ${file} (no MySQL syntax)`);
    skipped++;
    return;
  }
  
  console.log(`⚙ Converting ${file}...`);
  const newContent = convertMigration(content);
  
  // Backup original
  fs.writeFileSync(filePath + '.bak', content);
  
  // Write converted
  fs.writeFileSync(filePath, newContent);
  
  converted++;
  console.log(`✅ Converted ${file}`);
});

console.log(`\n✅ Conversion complete!`);
console.log(`  - Converted: ${converted} files`);
console.log(`  - Skipped: ${skipped} files`);
console.log(`  - Total: ${files.length} files`);
console.log(`\nBackup files saved with .bak extension`);
