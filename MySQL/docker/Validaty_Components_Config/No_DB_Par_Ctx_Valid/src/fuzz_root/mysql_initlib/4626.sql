SET sql_mode='time_truncate_fractional,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a VARCHAR(32), t6 TIME(6), t5 TIME(5), t4 TIME(4), t3 TIME(3), t2 TIME(2), t1 TIME(1), t0 TIME);
INSERT INTO t1 (a) VALUES ('10:10:10.9999999');
INSERT INTO t1 (a) VALUES ('10:10:10.9999994');
SELECT * FROM t1;;
ALTER TABLE t1 MODIFY a TIME(6);
UPDATE t1 SET t0=a, t1=a, t2=a, t3=a, t4=a, t5=a, t6=a;
SELECT * FROM t1;;
DROP TABLE t1;
CREATE TABLE t1 (a TIME(6));
INSERT INTO t1 VALUES ('10:10:10.999999');
ALTER TABLE t1 MODIFY a TIME(5);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME(6));
INSERT INTO t1 VALUES ('10:10:10.999999');
ALTER TABLE t1 MODIFY a TIME;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME(6), t6 TIME(6), t5 TIME(5), t4 TIME(4), t3 TIME(3), t2 TIME(2), t1 TIME(1), t0 TIME);
INSERT INTO t1 (a) VALUES ('2001-01-01 10:10:10.999999');
INSERT INTO t1 (a) VALUES ('2001-01-01 23:59:59.9999994');
UPDATE t1 SET t0=a, t1=a, t2=a, t3=a, t4=a, t5=a, t6=a;
SELECT * FROM t1;;
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(30,7), t6 TIME(6), t5 TIME(5), t4 TIME(4), t3 TIME(3), t2 TIME(2), t1 TIME(1), t0 TIME);
INSERT INTO t1 (a) VALUES (101010.9999999);
SELECT * FROM t1;;
ALTER TABLE t1 MODIFY a DOUBLE;
UPDATE t1 SET t0=a, t1=a, t2=a, t3=a, t4=a, t5=a, t6=a;
SELECT * FROM t1;;
DROP TABLE t1;
CREATE TABLE t1 (a TIME(6));
INSERT INTO t1 VALUES ('838:59:59.9999999');
INSERT INTO t1 VALUES ('-838:59:59.9999999');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('838:59:59.9999999');
INSERT INTO t1 VALUES ('-838:59:59.9999999');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME(6));
INSERT INTO t1 VALUES ('11:22:33');
INSERT INTO t1 VALUES ('11:22:33.123');
INSERT INTO t1 VALUES ('-11:22:33');
INSERT INTO t1 VALUES ('-11:22:33.1234567');
CREATE TABLE t2 (b DECIMAL(20,6));
INSERT INTO t2 VALUES (112233.123);
INSERT INTO t2 VALUES (-112233.1234567);
SELECT * FROM t1, t2 WHERE a=b;
DROP TABLE t1, t2;
CREATE TABLE t1 (a BIGINT, b TIME(6));
INSERT INTO t1 (b) VALUES ('10:10:59.500000');
INSERT INTO t1 (b) VALUES ('10:10:10.500000');
INSERT INTO t1 (b) VALUES ('10:10:10.499999');
UPDATE t1 SET a=b;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME(6));
INSERT INTO t1 VALUES ('11:22:33');
INSERT INTO t1 VALUES ('11:22:33.123');
INSERT INTO t1 VALUES ('-11:22:33');
INSERT INTO t1 VALUES ('-11:22:33.1234567');
CREATE TABLE t2 (b VARCHAR(20));
INSERT INTO t2 VALUES ('11:22:33.123');
INSERT INTO t2 VALUES ('-11:22:33.123456');
SELECT * FROM t1, t2 WHERE a=b;
DROP TABLE t1, t2;
CREATE TABLE t1 AS SELECT SEC_TO_TIME(3661), CAST(SEC_TO_TIME(3661) AS CHAR);
SHOW CREATE TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT SEC_TO_TIME(3661.9) AS c1, SEC_TO_TIME(3661.99) AS c2, SEC_TO_TIME(3661.999) AS c3, SEC_TO_TIME(3661.9999) AS c4, SEC_TO_TIME(3661.99999) AS c5, SEC_TO_TIME(3661.999999) AS c6, SEC_TO_TIME(3661.9999999) AS c7;
SHOW CREATE TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (hour INT, minute INT, second DECIMAL(23,7));
INSERT INTO t1 VALUES (836, 59, 59.999999), (836, 59, 59.9999990), (836, 59, 59.9999991), (836, 59, 59.9999992), (836, 59, 59.9999993), (836, 59, 59.9999995), (836, 59, 59.9999996), (836, 59, 59.9999997), (836, 59, 59.9999998), (836, 59, 59.9999999);
SELECT hour, minute, second, MAKETIME(hour, minute, second) AS MAKETIME FROM t1;
SELECT hour + 1, minute, second, MAKETIME(hour + 1, minute, second) AS MAKETIME FROM t1;
SELECT -hour, minute, second, MAKETIME(-hour, minute, second) AS MAKETIME FROM t1;
SELECT -hour - 1, minute, second, MAKETIME(-hour - 1, minute, second) AS MAKETIME FROM t1;
DROP TABLE t1;
SELECT MAKETIME(838, 59, 59.0000005) AS MAKETIME;
SELECT MAKETIME(838, 59, 59.00000056) AS MAKETIME;
SELECT MAKETIME(838, 59, 59.000000567) AS MAKETIME;
SELECT MAKETIME(838, 59, 59.0000005678) AS MAKETIME;
SELECT MAKETIME(838, 59, 59.00000056789) AS MAKETIME;
CREATE TABLE t1 (a DATETIME(6));
INSERT INTO t1 VALUES (20010101100000.1234567);
INSERT INTO t1 VALUES (20010228235959.9999997);
INSERT INTO t1 VALUES ('2001-01-01 10:00:00.1234567');
INSERT INTO t1 VALUES ('2001-02-28 23:59:59.9999997');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME(6));
INSERT INTO t1 VALUES ('2001-01-01 10:10:10.999999');
ALTER TABLE t1 MODIFY a DATETIME(5);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME(6));
INSERT INTO t1 VALUES ('2001-01-01 10:10:10.999999');
ALTER TABLE t1 MODIFY a TIME;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(32), t6 DATETIME(6), t5 DATETIME(5), t4 DATETIME(4), t3 DATETIME(3), t2 DATETIME(2), t1 DATETIME(1), t0 DATETIME);
INSERT INTO t1 (a) VALUES ('2001-01-01 10:10:10.9999999');
SELECT * FROM t1;;
ALTER TABLE t1 MODIFY a DATETIME(6);
UPDATE t1 SET t0=a, t1=a, t2=a, t3=a, t4=a, t5=a, t6=a;
SELECT * FROM t1;;
DROP TABLE t1;
CREATE TABLE t1 (a BIGINT, b DATETIME(6));
INSERT INTO t1 (b) VALUES ('2001-01-01 10:10:59.500000');
INSERT INTO t1 (b) VALUES ('2001-01-01 10:10:10.500000');
INSERT INTO t1 (b) VALUES ('2001-01-01 10:10:10.499999');
UPDATE t1 SET a=b;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(30,6), t6 DATETIME(6), t5 DATETIME(5), t4 DATETIME(4), t3 DATETIME(3), t2 DATETIME(2), t1 DATETIME(1), t0 DATETIME);
INSERT INTO t1 (a) VALUES (20010101101010.999999);
