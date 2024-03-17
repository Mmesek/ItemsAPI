CREATE VIEW "drops" AS
SELECT
FROM
;

COMMENT ON VIEW "drops" IS '';

COMMENT ON COLUMN "drops"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _drops_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_drops_add
INSTEAD OF INSERT 
ON "drops"
FOR EACH ROW
EXECUTE FUNCTION _drops_add();

COMMENT ON FUNCTION _drops_add IS '';
COMMENT ON TRIGGER tg_drops_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _drops_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_drops_modify
INSTEAD OF UPDATE
ON "drops"
FOR EACH ROW
EXECUTE FUNCTION _drops_modify();

COMMENT ON FUNCTION _drops_modify IS '';
COMMENT ON TRIGGER tg_drops_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _drops_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_drops_remove
INSTEAD OF DELETE
ON "drops"
FOR EACH ROW
EXECUTE FUNCTION _drops_remove();

COMMENT ON FUNCTION _drops_remove IS '';
COMMENT ON TRIGGER tg_drops_remove IS '';
