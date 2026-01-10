/**
 * Script chuyển đổi toàn bộ MySQL syntax sang PostgreSQL
 * Chạy: node src/scripts/mysql_to_pg_converter.js
 */

const fs = require('fs');
const path = require('path');

const srcDir = path.join(__dirname, '..');

// Patterns to convert
const conversions = [
  // MySQL date functions -> PostgreSQL
  { from: /DATE_SUB\s*\(\s*NOW\s*\(\s*\)\s*,\s*INTERVAL\s+(\?|\d+)\s+DAY\s*\)/gi, to: "NOW() - INTERVAL '$1 days'" },
  { from: /DATE_SUB\s*\(\s*NOW\s*\(\s*\)\s*,\s*INTERVAL\s+(\?|\d+)\s+MONTH\s*\)/gi, to: "NOW() - INTERVAL '$1 months'" },
  { from: /DATE_SUB\s*\(\s*NOW\s*\(\s*\)\s*,\s*INTERVAL\s+(\?|\d+)\s+YEAR\s*\)/gi, to: "NOW() - INTERVAL '$1 years'" },
  { from: /DATE_ADD\s*\(\s*NOW\s*\(\s*\)\s*,\s*INTERVAL\s+(\?|\d+)\s+DAY\s*\)/gi, to: "NOW() + INTERVAL '$1 days'" },
  
  // CURDATE() -> CURRENT_DATE
  { from: /CURDATE\s*\(\s*\)/gi, to: 'CURRENT_DATE' },
  
  // TIMESTAMPDIFF(YEAR, date1, date2) -> EXTRACT(YEAR FROM AGE(date2, date1))
  { from: /TIMESTAMPDIFF\s*\(\s*YEAR\s*,\s*([^,]+)\s*,\s*([^)]+)\s*\)/gi, to: 'EXTRACT(YEAR FROM AGE($2, $1))::INT' },
  { from: /TIMESTAMPDIFF\s*\(\s*MONTH\s*,\s*([^,]+)\s*,\s*([^)]+)\s*\)/gi, to: "(EXTRACT(YEAR FROM AGE($2, $1)) * 12 + EXTRACT(MONTH FROM AGE($2, $1)))::INT" },
  { from: /TIMESTAMPDIFF\s*\(\s*DAY\s*,\s*([^,]+)\s*,\s*([^)]+)\s*\)/gi, to: "EXTRACT(DAY FROM ($2 - $1))::INT" },
  
  // YEAR(date) -> EXTRACT(YEAR FROM date)
  { from: /YEAR\s*\(\s*([^)]+)\s*\)/gi, to: 'EXTRACT(YEAR FROM $1)' },
  
  // MONTH(date) -> EXTRACT(MONTH FROM date)
  { from: /MONTH\s*\(\s*([^)]+)\s*\)/gi, to: 'EXTRACT(MONTH FROM $1)' },
  
  // DAY(date) -> EXTRACT(DAY FROM date)
  { from: /DAY\s*\(\s*([^)]+)\s*\)/gi, to: 'EXTRACT(DAY FROM $1)' },
  
  // IFNULL -> COALESCE
  { from: /IFNULL\s*\(/gi, to: 'COALESCE(' },
  
  // GROUP_CONCAT -> STRING_AGG  
  { from: /GROUP_CONCAT\s*\(\s*DISTINCT\s+([^)]+)\s*\)/gi, to: 'STRING_AGG(DISTINCT $1::TEXT, \',\')' },
  { from: /GROUP_CONCAT\s*\(\s*([^)]+)\s*\)/gi, to: 'STRING_AGG($1::TEXT, \',\')' },
  
  // SHOW TABLES LIKE -> information_schema query
  { from: /SHOW\s+TABLES\s+LIKE\s+['"]([^'"]+)['"]/gi, to: "SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename LIKE '$1'" },
];

// Files/folders to skip
const skipPaths = [
  'node_modules',
  'queryAdapter.js',
  'migrationConverter.js',
  'convert_migrations.js',
  'mysql_to_pg_converter.js',
  '.bak',
  'backup'
];

function shouldSkip(filePath) {
  return skipPaths.some(skip => filePath.includes(skip));
}

function convertFile(filePath) {
  if (shouldSkip(filePath)) return { changed: false };
  
  let content = fs.readFileSync(filePath, 'utf8');
  let originalContent = content;
  let changes = [];
  
  conversions.forEach(({ from, to }) => {
    const matches = content.match(from);
    if (matches) {
      changes.push(`  ${from.toString().slice(0, 50)}... -> ${to.slice(0, 50)}... (${matches.length} matches)`);
      content = content.replace(from, to);
    }
  });
  
  if (content !== originalContent) {
    fs.writeFileSync(filePath, content, 'utf8');
    return { changed: true, changes };
  }
  
  return { changed: false };
}

function walkDir(dir, callback) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    if (shouldSkip(filePath)) return;
    
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      walkDir(filePath, callback);
    } else if (file.endsWith('.js')) {
      callback(filePath);
    }
  });
}

console.log('=== MySQL to PostgreSQL Converter ===\n');
console.log('Scanning directory:', srcDir);
console.log('');

let totalChanged = 0;
let totalFiles = 0;

walkDir(srcDir, (filePath) => {
  totalFiles++;
  const result = convertFile(filePath);
  if (result.changed) {
    totalChanged++;
    const relativePath = path.relative(srcDir, filePath);
    console.log(`✓ ${relativePath}`);
    result.changes.forEach(c => console.log(c));
    console.log('');
  }
});

console.log('=== Summary ===');
console.log(`Total files scanned: ${totalFiles}`);
console.log(`Files modified: ${totalChanged}`);
console.log('\nDone!');
