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
ALTER TABLE "building" ADD COLUMN "cashRegisterEnabled" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "cash_register_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "status" text NOT NULL,
    "openedByType" text NOT NULL,
    "openedById" uuid NOT NULL,
    "openedAt" timestamp without time zone NOT NULL,
    "closedByType" text,
    "closedById" uuid,
    "closedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "cash_register_session_building_idx" ON "cash_register_session" USING btree ("buildingId");
CREATE INDEX "cash_register_session_building_status_idx" ON "cash_register_session" USING btree ("buildingId", "status");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "employee_access" ADD COLUMN "cashRegister" boolean NOT NULL DEFAULT false;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pack" ADD COLUMN "cashRegister" boolean NOT NULL DEFAULT false;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "venue_order" ADD COLUMN "cashRegisterSessionId" uuid;
CREATE INDEX "venue_order_cash_register_idx" ON "venue_order" USING btree ("cashRegisterSessionId");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "cash_register_session"
    ADD CONSTRAINT "cash_register_session_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "venue_order"
    ADD CONSTRAINT "venue_order_fk_2"
    FOREIGN KEY("cashRegisterSessionId")
    REFERENCES "cash_register_session"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

-- Existing paid plans include the cash register. Free stays off.
UPDATE "pack" SET "cashRegister" = true WHERE "code" IN ('counter', 'floor', 'house', 'group');

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20261014165940305-cash-register', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014165940305-cash-register', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
