-- Create user_communities table for data scoping
CREATE TABLE IF NOT EXISTS user_communities (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  community_id INT NOT NULL,
  granted_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE,
  FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL,
  UNIQUE(user_id, community_id)
);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_user_communities_user_id ON user_communities(user_id);
CREATE INDEX IF NOT EXISTS idx_user_communities_community_id ON user_communities(community_id);
