CREATE VIEW "locations" AS
SELECT
FROM
;

COMMENT ON VIEW "locations" IS '';

COMMENT ON COLUMN "locations"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _locations_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_locations_add
INSTEAD OF INSERT 
ON "locations"
FOR EACH ROW
EXECUTE FUNCTION _locations_add();

COMMENT ON FUNCTION _locations_add IS '';
COMMENT ON TRIGGER tg_locations_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _locations_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_locations_modify
INSTEAD OF UPDATE
ON "locations"
FOR EACH ROW
EXECUTE FUNCTION _locations_modify();

COMMENT ON FUNCTION _locations_modify IS '';
COMMENT ON TRIGGER tg_locations_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _locations_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_locations_remove
INSTEAD OF DELETE
ON "locations"
FOR EACH ROW
EXECUTE FUNCTION _locations_remove();

COMMENT ON FUNCTION _locations_remove IS '';
COMMENT ON TRIGGER tg_locations_remove IS '';
