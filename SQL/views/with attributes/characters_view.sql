CREATE VIEW "characters" AS
SELECT
FROM
;

COMMENT ON VIEW "characters" IS '';

COMMENT ON COLUMN "characters"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _characters_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_characters_add
INSTEAD OF INSERT 
ON "characters"
FOR EACH ROW
EXECUTE FUNCTION _characters_add();

COMMENT ON FUNCTION _characters_add IS '';
COMMENT ON TRIGGER tg_characters_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _characters_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_characters_modify
INSTEAD OF UPDATE
ON "characters"
FOR EACH ROW
EXECUTE FUNCTION _characters_modify();

COMMENT ON FUNCTION _characters_modify IS '';
COMMENT ON TRIGGER tg_characters_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _characters_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_characters_remove
INSTEAD OF DELETE
ON "characters"
FOR EACH ROW
EXECUTE FUNCTION _characters_remove();

COMMENT ON FUNCTION _characters_remove IS '';
COMMENT ON TRIGGER tg_characters_remove IS '';
