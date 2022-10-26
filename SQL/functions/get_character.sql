CREATE OR REPLACE FUNCTION "get_character" 
    ("server_id" bigint, "user_id" bigint) 
    RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE
    _character_id bigint;
BEGIN
    SELECT "Owner".character_id INTO _character_id FROM "Owner" WHERE "Owner".user_id = "get_character".user_id AND "Owner".server_id = "get_character".server_id;
    IF _character_id is null THEN
        WITH ROWS AS (INSERT INTO "Character" DEFAULT VALUES RETURNING id) SELECT id FROM ROWS INTO _character_id;
        INSERT INTO "Owner" (user_id, server_id, character_id) VALUES ("get_character".user_id, server_id, _character_id);
    END IF;
RETURN _character_id;
END$$
