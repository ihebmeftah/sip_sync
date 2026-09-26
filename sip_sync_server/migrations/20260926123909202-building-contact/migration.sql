BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION DROP TABLE
--
DROP TABLE "building" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "building" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "ownerId" uuid NOT NULL,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "address" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "openingMinutes" bigint NOT NULL,
    "closingMinutes" bigint NOT NULL,
    "currencyCode" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "countryCode" text NOT NULL,
    "whatsapp" text,
    "instagram" text,
    "facebook" text,
    "otherLinks" json NOT NULL,
    "tableMultiOrder" boolean NOT NULL,
    "allowAppendingItemsToOrder" boolean NOT NULL,
    "strictMode" boolean NOT NULL,
    "strictModeSteps" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "building_owner_idx" ON "building" USING btree ("ownerId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "building"
    ADD CONSTRAINT "building_fk_0"
    FOREIGN KEY("ownerId")
    REFERENCES "owner"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION RESTORE FOREIGN KEY
--
ALTER TABLE ONLY "employee"
    ADD CONSTRAINT "employee_fk_1"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "employee_access"
    ADD CONSTRAINT "employee_access_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ingredient"
    ADD CONSTRAINT "ingredient_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "menu_article"
    ADD CONSTRAINT "menu_article_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "menu_category"
    ADD CONSTRAINT "menu_category_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "venue_order"
    ADD CONSTRAINT "venue_order_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "venue_table"
    ADD CONSTRAINT "venue_table_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260926123909202-building-contact', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260926123909202-building-contact', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
