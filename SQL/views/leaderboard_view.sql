CREATE OR REPLACE VIEW "Leaderboard" AS
SELECT 
    "Owner".server_id,
    "Owner".user_id,
    "Instance".event_id,
    "Item".name,
    sum("Inventory".quantity) as quantity
FROM (
    "Inventory"
        JOIN "Instance" ON ("Instance".id = "Inventory".item)
        JOIN "Item" ON ("Instance".item_id = "Item".id)
        JOIN "Owner" ON ("Inventory".id = "Owner".character_id)
)
GROUP BY 
    "Owner".server_id, 
    "Owner".user_id, 
    "Item".name, 
    "Instance".event_id
ORDER BY quantity DESC;