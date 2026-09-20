BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "venue_order" ADD COLUMN "cancelledByType" text;
ALTER TABLE "venue_order" ADD COLUMN "cancelledById" uuid;
ALTER TABLE "venue_order" ADD COLUMN "cancelledAt" timestamp without time zone;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "venue_order_item" ADD COLUMN "cancelledByType" text;
ALTER TABLE "venue_order_item" ADD COLUMN "cancelledById" uuid;
ALTER TABLE "venue_order_item" ADD COLUMN "cancelledAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260919163839895', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919163839895', "timestamp" = now();

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
