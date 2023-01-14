CREATE VIEW "inventories" AS
SELECT
    "items"."Transaction_Instances".character_id,
    "items"."Transaction_Instances".instance_id,
    sum("items"."Transaction_Instances".quantity) as quantity
FROM
    "items"."Transaction_Instances"
GROUP BY
    "items"."Transaction_Instances".character_id,
    "items"."Transaction_Instances".instance_id
;

COMMENT ON VIEW "inventories" IS 'List of owned items by character';

COMMENT ON COLUMN "inventories"."character_id" IS 'Character that owns this item';
COMMENT ON COLUMN "inventories"."instance_id" IS 'Instance that is owned';
COMMENT ON COLUMN "inventories"."quantity" IS 'Current Quantity owned by character';
