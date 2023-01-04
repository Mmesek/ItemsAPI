CREATE OR REPLACE VIEW "Inventory" AS
SELECT
    "Owner".server_id,
    "Owner".user_id,
    "items"."Item".name AS item,
    "items"."Item".id AS item_id,
    "items"."Instance".id AS instance_id,
    "items"."Instance".event_id AS event_id,
    sum(quantity) AS quantity
FROM (
    "items"."Transaction_Instances"
    JOIN "items"."Instance" ON "items"."Transaction_Instances".instance_id = "items"."Instance".id
    JOIN "items"."Item" ON "items"."Instance".item_id = "items"."Item".id
    JOIN "Owner" ON "items"."Transaction_Instances".character_id = "Owner".character_id
)
GROUP BY 
    "Owner".character_id, 
    "items"."Item".name, 
    "items"."Item".id,
    "items"."Instance".id
;

COMMENT ON VIEW "Inventory" IS 'Character''s Inventory';

COMMENT ON COLUMN "Inventory"."server_id" IS 'Server that owns this Character''s inventory';
COMMENT ON COLUMN "Inventory"."user_id" IS 'User that owns this Character''s inventory';
COMMENT ON COLUMN "Inventory"."item" IS 'Item in Character''s inventory';
COMMENT ON COLUMN "Inventory"."item_id" IS 'Item ID in Character''s inventory';
COMMENT ON COLUMN "Inventory"."instance_id" IS 'Instance in this inventory';
COMMENT ON COLUMN "Inventory"."event_id" IS 'Event this item''s instance is related to';
COMMENT ON COLUMN "Inventory"."quantity" IS 'Sum of transactions involving instance in Character''s inventory';
