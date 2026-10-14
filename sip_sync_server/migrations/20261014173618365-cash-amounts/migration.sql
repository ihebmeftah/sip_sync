BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "cash_register_session" ADD COLUMN "startCash" double precision;
ALTER TABLE "cash_register_session" ADD COLUMN "endCash" double precision;

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20261014173618365-cash-amounts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261014173618365-cash-amounts', "timestamp" = now();

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
