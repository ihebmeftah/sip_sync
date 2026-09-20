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
-- ACTION ALTER TABLE — non-destructive: add strictMode + strictModeSteps
--
ALTER TABLE "building"
    ADD COLUMN "strictMode" boolean;
ALTER TABLE "building"
    ADD COLUMN "strictModeSteps" json;
UPDATE "building"
    SET "strictMode" = false
    WHERE "strictMode" IS NULL;
UPDATE "building"
    SET "strictModeSteps" = '[
      {"rank":1,"status":"picked","enabled":true},
      {"rank":2,"status":"ready","enabled":true},
      {"rank":3,"status":"served","enabled":true},
      {"rank":4,"status":"payed","enabled":true}
    ]'::json
    WHERE "strictModeSteps" IS NULL;
ALTER TABLE "building"
    ALTER COLUMN "strictMode" SET NOT NULL;
ALTER TABLE "building"
    ALTER COLUMN "strictModeSteps" SET NOT NULL;

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260920161204567', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260920161204567', "timestamp" = now();

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
