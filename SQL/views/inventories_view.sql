CREATE VIEW "inventories" AS
SELECT
    "items"."Transaction_Instances".character_id,
    "items"."Transaction_Instances".instance_id,
    sum("items"."Transaction_Instances".quantity) as quantity
FROM
    "items"."Transaction_Instances"
GROUP BY
    "items"."Transaction_Instances".character_id,
    "items"."Transaction_Instances".instance_id
;

COMMENT ON VIEW "inventories" IS 'List of owned items by character';

COMMENT ON COLUMN "inventories"."character_id" IS 'Character that owns this item';
COMMENT ON COLUMN "inventories"."instance_id" IS 'Instance that is owned';
COMMENT ON COLUMN "inventories"."quantity" IS 'Current Quantity owned by character';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _inventories_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
PERFORM transfer(NULL, NEW.character_id, NEW.instance_id, NEW.quantity);
RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_inventories_add
INSTEAD OF INSERT 
ON "inventories"
FOR EACH ROW
EXECUTE FUNCTION _inventories_add();

COMMENT ON FUNCTION _inventories_add IS 'Adds new item to user''s inventory by creating new transaction with positive quantity';
COMMENT ON TRIGGER tg_inventories_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _inventories_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
PERFORM transfer(NULL, NEW.character_id, NEW.instance_id, NEW.quantity-OLD.quantity);
RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_inventories_modify
INSTEAD OF UPDATE
ON "inventories"
FOR EACH ROW
EXECUTE FUNCTION _inventories_modify();

COMMENT ON FUNCTION _inventories_modify IS 'Modifies quantity in user''s inventory by creating new transaction with a difference';
COMMENT ON TRIGGER tg_inventories_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _inventories_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
PERFORM transfer(NEW.character_id, NULL, NEW.instance_id, OLD.quantity);
RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_inventories_remove
INSTEAD OF DELETE
ON "inventories"
FOR EACH ROW
EXECUTE FUNCTION _inventories_remove();

COMMENT ON FUNCTION _inventories_remove IS 'Removes item from user''s inventory by creating new transaction with negative quantity';
COMMENT ON TRIGGER tg_inventories_remove IS '';
