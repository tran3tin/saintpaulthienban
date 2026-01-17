ALTER TABLE sisters ADD COLUMN IF NOT EXISTS saint_name VARCHAR(120);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS hometown VARCHAR(150);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS permanent_address VARCHAR(255);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS current_address VARCHAR(255);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card VARCHAR(20);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card_date DATE;
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS id_card_place VARCHAR(150);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS father_occupation VARCHAR(150);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS mother_occupation VARCHAR(150);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS siblings_count INT;
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS family_address VARCHAR(255);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS documents TEXT;
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS current_stage VARCHAR(50);
ALTER TABLE sisters ADD COLUMN IF NOT EXISTS current_community_id INT;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='sisters' AND column_name='religious_name') THEN
        UPDATE sisters SET saint_name = religious_name WHERE saint_name IS NULL;
    END IF;
END $$;
