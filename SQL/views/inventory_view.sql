CREATE OR REPLACE VIEW "Inventory" AS
SELECT
    "Owner".server_id,
    "Owner".user_id,
    "Item".name as item,
    "Item".id as item_id,
    "Instance".id as instance_id,
    "Character_Inventory".quantity
FROM ("Character_Inventory"
    JOIN "Instance" ON (instance_id = "Instance".id)
    JOIN "Item" ON (item_id = "Instance".item_id)
    JOIN "Owner" ON ("Character_Inventory".character_id = "Owner".character_id)
);
