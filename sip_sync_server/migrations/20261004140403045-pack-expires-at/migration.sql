BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "building" ADD COLUMN "packBillingPeriod" text;
ALTER TABLE "building" ADD COLUMN "packExpiresAt" timestamp without time zone;
CREATE INDEX "building_pack_expires_idx" ON "building" USING btree ("packExpiresAt");

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20261004140403045-pack-expires-at', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004140403045-pack-expires-at', "timestamp" = now();

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
