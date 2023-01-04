CREATE OR REPLACE VIEW "Leaderboard" AS
SELECT 
    "items"."Event".name as event,
    "items"."Inventory".item,
    "items"."Inventory".server_id,
    "items"."Inventory".user_id,
    "items"."Inventory".quantity as quantity
FROM (
    "Inventory" 
    LEFT JOIN 
        "items"."Event"
    ON 
        "items"."Event".id = "Inventory".event_id
)
GROUP BY 
    server_id, 
    user_id, 
    item, 
    event_id
ORDER BY quantity DESC;

COMMENT ON VIEW "Leaderboard" IS 'Items Leaderboard';

COMMENT ON COLUMN "Leaderboard"."event" IS 'Name of Event';
COMMENT ON COLUMN "Leaderboard"."item" IS 'Name of Item';
COMMENT ON COLUMN "Leaderboard"."server_id" IS 'ID of related Server';
COMMENT ON COLUMN "Leaderboard"."user_id" IS 'ID of owning User';
COMMENT ON COLUMN "Leaderboard"."quantity" IS 'Amount of owned instance by Character''s inventory';
