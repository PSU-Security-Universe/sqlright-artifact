CREATE TABLE guid1(	guid_field UUID,	text_field TEXT DEFAULT(now()));
CREATE TABLE guid2(	guid_field UUID,	text_field TEXT DEFAULT(now()));
INSERT INTO guid1(guid_field) VALUES('11111111-1111-1111-1111-111111111111F');
INSERT INTO guid1(guid_field) VALUES('{11111111-1111-1111-1111-11111111111}');
INSERT INTO guid1(guid_field) VALUES('111-11111-1111-1111-1111-111111111111');
INSERT INTO guid1(guid_field) VALUES('{22222222-2222-2222-2222-222222222222 ');
INSERT INTO guid1(guid_field) VALUES('11111111-1111-1111-G111-111111111111');
INSERT INTO guid1(guid_field) VALUES('11+11111-1111-1111-1111-111111111111');
INSERT INTO guid1(guid_field) VALUES('11111111-1111-1111-1111-111111111111');
INSERT INTO guid1(guid_field) VALUES('{22222222-2222-2222-2222-222222222222}');
INSERT INTO guid1(guid_field) VALUES('3f3e3c3b3a3039383736353433a2313e');
SELECT guid_field FROM guid1;
SELECT guid_field FROM guid1 ORDER BY guid_field ASC;
SELECT guid_field FROM guid1 ORDER BY guid_field DESC;
SELECT COUNT(*) FROM guid1 WHERE guid_field = '3f3e3c3b-3a30-3938-3736-353433a2313e';
SELECT COUNT(*) FROM guid1 WHERE guid_field <> '11111111111111111111111111111111';
SELECT COUNT(*) FROM guid1 WHERE guid_field < '22222222-2222-2222-2222-222222222222';
SELECT COUNT(*) FROM guid1 WHERE guid_field <= '22222222-2222-2222-2222-222222222222';
SELECT COUNT(*) FROM guid1 WHERE guid_field > '22222222-2222-2222-2222-222222222222';
SELECT COUNT(*) FROM guid1 WHERE guid_field >= '22222222-2222-2222-2222-222222222222';
CREATE INDEX guid1_btree ON guid1 USING BTREE (guid_field);
CREATE INDEX guid1_hash  ON guid1 USING HASH  (guid_field);
CREATE UNIQUE INDEX guid1_unique_BTREE ON guid1 USING BTREE (guid_field);
INSERT INTO guid1(guid_field) VALUES('11111111-1111-1111-1111-111111111111');
SELECT count(*) FROM pg_class WHERE relkind='i' AND relname LIKE 'guid%';
INSERT INTO guid1(guid_field) VALUES('44444444-4444-4444-4444-444444444444');
INSERT INTO guid2(guid_field) VALUES('11111111-1111-1111-1111-111111111111');
INSERT INTO guid2(guid_field) VALUES('{22222222-2222-2222-2222-222222222222}');
INSERT INTO guid2(guid_field) VALUES('3f3e3c3b3a3039383736353433a2313e');
SELECT COUNT(*) FROM guid1 g1 INNER JOIN guid2 g2 ON g1.guid_field = g2.guid_field;
SELECT COUNT(*) FROM guid1 g1 LEFT JOIN guid2 g2 ON g1.guid_field = g2.guid_field WHERE g2.guid_field IS NULL;
TRUNCATE guid1;
INSERT INTO guid1 (guid_field) VALUES (gen_random_uuid());
INSERT INTO guid1 (guid_field) VALUES (gen_random_uuid());
SELECT count(DISTINCT guid_field) FROM guid1;
DROP TABLE guid1, guid2 CASCADE;
