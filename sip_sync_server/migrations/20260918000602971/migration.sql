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
CREATE TABLE "menu_article" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "categoryId" uuid NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "price" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "menu_article_building_name_idx" ON "menu_article" USING btree ("buildingId", "name");
CREATE INDEX "menu_article_building_idx" ON "menu_article" USING btree ("buildingId");
CREATE INDEX "menu_article_category_idx" ON "menu_article" USING btree ("categoryId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "menu_category" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "buildingId" uuid NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "menu_category_building_name_idx" ON "menu_category" USING btree ("buildingId", "name");
CREATE INDEX "menu_category_building_idx" ON "menu_category" USING btree ("buildingId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "menu_article"
    ADD CONSTRAINT "menu_article_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "menu_article"
    ADD CONSTRAINT "menu_article_fk_1"
    FOREIGN KEY("categoryId")
    REFERENCES "menu_category"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "menu_category"
    ADD CONSTRAINT "menu_category_fk_0"
    FOREIGN KEY("buildingId")
    REFERENCES "building"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260918000602971', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918000602971', "timestamp" = now();

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
