CREATE OR REPLACE FUNCTION "add_item" 
    ("server_id" bigint, "user_ids" bigint[], "instance_id" BIGINT, "quantity" real, 
    "required_instance_id" INT DEFAULT null, "required_quantity" real DEFAULT null
    ) 
    RETURNS bigint[] LANGUAGE plpgsql AS $$
DECLARE
    _character_id bigint;
    _user_id bigint;
    _users bigint[];
BEGIN
    -- For each user
    FOREACH _user_id IN ARRAY user_ids
    LOOP
        -- Add user in case user is not in Database
        SELECT get_character(server_id, _user_id) INTO _character_id;

        IF required_instance_id is not null AND (
            SELECT get_quantity(_character_id, required_instance_id)
        ) < required_quantity THEN
            -- Check if user has required item, if so, check if user has less than required and skip
            CONTINUE;

        ELSIF required_instance_id is not null THEN
            PERFORM modify_quantity(_character_id, required_instance_id, -required_quantity);
            -- User apparently has more than enough, deduce required quantity
        END IF;

        PERFORM modify_quantity(_character_id, instance_id, quantity);
        -- Add claimed item, or increase existing
        
        PERFORM add_transaction(_character_id, _character_id, instance_id, quantity, required_instance_id, required_quantity);

        _users := array_append(_users, _user_id);
        -- Append array with users that received item
    END LOOP;
RETURN _users;
-- Return array of users that received item
END$$
