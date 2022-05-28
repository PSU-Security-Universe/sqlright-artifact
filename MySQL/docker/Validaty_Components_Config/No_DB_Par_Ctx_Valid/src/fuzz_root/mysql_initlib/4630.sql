DROP TABLE IF EXISTS t1;
show variables like "system_time_zone";
select @a:=FROM_UNIXTIME(1);
select unix_timestamp(@a);
CREATE TABLE t1 (ts int);
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 01:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 02:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 03:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 02:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 01:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2002-10-27 02:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2003-03-30 02:59:59'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2003-03-30 03:00:00'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2003-03-30 03:59:59'));
INSERT INTO t1 (ts) VALUES (Unix_timestamp('2003-03-30 04:00:01'));
SELECT ts,from_unixtime(ts) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (ts timestamp);
INSERT IGNORE INTO t1 (ts) VALUES ('2003-03-30 01:59:59'), ('2003-03-30 02:59:59'), ('2003-03-30 03:00:00');
DROP TABLE t1;
select unix_timestamp('1970-01-01 01:00:00'),  unix_timestamp('1970-01-01 01:00:01'), unix_timestamp('2038-01-19 04:14:07'), unix_timestamp('2038-01-19 04:14:08');
CREATE TABLE t1 (c1 TIMESTAMP);
SET TIME_ZONE = '+00:00';
SET explicit_defaults_for_timestamp=OFF;
INSERT INTO t1 VALUES('2019-10-27 00:47:42'), ('2019-10-27 00:47:42');
INSERT INTO t1 VALUES('2019-10-27 01:47:42'), ('2019-10-27 01:47:42');
SET TIME_ZONE = 'SYSTEM';
SELECT DISTINCT c1 FROM t1;
SELECT COUNT(*) FROM t1 GROUP BY c1;
SET sql_mode='';
SELECT COUNT(*) FROM t1 GROUP BY c1;
SET sql_mode=DEFAULT;
SET explicit_defaults_for_timestamp=ON;
DROP TABLE t1;
SET time_zone = '+01:00';
SELECT TIMESTAMP'2015-01-01 10:10:10+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.1+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.01+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.001+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.0001+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.00001+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.000001+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.0000001+05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.1-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.01-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.001-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.0001-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.00001-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.000001-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10.0000001-05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10+5:30';
SELECT TIMESTAMP'2015-01-01 10:10:10+5:030';
SELECT TIMESTAMP'2015-01-01 10:10:10+005:30';
SELECT TIMESTAMP'2001-01-01 00:00:00+02:00';
SELECT TIMESTAMP( '2001-01-01 00:00:00+02:00' );
SELECT TIMESTAMP'2015-01-01 10:10:10+05:300';
SELECT TIMESTAMP'2015-01-01 10:10:10.0+05:300';
SELECT TIMESTAMP'2015-01-01 10:10:10.0+05:30xxx';
SELECT TIMESTAMP'2015-01-01 10:10:10.0+25:30';
SELECT TIMESTAMP'2015-01-01 10:10:10+05';
SELECT TIMESTAMP'2015-01-01 10:10:10+05:';
SELECT TIMESTAMP'2015-01-01 10:10:10+0';
SELECT TIMESTAMP'2015-01-01 10:10:10+1';
SELECT TIMESTAMP'2015-01-01 10:10:10 +05:30';
SELECT TIMESTAMP'2015-01-01 10:10:10+14:01';
SELECT TIMESTAMP'2015-01-01 10:10:10-14:01';
SELECT TIMESTAMP'2015-01-01 10:10:10+zx:00';
SELECT TIMESTAMP'2015-01-01 10:10:10+00:00zx';
SET time_zone = '+02:00';
CREATE TABLE t1 ( a TIMESTAMP DEFAULT '1995-05-05 00:00:00+05:30' );
INSERT INTO t1 VALUES ();
SELECT * FROM t1;
DROP TABLE t1;
SET time_zone = '+01:00';
CREATE TABLE t1 ( id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, a TIMESTAMP NOT NULL ) AUTO_INCREMENT = 1;
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10' );
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10+05:30' );
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10+14:00' );
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10-14:00' );
SET @a = '2015-01-01 10:10:10+02:00';
PREPARE stmt1 FROM "INSERT INTO t1( a ) VALUES ( ? )";
EXECUTE stmt1 USING @a;
SELECT * FROM t1;
SET time_zone = '+00:00';
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10' );
SELECT * FROM t1;
SET time_zone = '+03:00';
INSERT INTO t1( a ) VALUES ( '2015-01-01 10:10:10+02:00' );
SELECT * FROM t1;
SET time_zone = '+05:30';
SELECT * FROM t1;
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+03:30';
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+02:00';
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+05:30';
SET time_zone = '+00:00';
SELECT * FROM t1;
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+03:30';
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+02:00';
SELECT * FROM t1 WHERE a = '2015-01-01 10:10:10+05:30';
SET time_zone = DEFAULT;
DROP TABLE t1;
SET time_zone = '+01:00';
CREATE TABLE t1 ( a TIMESTAMP(1) );
INSERT INTO t1 VALUES ( TIMESTAMP'2015-01-01 10:10:10.1+05:30' );
SELECT * FROM t1 WHERE a = '2015-01-01 05:40:10.1';
DROP TABLE t1;
CREATE TABLE t1 ( a TIMESTAMP(2) );
INSERT INTO t1 VALUES ( TIMESTAMP'2015-01-01 10:10:10.01+05:30' );
SELECT * FROM t1 WHERE a = '2015-01-01 05:40:10.01';
DROP TABLE t1;
CREATE TABLE t1 ( a TIMESTAMP(3) );
INSERT INTO t1 VALUES ( TIMESTAMP'2015-01-01 10:10:10.001+05:30' );
SELECT * FROM t1 WHERE a = '2015-01-01 05:40:10.001';
DROP TABLE t1;
CREATE TABLE t1 ( a TIMESTAMP(4) );
INSERT INTO t1 VALUES ( TIMESTAMP'2015-01-01 10:10:10.0001+05:30' );
SELECT * FROM t1 WHERE a = '2015-01-01 05:40:10.0001';
DROP TABLE t1;
CREATE TABLE t1 ( a TIMESTAMP(5) );
INSERT INTO t1 VALUES ( TIMESTAMP'2015-01-01 10:10:10.00001+05:30' );
SELECT * FROM t1 WHERE a = '2015-01-01 05:40:10.00001';