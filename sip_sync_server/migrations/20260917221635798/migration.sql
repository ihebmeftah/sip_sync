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
DROP TABLE "user_role_membership" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "sip_sync_profile" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "employee_record" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "backoffice_staff" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "auth_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "actorType" text NOT NULL,
    "actorId" uuid NOT NULL,
    "tokenHash" text NOT NULL,
    "refreshTokenHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "auth_session_token_idx" ON "auth_session" USING btree ("tokenHash");
CREATE UNIQUE INDEX "auth_session_refresh_idx" ON "auth_session" USING btree ("refreshTokenHash");
CREATE INDEX "auth_session_actor_idx" ON "auth_session" USING btree ("actorType", "actorId");

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
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "building_owner_idx" ON "building" USING btree ("ownerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customer" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "email" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "passwordHash" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "customer_email_idx" ON "customer" USING btree ("email");
CREATE UNIQUE INDEX "customer_phone_idx" ON "customer" USING btree ("phoneNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "employee" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "ownerId" uuid NOT NULL,
    "buildingId" uuid NOT NULL,
    "username" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "passwordHash" text NOT NULL,
    "isEnabled" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "employee_username_idx" ON "employee" USING btree ("username");
CREATE UNIQUE INDEX "employee_phone_idx" ON "employee" USING btree ("phoneNumber");
CREATE INDEX "employee_building_idx" ON "employee" USING btree ("buildingId");
CREATE INDEX "employee_owner_idx" ON "employee" USING btree ("ownerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "owner" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "email" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "passwordHash" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "owner_email_idx" ON "owner" USING btree ("email");
CREATE UNIQUE INDEX "owner_phone_idx" ON "owner" USING btree ("phoneNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "super_admin" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "email" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "passwordHash" text NOT NULL,
    "isSystemDefault" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "super_admin_email_idx" ON "super_admin" USING btree ("email");
CREATE UNIQUE INDEX "super_admin_phone_idx" ON "super_admin" USING btree ("phoneNumber");

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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "employee"
    ADD CONSTRAINT "employee_fk_0"
    FOREIGN KEY("ownerId")
    REFERENCES "owner"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "employee"
    ADD CONSTRAINT "employee_fk_1"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260917221635798', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260917221635798', "timestamp" = now();

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
