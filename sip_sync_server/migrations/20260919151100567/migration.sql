BEGIN;

--
-- Expand multi-quantity lines into one row per unit before dropping quantity.
--
INSERT INTO "venue_order_item" (
    "id",
    "orderId",
    "articleId",
    "articleName",
    "unitPrice",
    "quantity",   -- add this
    "status",
    "passedByType",
    "passedById",
    "paidToType",
    "paidToId",
    "preparedByType",
    "preparedById",
    "createdAt",
    "updatedAt",
    "preparedAt",
    "paidAt"
)
SELECT
    gen_random_uuid(),
    src."orderId",
    src."articleId",
    src."articleName",
    src."unitPrice",
    1,   
    src."status",
    src."passedByType",
    src."passedById",
    src."paidToType",
    src."paidToId",
    src."preparedByType",
    src."preparedById",
    src."createdAt",
    src."updatedAt",
    src."preparedAt",
    src."paidAt"
FROM "venue_order_item" AS src
CROSS JOIN LATERAL generate_series(2, src."quantity") AS gs(n)
WHERE src."quantity" > 1;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "venue_order_item" DROP COLUMN "quantity";

--
-- MIGRATION VERSION FOR sip_sync
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('sip_sync', '20260919151100567', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260919151100567', "timestamp" = now();

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
