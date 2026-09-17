BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "building_staff" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "employee_record" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "employee_record" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "ownerAuthUserId" uuid NOT NULL,
    "buildingId" uuid NOT NULL,
    "isEnabled" boolean NOT NULL DEFAULT true
);

-- Indexes
CREATE UNIQUE INDEX "employee_record_auth_user_idx" ON "employee_record" USING btree ("authUserId");
CREATE INDEX "employee_record_owner_idx" ON "employee_record" USING btree ("ownerAuthUserId");
CREATE INDEX "employee_record_building_idx" ON "employee_record" USING btree ("buildingId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "employee_record"
    ADD CONSTRAINT "employee_record_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "employee_record"
    ADD CONSTRAINT "employee_record_fk_1"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260917211320947', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260917211320947', "timestamp" = now();

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
