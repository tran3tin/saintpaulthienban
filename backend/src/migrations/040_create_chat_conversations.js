// migrations/040_create_chat_conversations.js

const db = require("../config/database");

const up = async () => {
  console.log("Running migration: Create chat_conversations table...");

  const createTableQuery = `
    CREATE TABLE IF NOT EXISTS chat_conversations (
      id SERIAL PRIMARY KEY,
      conversation_id UUID NOT NULL,
      user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
      user_message TEXT NOT NULL,
      ai_response TEXT NOT NULL,
      context_used JSONB,
      entities_extracted JSONB,
      intent VARCHAR(50),
      tokens_used INTEGER DEFAULT 0,
      cost NUMERIC(10, 6) DEFAULT 0,
      is_helpful BOOLEAN,
      feedback TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  `;

  try {
    await db.query(createTableQuery);
    console.log("✅ chat_conversations table created successfully");
  } catch (error) {
    console.error("❌ Error creating chat_conversations table:", error.message);
    throw error;
  }
};

const down = async () => {
  console.log("Rolling back migration: Drop chat_conversations table...");

  try {
    await db.query("DROP TABLE IF EXISTS chat_conversations");
    console.log("✅ chat_conversations table dropped successfully");
  } catch (error) {
    console.error("❌ Error dropping chat_conversations table:", error.message);
    throw error;
  }
};

module.exports = { up, down };
