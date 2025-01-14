CREATE OR REPLACE FUNCTION transfer
    (
        sender_id BIGINT, 
        recipent_id BIGINT, 
        instance_id BIGINT, 
        quantity REAL, 
        transaction_id BIGINT DEFAULT NULL
    )
    RETURNS BIGINT LANGUAGE plpgsql AS $$
BEGIN
    -- Check if sender has enough to send
    IF sender_id IS NOT NULL AND (
            SELECT COALESCE(quantity, 0.0)
            FROM "inventories"
            WHERE "inventories".character_id = sender_id
            AND "inventories".instance_id = instance_id
        ) < quantity THEN
            RETURN NULL;
    END IF;

    -- If this is not part of an ongoing transaction, create one
    IF transaction_id IS NULL THEN
        INSERT INTO "items"."Transaction"
        DEFAULT VALUES
        RETURNING id
        INTO transaction_id;
    END IF;

    -- Remove item from sender, if there's sender
    IF sender_id IS NOT NULL THEN
        INSERT INTO "items"."Transaction_Instances" (transaction_id, instance_id, quantity, character_id)
        VALUES (transaction_id, instance_id, -quantity, sender_id);
    END IF;

    -- Add item to recipent, if there's recipent
    IF recipent_id IS NOT NULL THEN
        INSERT INTO "items"."Transaction_Instances" (transaction_id, instance_id, quantity, character_id)
        VALUES (transaction_id, instance_id, quantity, recipent_id);
    END IF;

RETURN transaction_id;
END$$;

COMMENT ON FUNCTION "transfer" IS 'Adds transaction item to specified character if sender has more than enough items to send, otherwise returns NULL. Optionally creates new transaction';
