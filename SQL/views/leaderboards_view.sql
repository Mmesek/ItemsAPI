CREATE VIEW "leaderboards" AS
SELECT
    "items"."Transaction".timestamp,
    "Owner".server_id,
    "Owner".user_id,
    "items"."Transaction_Instances".instance_id,
    "items"."Transaction_Instances".quantity
FROM
    "items"."Transaction_Instances"
LEFT JOIN 
    "items"."Transaction" ON 
    "items"."Transaction".id = "items"."Transaction_Instances".transaction_id
LEFT JOIN 
    "Owner" ON 
    "Owner".character_id = r.character_id
;
