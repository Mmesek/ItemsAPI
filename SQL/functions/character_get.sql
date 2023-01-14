CREATE OR REPLACE FUNCTION character_get 
    ("server_id" bigint, "user_id" bigint) 
    RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE
    _character_id bigint;
BEGIN
    -- Get character (if exists)
    SELECT "Owner".character_id
        FROM "Owner" 
        WHERE "Owner".user_id = character_get.user_id 
        AND "Owner".server_id = character_get.server_id
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
        VALUES (character_get.user_id, server_id, _character_id);
    END IF;

RETURN _character_id;
END$$

COMMENT ON FUNCTION "character_get" IS 'Returns character for server/user combination. Creates new character if combination is not found';
