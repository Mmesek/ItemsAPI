CREATE OR REPLACE FUNCTION leaderboard
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
    SELECT "transactions".user_id, sum("transactions".quantity) AS quantity
    FROM "transactions"
    WHERE
        "transactions".instance_id = leaderboard.instance_id
        AND "transactions".server_id = leaderboard.server_id
        AND "transactions".timestamp BETWEEN leaderboard.after AND leaderboard.before
        AND (
            leaderboard.user_id IS NULL
            OR "transactions".user_id = leaderboard.user_id
        )
    GROUP BY "transactions".instance_id, "transactions".user_id, "transactions".server_id
    ORDER BY quantity DESC
    LIMIT leaderboard.limit_at;
$$
LANGUAGE sql;

COMMENT ON FUNCTION "leaderboard" IS 'Returns server leaderboard for instance';
