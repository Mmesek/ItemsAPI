CREATE VIEW "transactions" AS
SELECT
    "items"."Transaction".timestamp,
    "Owner".server_id,
    "Owner".user_id,
    "items"."Transaction_Instances".character_id,
    "items"."Transaction_Instances".instance_id,
    "items"."Transaction_Instances".quantity
FROM
    "items"."Transaction_Instances"
LEFT JOIN 
    "items"."Transaction" ON 
    "items"."Transaction".id = "items"."Transaction_Instances".transaction_id
LEFT JOIN
    "Owner" ON
    "Owner".character_id = "items"."Transaction_Instances".character_id
;

COMMENT ON VIEW "transactions" IS 'Character''s Inventory';

COMMENT ON COLUMN "transactions"."timestamp" IS 'Timestamp when this transaction occured';
COMMENT ON COLUMN "transactions"."server_id" IS 'Server on which inventory is being modified';
COMMENT ON COLUMN "transactions"."user_id" IS 'User of which inventory is being modified';
COMMENT ON COLUMN "transactions"."character_id" IS 'Character''s inventory being modified';
COMMENT ON COLUMN "transactions"."instance_id" IS 'Instance ID being transfered';
COMMENT ON COLUMN "transactions"."quantity" IS 'Amount of transfered instance';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _transaction_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
-- If character is not specified, try to fetch based on Server/User
IF NEW.character_id IS NULL THEN
    SELECT 
        "Owner".character_id
    FROM "Owner" 
    WHERE 
        "Owner".user_id = NEW.user_id
    AND "Owner".server_id = NEW.server_id 
    INTO NEW.character_id;
END IF;
-- If character is not found, return
IF NEW.character_id IS NULL THEN
    RETURN NULL;
END IF;
-- Check if quantity is positive value and create new transaction where character is a recipent
IF NEW.quantity > 0 THEN
    PERFORM transfer(NULL, NEW.character_id, NEW.instance_id, NEW.quantity);
ELSE
    -- Otherwise, try to create new transaction where character is a sender instead
    IF (SELECT transfer(NEW.character_id, NULL, NEW.instance_id, -NEW.quantity)) IS NULL THEN
        RETURN NULL;
    END IF;
END IF;
RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_transactions_add 
INSTEAD OF INSERT 
ON "transactions"
FOR EACH ROW
EXECUTE FUNCTION _transaction_add();

COMMENT ON FUNCTION _transaction_add IS 'Adds new incoming transaction OR outgoing if quantity is below 0. Checks if character has enough to deduce before proceeding';
COMMENT ON TRIGGER tg_add_transaction IS 'Instead of Insert executes add_transaction. Checks if quantity is negative, and if character has enough to deduce from';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _transaction_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
-- Try to create new transaction where character is a sender
IF (SELECT transfer(OLD.character_id, NULL, OLD.instance_id, OLD.quantity)) IS NULL THEN
    RETURN NULL;
END IF;
RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_transactions_remove 
INSTEAD OF DELETE
ON "transactions"
FOR EACH ROW
EXECUTE FUNCTION _transaction_remove();

COMMENT ON FUNCTION _transaction_remove IS 'Adds new outgoing transaction. Checks if character has enough to deduce before proceeding';
COMMENT ON TRIGGER tg_remove_transaction IS 'Instead of Delete executes remove_transaction. Checks if character has enough to deduce from';
