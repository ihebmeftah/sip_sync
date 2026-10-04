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
CREATE TABLE "building_pack_assignment" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "packId" uuid NOT NULL,
    "billingPeriod" text,
    "startedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "endedAt" timestamp without time zone,
    "endReason" text
);

-- Indexes
CREATE INDEX "building_pack_assignment_building_idx" ON "building_pack_assignment" USING btree ("buildingId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "building_pack_assignment"
    ADD CONSTRAINT "building_pack_assignment_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "building_pack_assignment"
    ADD CONSTRAINT "building_pack_assignment_fk_1"
    FOREIGN KEY("packId")
    REFERENCES "pack"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

-- One open row for every venue that already has a plan.
INSERT INTO "building_pack_assignment" (
    "id",
    "buildingId",
    "packId",
    "billingPeriod",
    "startedAt",
    "expiresAt"
)
SELECT
    gen_random_uuid_v7(),
    "id",
    "packId",
    "packBillingPeriod",
    "createdAt",
    "packExpiresAt"
FROM "building";


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20261004145143810-building-pack-history', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004145143810-building-pack-history', "timestamp" = now();

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
