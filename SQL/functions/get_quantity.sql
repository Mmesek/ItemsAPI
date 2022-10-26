CREATE OR REPLACE FUNCTION "get_quantity" 
    ("character_id" bigint, "instance_id" BIGINT) 
    RETURNS real LANGUAGE plpgsql AS $$
DECLARE
    quantity real;
BEGIN
    SELECT "Character_Inventory".quantity 
    FROM "Character_Inventory"
    WHERE "Character_Inventory".character_id = "get_quantity".character_id
    AND "Character_Inventory".instance_id = "get_quantity".instance_id
    INTO quantity;
RETURN COALESCE(quantity, 0.0);
END$$
