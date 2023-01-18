CREATE VIEW "items" AS
SELECT
FROM
;

COMMENT ON VIEW "items" IS '';

COMMENT ON COLUMN "items"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _items_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_items_add
INSTEAD OF INSERT 
ON "items"
FOR EACH ROW
EXECUTE FUNCTION _items_add();

COMMENT ON FUNCTION _items_add IS '';
COMMENT ON TRIGGER tg_items_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _items_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_items_modify
INSTEAD OF UPDATE
ON "items"
FOR EACH ROW
EXECUTE FUNCTION _items_modify();

COMMENT ON FUNCTION _items_modify IS '';
COMMENT ON TRIGGER tg_items_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _items_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_items_remove
INSTEAD OF DELETE
ON "items"
FOR EACH ROW
EXECUTE FUNCTION _items_remove();

COMMENT ON FUNCTION _items_remove IS '';
COMMENT ON TRIGGER tg_items_remove IS '';
