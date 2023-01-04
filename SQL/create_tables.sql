CREATE schema "items"
-- ************************************** "items"."Character"

CREATE TABLE IF NOT EXISTS "items"."Character"
(
 "id" bigint NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 CONSTRAINT "PK_Character" PRIMARY KEY ( "id" )
)
WITH (
 USER_CATALOG_TABLE=TRUE
);

COMMENT ON TABLE "items"."Character" IS 'Basic information about Character';

COMMENT ON COLUMN "items"."Character"."id" IS 'Autogenerated ID of Character';

-- ************************************** "items"."Character_Attribute"

CREATE TABLE IF NOT EXISTS "items"."Character_Attribute"
(
 "character_id" bigint NOT NULL,
 "name"         character varying(50) NOT NULL,
 "value"        real NULL,
 "text"         text NULL,
 "id"           bigint NULL,
 "interval"     interval NULL,
 "timestamp"    timestamptz NULL,
 "bool"         boolean NULL,
 CONSTRAINT "PK_Character_Name" PRIMARY KEY ( "character_id", "name" ),
 CONSTRAINT "FK_Character_Attribute" FOREIGN KEY ( "character_id" ) REFERENCES "items"."Character" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Character_Attribute" ON "items"."Character_Attribute"
(
 "character_id"
);

COMMENT ON TABLE "items"."Character_Attribute" IS 'Attributes associated with Character';

COMMENT ON COLUMN "items"."Character_Attribute"."character_id" IS 'Character''s ID';
COMMENT ON COLUMN "items"."Character_Attribute"."name" IS 'Name of Character''s Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."value" IS 'Value of Character''s Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."text" IS 'Text of Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."id" IS 'External ID of Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."interval" IS 'Interval of Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."timestamp" IS 'Timestamp with Timezone of Attribute';
COMMENT ON COLUMN "items"."Character_Attribute"."bool" IS 'Boolean of Attribute';

-- ************************************** "public"."Owner"

CREATE TABLE IF NOT EXISTS "public"."Owner"
(
 "character_id" bigint NOT NULL,
 "server_id"    bigint NOT NULL,
 "user_id"      bigint NOT NULL,
 CONSTRAINT "PK_Character_Owner" PRIMARY KEY ( "character_id" ),
 CONSTRAINT "FK_Character_Owner" FOREIGN KEY ( "character_id" ) REFERENCES "items"."Character" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Character_Owner" ON "public"."Owner"
(
 "character_id"
);

COMMENT ON TABLE "public"."Owner" IS 'Owner association for Character';

COMMENT ON COLUMN "public"."Owner"."character_id" IS 'ID of Owned Character';
COMMENT ON COLUMN "public"."Owner"."server_id" IS 'ID of Associated Server';
COMMENT ON COLUMN "public"."Owner"."user_id" IS 'ID of Owning User';

-- ************************************** "items"."Item"

CREATE TABLE IF NOT EXISTS "items"."Item"
(
 "id" int NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 "name"     VARCHAR(50) NOT NULL,
 CONSTRAINT "PK_Item" PRIMARY KEY ( "id" )
);

COMMENT ON TABLE "items"."Item" IS 'Item metadata';
COMMENT ON COLUMN "items"."Item"."id" IS 'Autogenerated ID for this Item';
COMMENT ON COLUMN "items"."Item"."name" IS 'Base name for this Item';

-- ************************************** "items"."Item_Attribute"

CREATE TABLE IF NOT EXISTS "items"."Item_Attribute"
(
 "item_id"   int NOT NULL,
 "name"      character varying(50) NOT NULL,
 "value"     real NULL,
 "text"      text NULL,
 "id"        bigint NULL,
 "interval"  interval NULL,
 "timestamp" timestamptz NULL,
 "bool"      boolean NULL,
 CONSTRAINT "PK_ItemName" PRIMARY KEY ( "item_id", "name" ),
 CONSTRAINT "FK_Item_Attribute" FOREIGN KEY ( "item_id" ) REFERENCES "items"."Item" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Item_Attribute" ON "items"."Item_Attribute"
(
 "item_id"
);

COMMENT ON TABLE "items"."Item_Attribute" IS 'Attributes associated with Item';

COMMENT ON COLUMN "items"."Item_Attribute"."item_id" IS 'Item''s ID';
COMMENT ON COLUMN "items"."Item_Attribute"."name" IS 'Name of Item''s Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."value" IS 'Value of Item''s Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."text" IS 'Text of Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."id" IS 'External ID of Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."interval" IS 'Interval of Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."timestamp" IS 'Timestamp with Timezone of Attribute';
COMMENT ON COLUMN "items"."Item_Attribute"."bool" IS 'Boolean of Attribute';
-- ************************************** "items"."Location"

CREATE TABLE IF NOT EXISTS "items"."Location"
(
 "id"          int NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 "name"        text NOT NULL,
 "description" text NOT NULL,
 CONSTRAINT "PK_Location" PRIMARY KEY ( "id" )
);

COMMENT ON TABLE "items"."Location" IS 'Location metadata';
COMMENT ON COLUMN "items"."Location"."id" IS 'Autogenerated ID of this Location';
COMMENT ON COLUMN "items"."Location"."name" IS 'Name of this Location';
COMMENT ON COLUMN "items"."Location"."description" IS 'Description of this Location';

-- ************************************** "items"."Location_Attribute"

CREATE TABLE IF NOT EXISTS "items"."Location_Attribute"
(
 "location_id" int NOT NULL,
 "name"        character varying(50) NOT NULL,
 "value"       real NULL,
 "text"        text NULL,
 "id"          bigint NULL,
 "interval"    interval NULL,
 "timestamp"   timestamptz NULL,
 "bool"        boolean NULL,
 CONSTRAINT "PK_Location_Name" PRIMARY KEY ( "location_id", "name" ),
 CONSTRAINT "FK_Location_Attribute" FOREIGN KEY ( "location_id" ) REFERENCES "items"."Location" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Location_Attribute" ON "items"."Location_Attribute"
(
 "location_id"
);

COMMENT ON TABLE "items"."Location_Attribute" IS 'Attributes associated with Location';

COMMENT ON COLUMN "items"."Location_Attribute"."location_id" IS 'Location''s ID';
COMMENT ON COLUMN "items"."Location_Attribute"."name" IS 'Name of Location''s Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."value" IS 'Value of Location''s Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."text" IS 'Text of Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."id" IS 'External ID of Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."interval" IS 'Interval of Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."timestamp" IS 'Timestamp with Timezone of Attribute';
COMMENT ON COLUMN "items"."Location_Attribute"."bool" IS 'Boolean of Attribute';
-- ************************************** "items"."Event"

CREATE TABLE IF NOT EXISTS "items"."Event"
(
 "id"          int NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 "name"        text NOT NULL,
 "description" text NOT NULL,
 "start_date"  timestamptz NOT NULL,
 "end_date"    timestamptz NOT NULL,
 CONSTRAINT "PK_Event" PRIMARY KEY ( "id" )
);

COMMENT ON TABLE "items"."Event" IS 'Event metadata';
COMMENT ON COLUMN "items"."Event"."id" IS 'Autogenerated ID of this Event';
COMMENT ON COLUMN "items"."Event"."name" IS 'Name of this Event';
COMMENT ON COLUMN "items"."Event"."description" IS 'Description of this Event';
COMMENT ON COLUMN "items"."Event"."start_date" IS 'Timestamp of start of this Event';
COMMENT ON COLUMN "items"."Event"."end_date" IS 'Timestamp of end of this Event';

-- ************************************** "items"."Event_Attribute"

CREATE TABLE IF NOT EXISTS "items"."Event_Attribute"
(
 "event_id"  int NOT NULL,
 "name"      character varying(50) NOT NULL,
 "value"     real NULL,
 "text"      text NULL,
 "id"        bigint NULL,
 "interval"  interval NULL,
 "timestamp" timestamptz NULL,
 "bool"      boolean NULL,
 CONSTRAINT "PK_Event_Name" PRIMARY KEY ( "event_id", "name" ),
 CONSTRAINT "FK_Event_Attribute" FOREIGN KEY ( "event_id" ) REFERENCES "items"."Event" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Event_Attribute" ON "items"."Event_Attribute"
(
 "event_id"
);

COMMENT ON TABLE "items"."Event_Attribute" IS 'Attributes associated with Event';

COMMENT ON COLUMN "items"."Event_Attribute"."event_id" IS 'Event''s ID';
COMMENT ON COLUMN "items"."Event_Attribute"."name" IS 'Name of Event''s Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."value" IS 'Value of Event''s Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."text" IS 'Text of Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."id" IS 'External ID of Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."interval" IS 'Interval of Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."timestamp" IS 'Timestamp with Timezone of Attribute';
COMMENT ON COLUMN "items"."Event_Attribute"."bool" IS 'Boolean of Attribute';
-- ************************************** "items"."Instance"

CREATE TABLE IF NOT EXISTS "items"."Instance"
(
 "id"          bigint NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 "name"        VARCHAR(50) NOT NULL,
 "item_id"     int NOT NULL,
 "location_id" int NULL,
 "event_id"    int NULL,
 CONSTRAINT "PK_Instance" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_Event_Instance" FOREIGN KEY ( "event_id" ) REFERENCES "items"."Event" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT "FK_Item_Instance" FOREIGN KEY ( "item_id" ) REFERENCES "items"."Item" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT "FK_Location_Instance" FOREIGN KEY ( "location_id" ) REFERENCES "items"."Location" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Event_Instance" ON "items"."Instance"
(
 "event_id"
);

CREATE INDEX "FK_Item_Instance" ON "items"."Instance"
(
 "item_id"
);

CREATE INDEX "FK_Location_Instance" ON "items"."Instance"
(
 "location_id"
);

COMMENT ON TABLE "items"."Instance" IS 'Instance metadata';
COMMENT ON COLUMN "items"."Instance"."id" IS 'Autogenerated ID of this Instance';
COMMENT ON COLUMN "items"."Instance"."name" IS 'Name of Instantiated Item';
COMMENT ON COLUMN "items"."Instance"."item_id" IS 'ID of Item this Instance is based on';
COMMENT ON COLUMN "items"."Instance"."location_id" IS 'ID of Locatin this Instance is related to';
COMMENT ON COLUMN "items"."Instance"."event_id" IS 'ID of Event this Instance is related to';

-- ************************************** "items"."Instance_Attribute"

CREATE TABLE IF NOT EXISTS "items"."Instance_Attribute"
(
 "instance_id" bigint NOT NULL,
 "name"        character varying(50) NOT NULL,
 "value"       real NULL,
 "text"        text NULL,
 "id"          bigint NULL,
 "interval"    interval NULL,
 "timestamp"   timestamptz NULL,
 "bool"        boolean NULL,
 CONSTRAINT "PK_Instance_Name" PRIMARY KEY ( "name" ),
 CONSTRAINT "FK_Instance_Attribute" FOREIGN KEY ( "instance_id" ) REFERENCES "items"."Instance" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Instance_Attribute" ON "items"."Instance_Attribute"
(
 "instance_id"
);

COMMENT ON TABLE "items"."Instance_Attribute" IS 'Attributes associated with Instance';
COMMENT ON COLUMN "items"."Instance_Attribute"."instance_id" IS 'Instance''s ID';
COMMENT ON COLUMN "items"."Instance_Attribute"."name" IS 'Name of Instance''s Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."value" IS 'Value of Instance''s Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."text" IS 'Text of Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."id" IS 'External ID of Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."interval" IS 'Interval of Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."timestamp" IS 'Timestamp with Timezone of Attribute';
COMMENT ON COLUMN "items"."Instance_Attribute"."bool" IS 'Boolean of Attribute';

-- ************************************** "items"."Transaction"

CREATE TABLE IF NOT EXISTS "items"."Transaction"
(
 "id"        bigint NOT NULL GENERATED ALWAYS AS IDENTITY (
 start 1
 ),
 "timestamp" timestamptz NOT NULL DEFAULT now(),
 CONSTRAINT "PK_Transaction" PRIMARY KEY ( "id" )
);

COMMENT ON TABLE "items"."Transaction" IS 'Transaction metadata';

COMMENT ON COLUMN "items"."Transaction"."id" IS 'Autogenerated ID of this Transaction';
COMMENT ON COLUMN "items"."Transaction"."timestamp" IS 'When this transaction happened';

-- ************************************** "items"."Transaction_Instances"

CREATE TABLE IF NOT EXISTS "items"."Transaction_Instances"
(
 "transaction_id" bigint NOT NULL,
 "instance_id"    bigint NOT NULL,
 "quantity"       real NOT NULL DEFAULT 1,
 "character_id"   bigint NOT NULL,
 CONSTRAINT "PK_Transaction_Instance" PRIMARY KEY ( "transaction_id", "instance_id", "character_id" ),
 CONSTRAINT "FK_Instance" FOREIGN KEY ( "instance_id" ) REFERENCES "items"."Instance" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT "FK_Character" FOREIGN KEY ( "character_id" ) REFERENCES "items"."Character" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT "FK_Transaction" FOREIGN KEY ( "transaction_id" ) REFERENCES "items"."Transaction" ( "id" ) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX "FK_Instance" ON "items"."Transaction_Instances"
(
 "instance_id"
);

CREATE INDEX "FK_Character" ON "items"."Transaction_Instances"
(
 "character_id"
);

CREATE INDEX "FK_Transaction" ON "items"."Transaction_Instances"
(
 "transaction_id"
);

COMMENT ON TABLE "items"."Transaction_Instances" IS 'Transaction Instances';

COMMENT ON COLUMN "items"."Transaction_Instances"."transaction_id" IS 'ID of transaction';
COMMENT ON COLUMN "items"."Transaction_Instances"."instance_id" IS 'ID of an instance being transferred';
COMMENT ON COLUMN "items"."Transaction_Instances"."quantity" IS 'Amount being transferred';

COMMENT ON COLUMN "items"."Transaction_Instances"."character_id" IS 'ID of affected Character';
