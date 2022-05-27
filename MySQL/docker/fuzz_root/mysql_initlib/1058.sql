RESET MASTER;
CREATE FUNCTION GTID_IS_EQUAL(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT) RETURNS INT RETURN GTID_SUBSET(gtid_set_1, gtid_set_2) AND GTID_SUBSET(gtid_set_2, gtid_set_1);
CREATE FUNCTION GTID_IS_DISJOINT(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT) RETURNS INT RETURN GTID_SUBSET(gtid_set_1, GTID_SUBTRACT(gtid_set_1, gtid_set_2));
CREATE FUNCTION GTID_IS_DISJOINT_UNION(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT, sum LONGTEXT) RETURNS INT RETURN GTID_IS_EQUAL(GTID_SUBTRACT(sum, gtid_set_1), gtid_set_2) AND GTID_IS_EQUAL(GTID_SUBTRACT(sum, gtid_set_2), gtid_set_1);
CREATE FUNCTION GTID_NORMALIZE(g LONGTEXT) RETURNS LONGTEXT RETURN GTID_SUBTRACT(g, '');
CREATE FUNCTION GTID_UNION(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT) RETURNS LONGTEXT RETURN GTID_NORMALIZE(CONCAT(gtid_set_1, ',', gtid_set_2));
CREATE FUNCTION GTID_INTERSECTION(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT) RETURNS LONGTEXT RETURN GTID_SUBTRACT(gtid_set_1, GTID_SUBTRACT(gtid_set_1, gtid_set_2));
CREATE FUNCTION GTID_SYMMETRIC_DIFFERENCE(gtid_set_1 LONGTEXT, gtid_set_2 LONGTEXT) RETURNS LONGTEXT RETURN GTID_SUBTRACT(CONCAT(gtid_set_1, ',', gtid_set_2), GTID_INTERSECTION(gtid_set_1, gtid_set_2));
CREATE FUNCTION GTID_SUBTRACT_UUID(gtid_set LONGTEXT, uuid TEXT) RETURNS LONGTEXT RETURN GTID_SUBTRACT(gtid_set, CONCAT(UUID, ':1-', (1 << 63) - 2));
CREATE FUNCTION GTID_INTERSECTION_WITH_UUID(gtid_set LONGTEXT, uuid TEXT) RETURNS LONGTEXT RETURN GTID_SUBTRACT(gtid_set, GTID_SUBTRACT_UUID(gtid_set, uuid));
CREATE FUNCTION IFZERO(a INT, b INT) RETURNS INT RETURN IF(a = 0, b, a);
CREATE FUNCTION LOCATE2(needle LONGTEXT, haystack LONGTEXT, offset INT) RETURNS INT RETURN IFZERO(LOCATE(needle, haystack, offset), LENGTH(haystack) + 1);
CREATE FUNCTION GTID_FROM_GTID_SET(gtid_set LONGTEXT) RETURNS LONGTEXT BEGIN DECLARE normalized LONGTEXT DEFAULT GTID_NORMALIZE(gtid_set); DECLARE end_of_number INT DEFAULT LEAST(LOCATE2('-', normalized, 38), LOCATE2(':', normalized, 38), LOCATE2(',', normalized, 38)); RETURN SUBSTR(normalized, 1, end_of_number - 1); END;
CREATE FUNCTION GTID_NEXT_GENERATED_MULTIPLE(gtid_set LONGTEXT, uuid TEXT, count INT) RETURNS LONGTEXT BEGIN DECLARE result LONGTEXT DEFAULT ''; DECLARE number INT; DECLARE new_gtid LONGTEXT; WHILE count > 0 DO SET new_gtid = CONCAT(uuid, ':', GTID_NEXT_GENERATED(gtid_set, uuid)); SET result = GTID_UNION(result, new_gtid); SET gtid_set = GTID_UNION(gtid_set, new_gtid); SET count = count - 1; END WHILE; RETURN result; END;
CREATE FUNCTION GTID_COMPARE(old LONGTEXT, diff LONGTEXT, new LONGTEXT) RETURNS LONGTEXT RETURN IF(SUBSTR(diff, 1, 1) != '~', GTID_IS_DISJOINT_UNION(old, GTID_NEXT_GENERATED_SET(old, diff), new), GTID_IS_DISJOINT_UNION(new, GTID_NEXT_GENERATED_SET(old, SUBSTR(diff, 2)), old));
CREATE FUNCTION GTID_EXECUTED_FROM_TABLE() RETURNS LONGTEXT BEGIN DECLARE old_group_concat_max_len INT DEFAULT @@SESSION.GROUP_CONCAT_MAX_LEN; DECLARE tmp LONGTEXT; SET @@SESSION.GROUP_CONCAT_MAX_LEN = 100000; SELECT GROUP_CONCAT(CONCAT(source_uuid, ':', interval_start, '-', interval_end) SEPARATOR ',') FROM mysql.gtid_executed INTO tmp; SET @@SESSION.GROUP_CONCAT_MAX_LEN = old_group_concat_max_len; RETURN GTID_NORMALIZE(tmp); END;
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:1';
CREATE TABLE t1( i INT) engine=INNODB;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:2';
INSERT INTO t1 VALUES (12);
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:3';
INSERT INTO t1 SELECT * FROM t1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:4';
UPDATE t1 SET i=13 WHERE i=12;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:5';
DELETE FROM t1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:6';
ALTER TABLE t1 ADD COLUMN other_column INT;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:7';
CREATE INDEX t_index ON t1(i);
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:8';
DROP INDEX t_index ON t1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:9';
RENAME TABLE t1 TO t2;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:10';
DROP TABLE t2;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:11';
CREATE TEMPORARY TABLE t1(i INT);
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:12';
DROP TEMPORARY TABLE t1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:13';
CREATE VIEW v1 as SELECT 1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:14';
DROP VIEW v1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:15';
CREATE USER user1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:16';
ALTER USER user1 IDENTIFIED BY 'passwd';
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:17';
GRANT ALL ON *.* TO user1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:18';
REVOKE ALL PRIVILEGES ON *.* FROM user1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:19';
DROP USER user1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:20';
CREATE DATABASE db1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:21';
ALTER DATABASE db1 DEFAULT CHARACTER SET utf8;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:22';
DROP DATABASE db1;
FLUSH LOGS;
SELECT GTID_EXECUTED_FROM_TABLE();
CREATE TABLE t1(dt DATETIME) engine=INNODB;
SET SESSION GTID_NEXT='6f7f15bf-6c05-11ec-9c0b-70b5e8ec31dc:23';
INSERT INTO t1 VALUES (CONVERT_TZ('2015-07-01 01:00:00', 'UTC', 'No-such-time-zone'));
SET SESSION GTID_NEXT='AUTOMATIC';
DROP TABLE t1;
DROP FUNCTION GTID_IS_EQUAL;
DROP FUNCTION GTID_IS_DISJOINT;
DROP FUNCTION GTID_IS_DISJOINT_UNION;
DROP FUNCTION GTID_NORMALIZE;
DROP FUNCTION GTID_UNION;
DROP FUNCTION GTID_INTERSECTION;
DROP FUNCTION GTID_SYMMETRIC_DIFFERENCE;
DROP FUNCTION GTID_SUBTRACT_UUID;
DROP FUNCTION GTID_INTERSECTION_WITH_UUID;
DROP FUNCTION IFZERO;
DROP FUNCTION LOCATE2;
DROP FUNCTION GTID_COUNT;