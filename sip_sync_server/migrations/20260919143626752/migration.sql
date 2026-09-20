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
-- ACTION CREATE TABLE
--
CREATE TABLE "venue_order" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "venueTableId" uuid,
    "status" text NOT NULL,
    "launchedByType" text NOT NULL,
    "launchedById" uuid NOT NULL,
    "lastPaidByType" text,
    "lastPaidById" uuid,
    "lastPaidAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "venue_order_building_idx" ON "venue_order" USING btree ("buildingId");
CREATE INDEX "venue_order_building_status_idx" ON "venue_order" USING btree ("buildingId", "status");
CREATE INDEX "venue_order_table_idx" ON "venue_order" USING btree ("venueTableId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "venue_order_item" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "orderId" uuid NOT NULL,
    "articleId" uuid NOT NULL,
    "articleName" text NOT NULL,
    "unitPrice" double precision NOT NULL,
    "quantity" bigint NOT NULL,
    "status" text NOT NULL,
    "passedByType" text,
    "passedById" uuid,
    "paidToType" text,
    "paidToId" uuid,
    "preparedByType" text,
    "preparedById" uuid,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "preparedAt" timestamp without time zone,
    "paidAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "venue_order_item_order_idx" ON "venue_order_item" USING btree ("orderId");
CREATE INDEX "venue_order_item_article_idx" ON "venue_order_item" USING btree ("articleId");
CREATE INDEX "venue_order_item_status_idx" ON "venue_order_item" USING btree ("status");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "venue_order"
    ADD CONSTRAINT "venue_order_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "venue_order"
    ADD CONSTRAINT "venue_order_fk_1"
    FOREIGN KEY("venueTableId")
    REFERENCES "venue_table"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "venue_order_item"
    ADD CONSTRAINT "venue_order_item_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "venue_order"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "venue_order_item"
    ADD CONSTRAINT "venue_order_item_fk_1"
    FOREIGN KEY("articleId")
    REFERENCES "menu_article"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260919143626752', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919143626752', "timestamp" = now();

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
