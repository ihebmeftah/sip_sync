BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "backoffice_staff" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "isAdmin" boolean NOT NULL DEFAULT false,
    "isSystemDefault" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE UNIQUE INDEX "backoffice_staff_auth_user_idx" ON "backoffice_staff" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "employee_record" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "ownerAuthUserId" uuid NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "employee_record_auth_user_idx" ON "employee_record" USING btree ("authUserId");
CREATE INDEX "employee_record_owner_idx" ON "employee_record" USING btree ("ownerAuthUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "sip_sync_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "username" text NOT NULL,
    "email" text NOT NULL,
    "phoneNumber" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "sip_sync_profile_auth_user_idx" ON "sip_sync_profile" USING btree ("authUserId");
CREATE UNIQUE INDEX "sip_sync_profile_username_idx" ON "sip_sync_profile" USING btree ("username");
CREATE UNIQUE INDEX "sip_sync_profile_email_idx" ON "sip_sync_profile" USING btree ("email");
CREATE UNIQUE INDEX "sip_sync_profile_phone_idx" ON "sip_sync_profile" USING btree ("phoneNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_role_membership" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_role_membership_auth_role_idx" ON "user_role_membership" USING btree ("authUserId", "role");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "backoffice_staff"
    ADD CONSTRAINT "backoffice_staff_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "employee_record"
    ADD CONSTRAINT "employee_record_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "sip_sync_profile"
    ADD CONSTRAINT "sip_sync_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_role_membership"
    ADD CONSTRAINT "user_role_membership_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260916173647826-auth', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260916173647826-auth', "timestamp" = now();

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
