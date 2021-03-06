CREATE TABLE t1 (col1 INTEGER);
CREATE TABLE t2 (col1 INTEGER);
INSERT INTO t1 VALUES (1), (3), (5), (7);
INSERT INTO t2 VALUES (1), (2), (5), (6);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 INTEGER);
CREATE TABLE t2 (col1 VARCHAR(255));
INSERT INTO t1 VALUES (1), (3), (5), (7);
INSERT INTO t2 VALUES (1), (2), (5), (6);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 DATETIME(6));
CREATE TABLE t2 (col1 DATETIME(6));
INSERT INTO t1 VALUES ('2018-01-01 00:00:00.000000'), ('2018-01-01 00:00:00.000001'), ('2018-01-02 00:00:00.000000'), ('2018-01-02 00:00:00.000001');
INSERT INTO t2 VALUES ('2018-01-01 00:00:00.000000'), ('2018-01-01 00:00:00.000002'), ('2018-01-02 00:00:00.000001'), ('2019-01-02 00:00:00.000001');
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1;
SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (a DATETIME);
INSERT INTO t1 VALUES ('2001-01-01 00:00:00');
CREATE TABLE t2 (b VARCHAR(64));
INSERT INTO t2 VALUES ('2001#01#01');
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1, t2 WHERE a=b;
SELECT * FROM t1, t2 WHERE a=b;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 DOUBLE);
CREATE TABLE t2 (col1 DOUBLE);
INSERT INTO t1 VALUES (1.1), (3.3), (5.5), (7.7);
INSERT INTO t2 VALUES (1.1), (1.11), (5.5), (6.6);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1;
SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 DECIMAL(6, 2));
CREATE TABLE t2 (col1 DECIMAL(6, 2));
INSERT INTO t1 VALUES (1.1), (3.3), (5.5), (7.7);
INSERT INTO t2 VALUES (1.1), (1.10), (5.5), (6.6);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1;
SELECT t1.col1, t2.col1 FROM t1 JOIN t2 ON t1.col1 = t2.col1 ORDER BY t1.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 BIGINT);
CREATE TABLE t2 (col1 DECIMAL(64,30));
INSERT INTO t1 VALUES (5);
INSERT INTO t2 VALUES (5.000000000000000000000000000000);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1,t2 WHERE t1.col1 = t2.col1;
SELECT * FROM t1,t2 WHERE t1.col1 = t2.col1;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 DECIMAL(5));
CREATE TABLE t2 (col1 BIGINT);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1,t2 where t1.col1=t2.col1;
SELECT * FROM t1,t2 where t1.col1=t2.col1;
DROP TABLE t1, t2;
create table t1 (id1 int, b1 bit(1)) engine = myisam;
create table t2 (id2 int, b2 bit(1)) engine = myisam;
insert into t1 values (2, 0), (3, 1);
insert into t2 values (2, 1), (3, 0);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1, t2 WHERE id1 = id2;
SELECT id1, HEX(b1), id2, HEX(b2) FROM t1, t2 WHERE id1 = id2;
DROP TABLE t1, t2;
create table t1 (id1 int, b1 bit(64)) engine = innodb;
create table t2 (id2 int, b2 bit(64)) engine = innodb;
insert into t1 values (2, 0), (3, 2);
insert into t2 values (2, 2), (3, 0);
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1, t2 WHERE id1 = id2;
SELECT id1, HEX(b1), id2, HEX(b2) FROM t1, t2 WHERE id1 = id2;
DROP TABLE t1, t2;
CREATE TABLE t1 (col1 VARCHAR(255));
CREATE TABLE t2 (col1 VARCHAR(255));
INSERT INTO t1 VALUES (NULL);
INSERT INTO t2 VALUES ("");
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1, t2 WHERE t1.col1 = t2.col1;
SELECT * FROM t1, t2 WHERE t1.col1 = t2.col1;
DROP TABLE t1,t2;
CREATE TABLE t1 (col1 BIGINT);
CREATE TABLE t2 (col1 BIGINT);
INSERT INTO t1 SELECT 1;
INSERT INTO t1 SELECT col1 + 1 FROM t1;
INSERT INTO t1 SELECT col1 + 2 FROM t1;
INSERT INTO t1 SELECT col1 + 4 FROM t1;
INSERT INTO t1 SELECT col1 + 8 FROM t1;
INSERT INTO t1 SELECT col1 + 16 FROM t1;
INSERT INTO t1 SELECT col1 + 32 FROM t1;
INSERT INTO t1 SELECT col1 + 64 FROM t1;
INSERT INTO t1 SELECT col1 + 128 FROM t1;
INSERT INTO t1 SELECT col1 + 256 FROM t1;
INSERT INTO t1 SELECT col1 + 512 FROM t1;
INSERT INTO t2 SELECT col1 FROM t1;
ANALYZE TABLE t1, t2;
SET join_buffer_size = 2048;
EXPLAIN FORMAT=tree SELECT SUM(t1.col1), SUM(t2.col1) FROM t1, t2 WHERE t1.col1 = t2.col1;
TRUNCATE performance_schema.file_summary_by_event_name;
SELECT COUNT_STAR > 0 FROM performance_schema.file_summary_by_event_name WHERE event_name LIKE '%hash_join%';
SELECT SUM(t1.col1), SUM(t2.col1) FROM t1, t2 WHERE t1.col1 = t2.col1;
SELECT COUNT_STAR > 0 FROM performance_schema.file_summary_by_event_name WHERE event_name LIKE '%hash_join%';
SET join_buffer_size = DEFAULT;
DROP TABLE t1,t2;
CREATE TABLE t1 ( str_col VARCHAR(255), blob_col LONGBLOB, text_col LONGTEXT, bit_col BIT(64), tinyint_col TINYINT, smallint_col SMALLINT, mediumint_col MEDIUMINT, int_col INTEGER, bigint_col BIGINT, float_col FLOAT, double_col DOUBLE, decimal_col DECIMAL(65, 30), year_col YEAR, date_col DATE, time_col TIME(6), datetime_col DATETIME(6), timestamp_col TIMESTAMP(6), json_col JSON, geometry_col GEOMETRY );
SET time_zone = '+00:00';
INSERT INTO t1 VALUES ( '', '', '', b'0000000000000000000000000000000000000000000000000000000000000000', -128, -32768, -8388608, -2147483648, -9223372036854775808, -3.402823466E+38, -1.7976931348623157E+308, '-99999999999999999999999999999999999.999999999999999999999999999999', 1901, '1000-01-01', '-838:59:59.000000', '1000-01-01 00:00:00.000000', '1970-01-01 00:00:01.000000', '{}', ST_GeomFromText('GEOMETRYCOLLECTION()') );
INSERT INTO t1 VALUES ( 'a very long and interesting string', 'a very long and interesting blob', 'a very long and interesting text', b'1111111111111111111111111111111111111111111111111111111111111111', 127, 32767, 8388607, 2147483647, 9223372036854775807, 3.402823466E+38, 1.7976931348623157E+308, '99999999999999999999999999999999999.999999999999999999999999999999', 2155, '9999-12-31', '838:59:59.000000', '9999-12-31 23:59:59.999999', '2038-01-19 03:14:07.999999', '{"key": [1, 2, 3]}', ST_GeomFromText('GEOMETRYCOLLECTION(POINT(1 2), POINT(3 4))') );
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
SET join_buffer_size = 99968;
