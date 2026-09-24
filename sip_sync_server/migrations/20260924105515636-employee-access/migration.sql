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
-- ACTION ALTER TABLE
--
ALTER TABLE "employee" ADD COLUMN "accessId" uuid;
CREATE INDEX "employee_access_idx" ON "employee" USING btree ("accessId");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "employee_access" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "name" text NOT NULL,
    "orderCreation" boolean NOT NULL DEFAULT false,
    "orderPayment" boolean NOT NULL DEFAULT false,
    "cancelOrder" boolean NOT NULL DEFAULT false,
    "preparation" boolean NOT NULL DEFAULT false,
    "serving" boolean NOT NULL DEFAULT false,
    "consultAllOrders" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "employee_access_building_name_idx" ON "employee_access" USING btree ("buildingId", "name");
CREATE INDEX "employee_access_building_idx" ON "employee_access" USING btree ("buildingId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "venue_order_item" ADD COLUMN "addedByType" text;
ALTER TABLE "venue_order_item" ADD COLUMN "addedById" uuid;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "employee"
    ADD CONSTRAINT "employee_fk_2"
    FOREIGN KEY("accessId")
    REFERENCES "employee_access"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "employee_access"
    ADD CONSTRAINT "employee_access_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260924105515636-employee-access', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105515636-employee-access', "timestamp" = now();

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
