CREATE OR REPLACE VIEW "Inventory" AS
SELECT "Owner".id,
    "Instance".name as item,
    "Character_Inventory".quantity
    FROM (((("Character_Inventory"
        JOIN "Instance" ON (("Character_Inventory".instance_id = "Instance".id)))
        JOIN "Owner" ON (
            ("Owner".character_id = "Character".id)
            JOIN "Character" ON ("Character".id = "Character_Inventory".character_id)))) 
    );
