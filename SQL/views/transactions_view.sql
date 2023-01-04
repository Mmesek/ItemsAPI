CREATE OR REPLACE VIEW "Transactions" AS
SELECT 
    "items"."Transaction".timestamp,
    "items"."Item".name,
    "items"."Transaction_Instances".instance_id,
    "items"."Transaction_Instances".quantity,
    sender.user_id as character_id
    FROM ("items"."Transaction_Instances"
        LEFT JOIN "items"."Transaction" ON ("items"."Transaction_Instances".transaction_id = "items"."Transaction".id)
        LEFT JOIN "items"."Instance" ON ("items"."Transaction_Instances".instance_id = "items"."Instance".id)
        LEFT JOIN "items"."Item" ON ("items"."Instance".item_id = "items"."Item".id)
        LEFT JOIN "Owner" sender ON ("items"."Transaction_Instances".character_id = sender.character_id)
    );

COMMENT ON VIEW "Transactions" IS 'Character''s Inventory';

COMMENT ON COLUMN "Transactions"."timestamp" IS 'Timestamp when this transaction occured';
COMMENT ON COLUMN "Transactions"."name" IS 'Name of transfered item';
COMMENT ON COLUMN "Transactions"."instance_id" IS 'Instance ID being transfered';
COMMENT ON COLUMN "Transactions"."quantity" IS 'Amount of transfered instance';
COMMENT ON COLUMN "Transactions"."character_id" IS 'Character''s inventory being modified';
