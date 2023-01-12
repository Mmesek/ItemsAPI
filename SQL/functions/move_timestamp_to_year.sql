DROP FUNCTION move_timestamp_to_year;
CREATE OR REPLACE FUNCTION move_timestamp_to_year
    (
        current TIMESTAMPtz,
        new_year INTEGER DEFAULT NULL
    ) 
    RETURNS TIMESTAMPtz LANGUAGE plpgsql AS $$
BEGIN
    IF new_year IS NULL THEN
        new_year = EXTRACT(year FROM now())::INTEGER;
    END IF;
    RETURN make_timestamp(
        new_year, 
        EXTRACT(month FROM current)::INTEGER, 
        EXTRACT(day FROM current)::INTEGER,
        EXTRACT(hour FROM current)::INTEGER,
        EXTRACT(minute FROM current)::INTEGER,
        EXTRACT(second FROM current)::INTEGER
    );
END$$

COMMENT ON FUNCTION move_timestamp_to_year IS 'Shifts date to current (or specified) year while leaving month/day intact';