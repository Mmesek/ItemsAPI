CREATE OR REPLACE VIEW "statistics" AS
SELECT
    server_id,
    instance_id,
    event_id,
    count(instance_id) AS spawns,
    sum(q) as claims
FROM (
    SELECT
        "Owner".server_id,
        "items"."Instance".id AS instance_id,
        "items"."Instance".event_id AS event_id,
        count("items"."Transaction_Instances".quantity) as q
    FROM
        "items"."Transaction_Instances"
    LEFT JOIN "items"."Instance" ON "items"."Transaction_Instances".instance_id = "items"."Instance".id
    LEFT JOIN "items"."Transaction" ON "items"."Transaction_Instances".transaction_id = "items"."Transaction".id
    LEFT JOIN "Owner" ON "Owner".character_id = "items"."Transaction_Instances".character_id
    WHERE
        "items"."Transaction_Instances".quantity > 0
    GROUP BY 
        "items"."Transaction".id, "items"."Instance".id, "Owner".server_id
) as r
GROUP BY
    instance_id, event_id, character_id
;

COMMENT ON VIEW "statistics" IS 'Amount of spawned and claimed items';
