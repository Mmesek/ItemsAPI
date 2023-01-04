CREATE OR REPLACE FUNCTION get_balance
    (character_id BIGINT, instance_id BIGINT) 
    RETURNS real LANGUAGE plpgsql AS $$
BEGIN
    RETURN COALESCE((
        SELECT
            sum("items"."Transaction_Instances".quantity)
        FROM
            "items"."Transaction_Instances"
        WHERE
            "items"."Transaction_Instances".character_id = get_balance.character_id
        AND
            "items"."Transaction_Instances".instance_id = get_balance.instance_id
        GROUP BY
            "items"."Transaction_Instances".instance_id,
            "items"."Transaction_Instances".character_id
        ), 0.0);
END$$
