-- Migration: Create posts table
-- Run this script to create the posts table for the Thong Tin feature

CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  category VARCHAR(50) NOT NULL DEFAULT 'thong-bao' CHECK (category IN ('thong-bao', 'su-kien', 'huong-dan', 'chia-se', 'khac')),
  summary TEXT,
  content TEXT NOT NULL,
  is_pinned BOOLEAN DEFAULT FALSE,
  is_important BOOLEAN DEFAULT FALSE,
  tags JSONB,
  attachments JSONB,
  author_id INTEGER,
  view_count INTEGER DEFAULT 0,
  status VARCHAR(20) DEFAULT 'published' CHECK (status IN ('draft', 'published')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  CONSTRAINT fk_posts_author_id FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_posts_category ON posts(category);
CREATE INDEX IF NOT EXISTS idx_posts_is_pinned ON posts(is_pinned);
CREATE INDEX IF NOT EXISTS idx_posts_is_important ON posts(is_important);
CREATE INDEX IF NOT EXISTS idx_posts_created_at ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_posts_deleted_at ON posts(deleted_at);

-- Full-text search index (optional)
CREATE INDEX IF NOT EXISTS idx_posts_search
  ON posts
  USING gin (to_tsvector('simple', coalesce(title,'') || ' ' || coalesce(summary,'') || ' ' || coalesce(content,'')));

-- Add posts permissions
INSERT INTO permissions (code, name, module, description) VALUES
('posts.view', 'Xem bài đăng', 'posts', 'Xem danh sách và chi tiết bài đăng'),
('posts.create', 'Tạo bài đăng', 'posts', 'Tạo bài đăng mới'),
('posts.update', 'Sửa bài đăng', 'posts', 'Chỉnh sửa bài đăng'),
('posts.delete', 'Xóa bài đăng', 'posts', 'Xóa bài đăng')
ON CONFLICT (code) DO UPDATE
SET name = EXCLUDED.name,
    module = EXCLUDED.module,
    description = EXCLUDED.description;

-- Insert sample data
INSERT INTO posts (title, category, summary, content, is_pinned, is_important, tags, author_id, view_count, created_at) VALUES
(
  'Thông báo quan trọng về lịch sinh hoạt tháng 12/2024',
  'thong-bao',
  'Kính gửi quý chị em trong Hội Dòng, Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.',
  '<p>Kính gửi quý chị em trong Hội Dòng,</p><p>Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024. Các hoạt động sẽ được tổ chức theo kế hoạch đã được phê duyệt.</p><h4>Lịch trình chi tiết</h4><ul><li><strong>20/12/2024:</strong> Họp cộng đoàn định kỳ</li><li><strong>24/12/2024:</strong> Lễ Giáng sinh - Thánh lễ đêm</li><li><strong>28-31/12:</strong> Tĩnh tâm cuối năm</li></ul>',
  TRUE,
  TRUE,
  '["thông báo", "lịch sinh hoạt", "tháng 12"]'::jsonb,
  1,
  245,
  NOW() - INTERVAL '2 days'
),
(
  'Mừng lễ Giáng sinh 2024',
  'su-kien',
  'Chương trình mừng lễ Giáng sinh sẽ được tổ chức vào ngày 24/12.',
  '<p>Chương trình mừng lễ Giáng sinh 2024 sẽ được tổ chức vào ngày 24/12.</p><p>Mời quý chị em tham dự và chuẩn bị tiết mục văn nghệ.</p>',
  FALSE,
  FALSE,
  '["giáng sinh", "sự kiện", "2024"]'::jsonb,
  1,
  189,
  NOW() - INTERVAL '3 days'
),
(
  'Hướng dẫn sử dụng hệ thống mới',
  'huong-dan',
  'Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.',
  '<p>Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.</p><p>Vui lòng đọc kỹ trước khi sử dụng.</p><h4>Các tính năng mới:</h4><ul><li>Quản lý bài đăng</li><li>Tìm kiếm nâng cao</li><li>Báo cáo thống kê</li></ul>',
  FALSE,
  FALSE,
  '["hướng dẫn", "hệ thống"]'::jsonb,
  1,
  156,
  NOW() - INTERVAL '4 days'
),
(
  'Chia sẻ kinh nghiệm đào tạo',
  'chia-se',
  'Một số kinh nghiệm trong công tác đào tạo và đồng hành với các chị em.',
  '<p>Một số kinh nghiệm trong công tác đào tạo và đồng hành với các chị em trong giai đoạn tập sinh và khấn tạm.</p>',
  FALSE,
  FALSE,
  '["chia sẻ", "đào tạo"]'::jsonb,
  1,
  98,
  NOW() - INTERVAL '5 days'
),
(
  'Lịch họp tháng 12/2024',
  'thong-bao',
  'Thông báo lịch họp định kỳ tháng 12/2024.',
  '<p>Thông báo lịch họp định kỳ tháng 12/2024.</p><p>Đề nghị quý chị em sắp xếp thời gian tham dự đầy đủ.</p>',
  FALSE,
  FALSE,
  '["lịch họp", "tháng 12"]'::jsonb,
  1,
  134,
  NOW() - INTERVAL '6 days'
),
(
  'Tĩnh tâm cuối năm tại Đà Lạt',
  'su-kien',
  'Chương trình tĩnh tâm cuối năm sẽ được tổ chức tại Đà Lạt từ ngày 28-31/12.',
  '<p>Chương trình tĩnh tâm cuối năm sẽ được tổ chức tại Đà Lạt từ ngày 28-31/12.</p><p>Đăng ký tham gia trước ngày 20/12.</p>',
  FALSE,
  FALSE,
  '["tĩnh tâm", "đà lạt", "cuối năm"]'::jsonb,
  1,
  201,
  NOW() - INTERVAL '7 days'
);
