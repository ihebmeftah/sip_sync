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
ALTER TABLE "building" ADD COLUMN "reservationFee" double precision NOT NULL DEFAULT 0;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "employee_access" ADD COLUMN "reservations" boolean NOT NULL DEFAULT false;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "pack" ADD COLUMN "reservations" boolean NOT NULL DEFAULT false;
ALTER TABLE "pack" ADD COLUMN "maxReservationsPerDay" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "reservation" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "customerId" uuid,
    "guestName" text NOT NULL,
    "guestPhone" text,
    "paidAmount" double precision NOT NULL DEFAULT 0,
    "status" text NOT NULL,
    "createdByType" text NOT NULL,
    "createdById" uuid NOT NULL,
    "confirmedAt" timestamp without time zone,
    "confirmedById" uuid,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "reservation_building_start_idx" ON "reservation" USING btree ("buildingId", "startsAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "table_reservation" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "reservationId" uuid NOT NULL,
    "venueTableId" uuid NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "table_reservation_pair_idx" ON "table_reservation" USING btree ("reservationId", "venueTableId");
CREATE INDEX "table_reservation_venue_idx" ON "table_reservation" USING btree ("venueTableId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_1"
    FOREIGN KEY("customerId")
    REFERENCES "customer"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "table_reservation"
    ADD CONSTRAINT "table_reservation_fk_0"
    FOREIGN KEY("reservationId")
    REFERENCES "reservation"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "table_reservation"
    ADD CONSTRAINT "table_reservation_fk_1"
    FOREIGN KEY("venueTableId")
    REFERENCES "venue_table"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

-- Existing catalogs were seeded before these columns. Defaults leave every
-- pack off, so turn the launch plans on and give Gerant the new flag.
UPDATE "pack" SET "reservations" = true, "maxReservationsPerDay" = 8 WHERE "code" = 'counter';
UPDATE "pack" SET "reservations" = true, "maxReservationsPerDay" = 30 WHERE "code" = 'floor';
UPDATE "pack" SET "reservations" = true, "maxReservationsPerDay" = NULL WHERE "code" IN ('house', 'group');
UPDATE "employee_access" SET "reservations" = true WHERE "name" = 'Gerant';

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20261005193049146-reservations', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005193049146-reservations', "timestamp" = now();

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
