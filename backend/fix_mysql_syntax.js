/**
 * Script để sửa các migration files từ MySQL sang PostgreSQL syntax
 */

const fs = require('fs');
const path = require('path');

const migrationsDir = path.join(__dirname, 'src', 'migrations');

// Các pattern cần thay thế
const replacements = [
  // connection → client
  {
    from: /\bconnection\.(execute|query|beginTransaction|commit|rollback)\(/g,
    to: 'client.query('
  },
  {
    from: /\bconnection\b(?!\.)/g,
    to: 'client'
  },
  // Remove AFTER keyword
  {
    from: /\s+AFTER\s+\w+/gi,
    to: ''
  },
  // MySQL specific functions
  {
    from: /DATABASE\(\)/g,
    to: 'current_database()'
  },
  {
    from: /TABLE_SCHEMA\s*=\s*DATABASE\(\)/g,
    to: "TABLE_SCHEMA = current_database()"
  },
  // FROM INFORMATION_SCHEMA queries
  {
    from: /const\s+\[(\w+)\]\s*=\s*await\s+client\.query\(/g,
    to: 'const $1Result = await client.query('
  }
];

const filesToExclude = ['runMigrations.js', 'convert_migrations.js', 'fix_mysql_syntax.js'];

function fixFile(filePath) {
  const fileName = path.basename(filePath);
  
  if (filesToExclude.includes(fileName) || !fileName.endsWith('.js')) {
    return;
  }

  console.log(`Fixing ${fileName}...`);
  
  let content = fs.readFileSync(filePath, 'utf8');
  let modified = false;

  // Apply each replacement
  replacements.forEach(({ from, to }) => {
    const newContent = content.replace(from, to);
    if (newContent !== content) {
      content = newContent;
      modified = true;
    }
  });

  // Fix specific patterns
  // connection.execute → client.query
  if (content.includes('connection.execute')) {
    content = content.replace(/connection\.execute/g, 'client.query');
    modified = true;
  }

  // db.getConnection → db.connect (pool pattern)
  if (content.includes('db.getConnection')) {
    content = content.replace(/db\.getConnection\(\)/g, 'db.connect()');
    modified = true;
  }

  // Fix [columns] destructuring
  if (content.includes('const [columns]')) {
    content = content.replace(/const \[(\w+)\] = await client\.query/g, 'const $1Result = await client.query');
    content = content.replace(/(\w+)\.map\(/, '$1Result.rows.map(');
    modified = true;
  }

  if (modified) {
    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`✓ Fixed ${fileName}`);
  } else {
    console.log(`  No changes needed for ${fileName}`);
  }
}

// Process all migration files
const files = fs.readdirSync(migrationsDir);
files.forEach(file => {
  const filePath = path.join(migrationsDir, file);
  if (fs.statSync(filePath).isFile()) {
    fixFile(filePath);
  }
});

console.log('\n✅ All migrations fixed!');
