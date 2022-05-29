SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE all_types;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE all_types UPDATE HISTOGRAM ON col_bool, col_bit, col_tinyint, col_smallint, col_mediumint, col_integer, col_bigint, col_tinyint_unsigned, col_smallint_unsigned, col_mediumint_unsigned, col_integer_unsigned, col_bigint_unsigned, col_float, col_double, col_decimal, col_date, col_time, col_year, col_datetime, col_timestamp, col_char, col_varchar, col_tinytext, col_text, col_mediumtext, col_longtext, col_binary, col_varbinary, col_tinyblob, col_blob, col_mediumblob, col_longblob, col_enum, col_set WITH 1024 BUCKETS;
SELECT schema_name, table_name, column_name, JSON_REMOVE(histogram, '$."last-updated"') FROM information_schema.COLUMN_STATISTICS;
DROP TABLE all_types;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE unsupported_types (col_geometry GEOMETRY, col_point POINT, col_linestring LINESTRING, col_polygon POLYGON, col_multipoint MULTIPOINT, col_multilinestring MULTILINESTRING, col_multipolygon MULTIPOLYGON, col_geometrycollection GEOMETRYCOLLECTION, col_json JSON);
ANALYZE TABLE unsupported_types UPDATE HISTOGRAM ON col_geometry, col_point, col_linestring, col_polygon, col_multipoint, col_multilinestring, col_multipolygon, col_geometrycollection, col_json WITH 100 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
DROP TABLE unsupported_types;
CREATE TABLE t1 (col_integer INT);
ANALYZE TABLE t1 UPDATE HISTOGRAM ON foobar WITH 100 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE foobar UPDATE HISTOGRAM ON foobar WITH 100 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TEMPORARY TABLE temp_table (col1 INT);
ANALYZE TABLE temp_table UPDATE HISTOGRAM ON col1 WITH 100 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
DROP TABLE temp_table;
CREATE VIEW my_view AS SELECT * FROM t1;
ANALYZE TABLE my_view UPDATE HISTOGRAM ON col_integer WITH 100 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
DROP VIEW my_view;
ALTER TABLE t1 ADD COLUMN virtual_generated INT AS (col_integer + 10) VIRTUAL, ADD COLUMN stored_generated INT AS (col_integer + 20) STORED;
INSERT INTO t1 (col_integer) VALUES (10), (20), (30);
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col_integer, virtual_generated, stored_generated WITH 100 BUCKETS;
SELECT schema_name, table_name, column_name, JSON_REMOVE(histogram, '$."last-updated"') FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 DROP COLUMN virtual_generated, DROP COLUMN stored_generated;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
DELETE FROM t1;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col_integer WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name, JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_singleton FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col_integer WITH 9 BUCKETS;
SELECT schema_name, table_name, column_name, JSON_EXTRACT(histogram, '$."histogram-type"') AS should_be_equiheight FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
ANALYZE TABLE foo UPDATE HISTOGRAM ON foo WITH 0 BUCKETS;
ANALYZE TABLE foo UPDATE HISTOGRAM ON foo WITH 1025 BUCKETS;
ANALYZE TABLE foo, foo2 UPDATE HISTOGRAM ON bar WITH 100 BUCKETS;
CREATE TABLE t1 (col1 INT PRIMARY KEY, col2 INT, col3 INT, UNIQUE INDEX index_1 (col2), UNIQUE INDEX index_2 (col3, col2));
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1, col2, col3 WITH 100 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE t1 ALTER INDEX index_1 INVISIBLE;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col2 WITH 100 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 SELECT 1;
INSERT INTO t1 SELECT col1 + 1 FROM t1;
INSERT INTO t1 SELECT col1 + 2 FROM t1;
INSERT INTO t1 SELECT col1 + 4 FROM t1;
INSERT INTO t1 SELECT col1 + 8 FROM t1;
INSERT INTO t1 SELECT col1 + 16 FROM t1;
INSERT INTO t1 SELECT col1 + 32 FROM t1;
INSERT INTO t1 SELECT col1 + 64 FROM t1;
INSERT INTO t1 SELECT col1 + 128 FROM t1;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1 WITH 10 BUCKETS;
SELECT JSON_LENGTH(histogram->'$.buckets') <= 10 FROM information_schema.COLUMN_STATISTICS WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1 WITH 57 BUCKETS;
SELECT JSON_LENGTH(histogram->'$.buckets') <= 57 FROM information_schema.COLUMN_STATISTICS WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1 WITH 255 BUCKETS;
SELECT JSON_LENGTH(histogram->'$.buckets') <= 255 FROM information_schema.COLUMN_STATISTICS WHERE schema_name = 'test' AND table_name = 't1' AND column_name = 'col1';
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1, col2, col1 WITH 10 BUCKETS;
DROP TABLE t1;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (10), (20), (30);
CREATE TABLE t2 (c2 INT);
INSERT INTO t2 (c2) VALUES (10), (20), (30);
LOCK TABLES t2 READ;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON c1 WITH 10 BUCKETS;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t2 UPDATE HISTOGRAM ON c2 WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
UNLOCK TABLES;
DROP TABLES t1, t2;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE t1 (col1 INT, col2 VARCHAR(255));
INSERT INTO t1 VALUES (1, "1"), (2, "2"), (3, "3"), (4, "4"), (5, "5"), (6, "6"), (7, "7"), (8, "8"), (9, "9"), (10, "10");
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1, col2 WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 DROP HISTOGRAM ON col2;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 DROP HISTOGRAM ON col1;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1, col2 WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 DROP HISTOGRAM ON col2, col1;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t1 DROP HISTOGRAM ON col1;
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col2 WITH 10 BUCKETS;
ANALYZE TABLE t1 DROP HISTOGRAM ON col1, col2;
ANALYZE TABLE t1 DROP HISTOGRAM ON foobar;
ANALYZE TABLE foo DROP HISTOGRAM ON foobar;
CREATE TEMPORARY TABLE temp_table (col1 INT);
ANALYZE TABLE temp_table DROP HISTOGRAM ON col1;
DROP TABLE temp_table;
ANALYZE TABLE foo DROP HISTOGRAM ON foobar, foobar;
CREATE TABLE t2 (col1 INT);
ANALYZE TABLE t1, t2 DROP HISTOGRAM ON col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (10), (20), (30);
ANALYZE TABLE t1 UPDATE HISTOGRAM ON c1 WITH 10 BUCKETS;
CREATE TABLE t2 (c2 INT);
INSERT INTO t2 (c2) VALUES (10), (20), (30);
ANALYZE TABLE t2 UPDATE HISTOGRAM ON c2 WITH 10 BUCKETS;
LOCK TABLES t2 READ;
ANALYZE TABLE t1 DROP HISTOGRAM ON c1;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
ANALYZE TABLE t2 DROP HISTOGRAM ON c2;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
UNLOCK TABLES;
DROP TABLES t1, t2;
SELECT COUNT(*) AS should_be_0 FROM information_schema.COLUMN_STATISTICS;
CREATE TABLE t1 (col1 INT);
ANALYZE TABLE t1 UPDATE HISTOGRAM ON col1 WITH 10 BUCKETS;
SELECT schema_name, table_name, column_name FROM information_schema.COLUMN_STATISTICS;
DROP TABLE t1;