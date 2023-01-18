CREATE VIEW "instances" AS
SELECT
FROM
;

COMMENT ON VIEW "instances" IS '';

COMMENT ON COLUMN "instances"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _instances_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_instances_add
INSTEAD OF INSERT 
ON "instances"
FOR EACH ROW
EXECUTE FUNCTION _instances_add();

COMMENT ON FUNCTION _instances_add IS '';
COMMENT ON TRIGGER tg_instances_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _instances_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_instances_modify
INSTEAD OF UPDATE
ON "instances"
FOR EACH ROW
EXECUTE FUNCTION _instances_modify();

COMMENT ON FUNCTION _instances_modify IS '';
COMMENT ON TRIGGER tg_instances_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _instances_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_instances_remove
INSTEAD OF DELETE
ON "instances"
FOR EACH ROW
EXECUTE FUNCTION _instances_remove();

COMMENT ON FUNCTION _instances_remove IS '';
COMMENT ON TRIGGER tg_instances_remove IS '';
