const pool = require("../config/database");

const upQuery = `
  CREATE TABLE IF NOT EXISTS sisters (
    id SERIAL PRIMARY KEY,
    code VARCHAR(30) NOT NULL UNIQUE,
    birth_name VARCHAR(120) NOT NULL,
    religious_name VARCHAR(120) NOT NULL,
    date_of_birth DATE NOT NULL,
    place_of_birth VARCHAR(150) NULL,
    nationality VARCHAR(80) NULL,
    father_name VARCHAR(120) NULL,
    mother_name VARCHAR(120) NULL,
    family_religion VARCHAR(80) NULL,
    baptism_date DATE NULL,
    baptism_place VARCHAR(150) NULL,
    confirmation_date DATE NULL,
    first_communion_date DATE NULL,
    phone VARCHAR(30) NULL,
    email VARCHAR(120) NULL,
    emergency_contact_name VARCHAR(120) NULL,
    emergency_contact_phone VARCHAR(30) NULL,
    photo_url VARCHAR(255) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK (status IN ('active','left')),
    created_by INTEGER NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_sisters_created_by FOREIGN KEY (created_by) REFERENCES users(id)
      ON DELETE SET NULL ON UPDATE CASCADE
  );
  
  CREATE INDEX IF NOT EXISTS idx_sisters_status ON sisters(status);
  CREATE INDEX IF NOT EXISTS idx_sisters_dob ON sisters(date_of_birth);
  
  CREATE OR REPLACE FUNCTION update_sisters_updated_at()
  RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
  END;
  $$ LANGUAGE plpgsql;

  DROP TRIGGER IF EXISTS sisters_updated_at_trigger ON sisters;
  
  CREATE TRIGGER sisters_updated_at_trigger
  BEFORE UPDATE ON sisters
  FOR EACH ROW
  EXECUTE FUNCTION update_sisters_updated_at();
`;

const downQuery = `
  DROP TRIGGER IF EXISTS sisters_updated_at_trigger ON sisters;
  DROP FUNCTION IF EXISTS update_sisters_updated_at();
  DROP TABLE IF EXISTS sisters;
`;

module.exports = {
  name: "003_create_sisters_table",
  up: async () => {
    const client = await pool.connect();
    try {
      await client.query(upQuery);
    } finally {
      client.release();
    }
  },
  down: async () => {
    const client = await pool.connect();
    try {
      await client.query(downQuery);
    } finally {
      client.release();
    }
  },
};
