CREATE OR REPLACE FUNCTION remove_item
    (server_id BIGINT, user_ids BIGINT[], instance_id BIGINT, quantity REAL, minimum BOOLEAN) 
    RETURNS BIGINT[] LANGUAGE plpgsql AS $$
DECLARE
    _character_id BIGINT;
    _user_id BIGINT;
    _users BIGINT[];
    _transaction_id BIGINT;
BEGIN
    -- Create new transaction
    INSERT INTO "items"."Transaction" DEFAULT VALUES RETURNING id INTO _transaction_id;

    -- For each user
    FOREACH _user_id IN ARRAY user_ids
    LOOP
        -- Retrieve user's character, or add new character in case user is not in Database
        SELECT get_character(server_id, _user_id) INTO _character_id;

        -- Select current character's balance in case there's not enough
        SELECT get_balance(_character_id, instance_id) INTO _balance;

        -- Check if user has enough items or if minimum is allowed
        IF _balance >= quantity OR minimum THEN
            -- Add new entry with removed item
            INSERT INTO "items"."Transaction_Instances" (transaction_id, instance_id, quantity, character_id)
            VALUES (_transaction_id, instance_id, -LEAST(quantity, _balance), _character_id);

            -- Append array with users that got item removed
            _users := array_append(_users, _user_id);
        END IF;
    END LOOP;

-- Return array of users with removed item
RETURN _users;
END$$

COMMENT ON FUNCTION "add_item" IS 'Removes item from specified users that have at least enough items or removes what it can when minimum is set';
