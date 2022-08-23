CREATE OR REPLACE FUNCTION "modify_quantity" 
    ("character_id" bigint, "instance_id" BIGINT, "quantity" real) 
    RETURNS real LANGUAGE plpgsql AS $$
DECLARE
    _quantity real;
BEGIN
    WITH ROWS AS (
        INSERT INTO "Character_Inventory" (character_id, instance_id, quantity) 
        VALUES (character_id, instance_id, quantity)
            ON CONFLICT ON CONSTRAINT "PK_Character_Instance" DO 
                UPDATE
                SET quantity = "Character_Inventory".quantity + "modify_quantity".quantity
                WHERE "Character_Inventory".character_id = "modify_quantity".character_id
                AND "Character_Inventory".instance_id = "modify_quantity".instance_id
        RETURNING "Character_Inventory".quantity
    ) SELECT ROWS.quantity FROM ROWS INTO _quantity;
RETURN _quantity;
END$$
