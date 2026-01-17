-- Add missing columns to vocation_journey table
ALTER TABLE vocation_journey ADD COLUMN IF NOT EXISTS location VARCHAR(150);
ALTER TABLE vocation_journey ADD COLUMN IF NOT EXISTS superior VARCHAR(150);
ALTER TABLE vocation_journey ADD COLUMN IF NOT EXISTS formation_director VARCHAR(150);
ALTER TABLE vocation_journey ADD COLUMN IF NOT EXISTS documents TEXT;

-- Convert stage to VARCHAR if it's restricted (handling Postgres specific logic)
DO $$
BEGIN
    -- Check if we need to convert stage column type
    -- This block simply tries to alter it to varchar.
    -- If it's already varchar, it does nothing or succeeds.
    -- If it's an enum, we cast it.
    BEGIN
        ALTER TABLE vocation_journey ALTER COLUMN stage TYPE VARCHAR(50) USING stage::VARCHAR;
    EXCEPTION WHEN OTHERS THEN
        -- If direct cast fails, it might be due to existing enum constraints or dependencies
        -- But normally casting enum to text/varchar works.
        RAISE NOTICE 'Could not alter stage column type: %', SQLERRM;
    END;
END $$;
