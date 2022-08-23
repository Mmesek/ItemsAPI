CREATE OR REPLACE FUNCTION "add_transaction" 
    ("sender_id" bigint, "recipent_id" bigint, "instance_id" BIGINT, "quantity" real, 
    "required_instance_id" INT DEFAULT null, "required_quantity" real DEFAULT null
    ) 
    RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE
    _transaction_id bigint;
BEGIN
    INSERT INTO "Transaction" DEFAULT VALUES RETURNING id INTO _transaction_id;
    INSERT INTO "Transaction_Instances" (transaction_id, instance_id, quantity, recipent_id) VALUES (_transaction_id, instance_id, quantity, recipent_id);
    IF required_instance_id is not null THEN
        INSERT INTO "Transaction_Instances" (transaction_id, instance_id, quantity, sender_id) VALUES (_transaction_id, required_instance_id, required_quantity, sender_id);
    END IF;
RETURN _transaction_id;
END$$
