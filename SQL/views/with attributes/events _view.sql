CREATE VIEW "events" AS
SELECT
FROM
;

COMMENT ON VIEW "events" IS '';

COMMENT ON COLUMN "events"."" IS '';

-- ************************************** Insert Trigger

CREATE OR REPLACE FUNCTION _events_add()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_events_add
INSTEAD OF INSERT 
ON "events"
FOR EACH ROW
EXECUTE FUNCTION _events_add();

COMMENT ON FUNCTION _events_add IS '';
COMMENT ON TRIGGER tg_events_add IS '';

-- ************************************** Update Trigger

CREATE OR REPLACE FUNCTION _events_modify()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN NEW;
END$$;

CREATE OR REPLACE TRIGGER tg_events_modify
INSTEAD OF UPDATE
ON "events"
FOR EACH ROW
EXECUTE FUNCTION _events_modify();

COMMENT ON FUNCTION _events_modify IS '';
COMMENT ON TRIGGER tg_events_modify IS '';

-- ************************************** Delete Trigger

CREATE OR REPLACE FUNCTION _events_remove()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN

RETURN OLD;
END$$;

CREATE OR REPLACE TRIGGER tg_events_remove
INSTEAD OF DELETE
ON "events"
FOR EACH ROW
EXECUTE FUNCTION _events_remove();

COMMENT ON FUNCTION _events_remove IS '';
COMMENT ON TRIGGER tg_events_remove IS '';
