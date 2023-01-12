CREATE OR REPLACE FUNCTION list_leaderboards
    (
        server_id BIGINT, 
        after TIMESTAMP DEFAULT TIMESTAMP '2020-1-1', 
        before TIMESTAMP DEFAULT now(), 
        limit_at INT DEFAULT 100,
        user_id BIGINT DEFAULT NULL,
        item VARCHAR DEFAULT NULL
    )
RETURNS TABLE (name VARCHAR, instance_id BIGINT, starts TIMESTAMPTZ, ends TIMESTAMPTZ)
AS
$$
DECLARE
    _event RECORD;
    _year INTEGER;
BEGIN
    FOR _event IN (
        SELECT DISTINCT 
            "items"."Instance".name, 
            "leaderboards".instance_id,
            "items"."Event".start_date,
            "items"."Event".end_date,
            "items"."Event_Attribute".bool as repeatable
    FROM "leaderboards"
    LEFT JOIN "items"."Instance" ON "items"."Instance".id = "leaderboards".instance_id
    LEFT JOIN "items"."Event" ON "items"."Event".id = "items"."Instance".event_id
    LEFT JOIN "items"."Event_Attribute" ON "items"."Event_Attribute".event_id = "items"."Instance".event_id AND "items"."Event_Attribute".name = 'repeatable'
    WHERE 
        "leaderboards".server_id = list_leaderboards.server_id
        AND "leaderboards".timestamp BETWEEN list_leaderboards.after AND list_leaderboards.before
        AND (
            list_leaderboards.user_id IS NULL
            OR "leaderboards".user_id = list_leaderboards.user_id
        )
        AND "items"."Instance".event_id IS NOT NULL
        AND (
            list_leaderboards.item IS NULL
            OR "items"."Instance".name ILIKE list_leaderboards.item
        )
    )
    LOOP
        name := _event.name;
        instance_id := _event.instance_id;

        IF _event.repeatable THEN
            _year = EXTRACT(year FROM now())::INTEGER;

            starts := move_timestamp_to_year(_event.start_date);
            
            IF EXTRACT(year FROM _event.end_date) != EXTRACT(year FROM _event.start_date) THEN
                _year = _year + EXTRACT(year FROM _event.end_date) - EXTRACT(year FROM _event.start_date);
            END IF;
            
            ends := move_timestamp_to_year(_event.end_date, _year);
        ELSE
            starts := _event.start_date;
            ends := _event.end_date;
        END IF;
        RETURN NEXT;
    END LOOP;
END$$
LANGUAGE plpgsql;

COMMENT ON FUNCTION "list_leaderboards" IS 'Returns available leaderboards on server';
