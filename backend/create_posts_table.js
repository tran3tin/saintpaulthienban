const pool = require('./src/config/database');

async function createPostsTable() {
  const client = await pool.connect();
  
  try {
    console.log('Creating posts table...');
    
    await client.query(`
      CREATE TABLE IF NOT EXISTS posts (
        id SERIAL PRIMARY KEY,
        title VARCHAR(500) NOT NULL,
        slug VARCHAR(500),
        content TEXT,
        excerpt TEXT,
        category VARCHAR(50) DEFAULT 'thong-bao',
        status VARCHAR(20) DEFAULT 'draft',
        is_pinned BOOLEAN DEFAULT FALSE,
        featured_image TEXT,
        attachments JSONB DEFAULT '[]',
        author_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
        view_count INTEGER DEFAULT 0,
        published_at TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        deleted_at TIMESTAMP
      )
    `);
    console.log('✓ Created posts table');
    
    // Create index for search
    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_posts_category ON posts(category);
      CREATE INDEX IF NOT EXISTS idx_posts_status ON posts(status);
      CREATE INDEX IF NOT EXISTS idx_posts_is_pinned ON posts(is_pinned);
      CREATE INDEX IF NOT EXISTS idx_posts_deleted_at ON posts(deleted_at);
    `);
    console.log('✓ Created indexes');
    
    // Insert sample post
    await client.query(`
      INSERT INTO posts (title, content, excerpt, category, status, is_pinned, author_id, published_at)
      VALUES 
        ('Chào mừng đến với hệ thống', 
         'Đây là bài đăng đầu tiên trên hệ thống quản lý Hội Dòng OSP. Chúc các chị em sử dụng hệ thống hiệu quả!', 
         'Bài đăng chào mừng từ ban quản trị.',
         'thong-bao', 
         'published', 
         TRUE, 
         1, 
         CURRENT_TIMESTAMP)
      ON CONFLICT DO NOTHING
    `);
    console.log('✓ Inserted sample post');
    
    console.log('\n✅ Posts table setup complete!');
    
  } catch (error) {
    console.error('Error:', error);
  } finally {
    client.release();
    process.exit();
  }
}

createPostsTable();
