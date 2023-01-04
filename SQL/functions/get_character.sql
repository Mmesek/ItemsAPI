CREATE OR REPLACE FUNCTION get_character 
    ("server_id" bigint, "user_id" bigint) 
    RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE
    _character_id bigint;
BEGIN
    -- Get character (if exists)
    SELECT "Owner".character_id
        FROM "Owner" 
        WHERE "Owner".user_id = get_character.user_id 
        AND "Owner".server_id = get_character.server_id
    INTO _character_id;

    -- Check if character exists
    IF _character_id is null THEN
        -- Create character
        WITH ROWS AS (
            INSERT INTO "items"."Character" 
            DEFAULT VALUES RETURNING id
        ) SELECT id 
            FROM ROWS 
        INTO _character_id;

        -- Add character to this user
        INSERT INTO "Owner" (user_id, server_id, character_id) 
        VALUES (get_character.user_id, server_id, _character_id);
    END IF;

RETURN _character_id;
END$$
