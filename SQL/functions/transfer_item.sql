CREATE OR REPLACE FUNCTION transfer_item
    (
        server_id BIGINT, user_ids BIGINT[], instance_id BIGINT, quantity REAL, 
        required_instance_id INT DEFAULT null, required_quantity REAL DEFAULT null,
        _transaction_id BIGINT DEFAULT null
    )
    RETURNS BIGINT[] LANGUAGE plpgsql AS $$
DECLARE
    _character_id BIGINT;
    _user_id BIGINT;
    _users BIGINT[];
    _characters BIGINT[];
BEGIN
    -- For each user
    FOREACH _user_id IN ARRAY user_ids
    LOOP
        -- Retrieve user's character, or add new character in case user is not in Database
        SELECT character_get(server_id, _user_id) INTO _character_id;

        -- Check if user has required item, if so, check if user has less than required and skip
        IF required_instance_id is not null AND (
            SELECT COALESCE(quantity, 0.0)
            FROM "inventories"
            WHERE "inventories".character_id = _character_id
            AND "inventories".instance_id = required_instance_id
        ) < required_quantity THEN
            CONTINUE;
        END IF;

        -- Append array with users that can claim item
        _characters := array_append(_characters, _character_id);
        _users := array_append(_users, _user_id);
    END LOOP;

    -- Check if any user matches criteria
    IF CARDINALITY(_users) != 0 THEN
        IF _transaction_id IS NULL THEN
            -- Create new transaction
            INSERT INTO "items"."Transaction" DEFAULT VALUES RETURNING id INTO _transaction_id;
        END IF;

        -- For each user that has enough, add item
        FOREACH _character_id IN ARRAY _characters
        LOOP
            -- Check if there is any required item
            IF required_instance_id is not null THEN
                -- User apparently has more than enough, deduce required quantity
                PERFORM transfer(_character_id, NULL, required_instance_id, required_quantity, _transaction_id);
            END IF;

            IF instance_id is not null THEN
                -- Add new entry with claimed item
                PERFORM transfer(NULL, _character_id, instance_id, quantity, _transaction_id);
            END IF;
        END LOOP;
    END IF;

-- Return array of users that received item
RETURN _users;
END$$;

COMMENT ON FUNCTION "transfer_item" IS 'Adds item to specified users that have required items and removes required item from';
