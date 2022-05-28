DROP TABLE IF EXISTS t1, t2;
SET NAMES latin1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
SELECT DATE'xxxx';
SELECT DATE'01';
SELECT DATE'01-01';
SELECT DATE'2001';
SELECT DATE'2001-01';
SELECT DATE'2001-00-00';
SELECT DATE'2001-01-00';
SELECT DATE'0000-00-00';
SELECT DATE'2001-01-01 00:00:00';
SELECT DATE'01:01:01';
SELECT DATE'01-01-01';
SELECT DATE'2010-01-01';
SELECT DATE '2010-01-01';
CREATE TABLE t1 AS SELECT DATE'2010-01-01';
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT {d'2001-01-01'}, {d'2001-01-01 10:10:10'};
SHOW CREATE TABLE t1;
DROP TABLE t1;
EXPLAIN SELECT {d'2010-01-01'};
EXPLAIN SELECT DATE'2010-01-01';
SET sql_mode='NO_ZERO_IN_DATE';
SELECT DATE'2001-00-00';
SELECT DATE'2001-01-00';
SET sql_mode = '';
SELECT DATE'0000-00-00';
SET sql_mode=default;
SELECT TIME'xxxx';
SELECT TIME'900:00:00';
SELECT TIME'-900:00:00';
SELECT TIME'1 24:00:00';
SELECT TIME'30 24:00:00';
SELECT TIME'0000-00-00 00:00:00';
SELECT TIME'40 24:00:00';
SELECT TIME'10';
SELECT TIME'10:10';
SELECT TIME'10:11.12';
SELECT TIME'10:10:10';
SELECT TIME'10:10:10.';
SELECT TIME'10:10:10.1';
SELECT TIME'10:10:10.12';
SELECT TIME'10:10:10.123';
SELECT TIME'10:10:10.1234';
SELECT TIME'10:10:10.12345';
SELECT TIME'10:10:10.123456';
SELECT TIME'-10:00:00';
SELECT TIME '10:11:12';
CREATE TABLE t1 AS SELECT TIME'10:10:10', TIME'10:10:10.', TIME'10:10:10.1', TIME'10:10:10.12', TIME'10:10:10.123', TIME'10:10:10.1234', TIME'10:10:10.12345', TIME'10:10:10.123456';
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT {t'10:10:10'}, {t'10:10:10.'}, {t'10:10:10.123456'}, {t'2001-01-01'};
SHOW CREATE TABLE t1;
DROP TABLE t1;
EXPLAIN SELECT {t'10:01:01'};
EXPLAIN SELECT TIME'10:01:01';
SELECT TIMESTAMP'xxxx';
SELECT TIMESTAMP'2010';
SELECT TIMESTAMP'2010-01';
SELECT TIMESTAMP'2010-01-01';
SELECT TIMESTAMP'2010-01-01 00';
SELECT TIMESTAMP'2010-01-01 00:01';
SELECT TIMESTAMP'2010-01-01 10:10:10';
SELECT TIMESTAMP'2010-01-01 10:10:10.';
SELECT TIMESTAMP'2010-01-01 10:10:10.1';
SELECT TIMESTAMP'2010-01-01 10:10:10.12';
SELECT TIMESTAMP'2010-01-01 10:10:10.123';
SELECT TIMESTAMP'2010-01-01 10:10:10.1234';
SELECT TIMESTAMP'2010-01-01 10:10:10.12345';
SELECT TIMESTAMP'2010-01-01 10:10:10.123456';
SELECT TIMESTAMP '2010-01-01 10:20:30';
CREATE TABLE t1 AS SELECT TIMESTAMP'2010-01-01 10:10:10', TIMESTAMP'2010-01-01 10:10:10.', TIMESTAMP'2010-01-01 10:10:10.1', TIMESTAMP'2010-01-01 10:10:10.12', TIMESTAMP'2010-01-01 10:10:10.123', TIMESTAMP'2010-01-01 10:10:10.1234', TIMESTAMP'2010-01-01 10:10:10.12345', TIMESTAMP'2010-01-01 10:10:10.123456';
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT {ts'2001-01-01 10:10:10'}, {ts'2001-01-01 10:10:10.'}, {ts'2001-01-01 10:10:10.123456'}, {ts'2001-01-01'};
SHOW CREATE TABLE t1;
DROP TABLE t1;
EXPLAIN SELECT {ts'2010-01-01 10:10:10'};
EXPLAIN SELECT TIMESTAMP'2010-01-01 10:10:10';
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
SELECT TIMESTAMP'2001-00-00 00:00:00.999999';
SELECT TIMESTAMP'2001-00-01 00:00:00.999999';
SELECT TIMESTAMP'2001-01-00 00:00:00.999999';
SELECT TIMESTAMP'2001-00-00 00:00:00.9999999';
SELECT TIMESTAMP'2001-00-01 00:00:00.9999999';
SELECT TIMESTAMP'2001-01-00 00:00:00.9999999';
CREATE TABLE t1 (a DATETIME(6));
INSERT INTO t1 VALUES ('2001-00-00 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-00-01 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-01-00 00:00:00.9999999');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME(5));
INSERT INTO t1 VALUES ('2001-00-00 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-00-01 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-01-00 00:00:00.9999999');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME);
INSERT INTO t1 VALUES ('2001-00-00 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-00-01 00:00:00.9999999');
INSERT INTO t1 VALUES ('2001-01-00 00:00:00.9999999');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES ('2001-01-01'),('2003-01-01');
SELECT * FROM t1 WHERE a BETWEEN DATE'2001-01-01' AND DATE'2002-01-01';
SELECT DATE'2001-01-01' FROM t1 GROUP BY DATE'2001-01-01';
DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1(c1 INT, c2 DATE, c3 TIME, c4 TIMESTAMP);
CREATE TABLE t2(c11 INT, C12 INT);
INSERT INTO t1 VALUES (1, '2014-01-02', '01:01:01', '2014-01-02 01:01:01'), (2, '2014-01-04', '01:01:01', '2014-01-02 01:01:01');
INSERT INTO t2 VALUES (3, 4), (5, 6);
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c2 BETWEEN {d'2014-01-01'} AND {d'2014-01-05'};
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c3 BETWEEN {t'01:01:01'} AND {t'01:01:05'};
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c4 BETWEEN {ts'2014-01-01 01:01:01'} AND {ts'2014-01-05 01:01:01'};
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c2 BETWEEN DATE'2014-01-01' AND DATE'2014-01-05';
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c3 BETWEEN TIME'01:01:01' AND TIME'01:01:05';
SELECT * FROM t1 LEFT JOIN t2 ON c1 = c11 WHERE c4 BETWEEN TIMESTAMP'2014-01-01 01:01:01'                AND TIMESTAMP'2014-01-05 01:01:01';