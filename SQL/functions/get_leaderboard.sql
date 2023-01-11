CREATE OR REPLACE FUNCTION get_leaderboard
    (
        server_id BIGINT, 
        instance_id BIGINT, 
        after TIMESTAMPTZ DEFAULT now() - interval '30d', 
        before TIMESTAMPTZ DEFAULT now(), 
        limit_at INT DEFAULT 100,
        user_id BIGINT DEFAULT NULL
    )
RETURNS TABLE (user_id BIGINT, quantity REAL)
AS
$$
    SELECT "leaderboards".user_id, sum("leaderboards".quantity) AS quantity
    FROM "leaderboards"
    WHERE
        "leaderboards".instance_id = get_leaderboard.instance_id
        AND "leaderboards".server_id = get_leaderboard.server_id
        AND "leaderboards".timestamp BETWEEN get_leaderboard.after AND get_leaderboard.before
        AND (
            get_leaderboard.user_id IS NULL
            OR "leaderboards".user_id = get_leaderboard.user_id
        )
    GROUP BY "leaderboards".instance_id, "leaderboards".user_id, "leaderboards".server_id
    ORDER BY quantity DESC
    LIMIT get_leaderboard.limit_at;
$$
LANGUAGE sql;

COMMENT ON FUNCTION "get_leaderboard" IS 'Returns server leaderboard for instance';
