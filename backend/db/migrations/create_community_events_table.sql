-- Create community_events table for manual events
CREATE TABLE IF NOT EXISTS community_events (
  id SERIAL PRIMARY KEY,
  community_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE
);

-- Index for performance
CREATE INDEX IF NOT EXISTS idx_community_events_community_id ON community_events(community_id);
CREATE INDEX IF NOT EXISTS idx_community_events_event_date ON community_events(event_date);
