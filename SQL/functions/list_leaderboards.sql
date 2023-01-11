CREATE OR REPLACE FUNCTION list_leaderboards
    (
        server_id BIGINT, 
        after TIMESTAMP DEFAULT TIMESTAMP '2020-1-1', 
        before TIMESTAMP DEFAULT now(), 
        limit_at INT DEFAULT 100,
        user_id BIGINT DEFAULT NULL
    )
RETURNS TABLE (name VARCHAR, instance_id BIGINT, starts TIMESTAMPTZ, ends TIMESTAMPTZ)
AS
$$
    SELECT DISTINCT "items"."Instance".name, "leaderboards".instance_id
    FROM "leaderboards"
    LEFT JOIN "items"."Instance" ON "items"."Instance".id = "leaderboards".instance_id
    WHERE 
        "leaderboards".server_id = list_leaderboards.server_id
        AND "leaderboards".timestamp BETWEEN list_leaderboards.after AND list_leaderboards.before
        AND (
            list_leaderboards.user_id IS NULL
            OR "leaderboards".user_id = list_leaderboards.user_id
        )
$$
LANGUAGE sql;

COMMENT ON FUNCTION "list_leaderboards" IS 'Returns available leaderboards on server';
