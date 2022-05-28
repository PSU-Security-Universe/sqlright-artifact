drop table if exists t1;
create table t1 (y year,y4 year(4));
insert into t1 values (0,0),(1999,1999),(2000,2000),(2001,2001),(70,70),(69,69);
select * from t1;
select * from t1 order by y;
select * from t1 order by y4;
drop table t1;
create table t1 (y year);
insert into t1 values (now());
select if(y = now(), 1, 0) from t1;
drop table t1;
create table t1(a year);
insert ignore into t1 values (2000.5), ('2000.5'), ('2001a'), ('2.001E3');
select * from t1;
drop table t1;
CREATE TABLE t4(yyyy YEAR, c4 CHAR(4));
INSERT INTO t4 (c4) VALUES (NULL),(1970),(1999),(2000),(2001),(2069);
UPDATE t4 SET yyyy = c4;
SELECT * FROM t4;
SELECT * FROM t4 a, t4 b WHERE a.yyyy = b.yyyy;
SELECT * FROM t4 a, t4 b WHERE a.yyyy <=> b.yyyy;
SELECT * FROM t4 a, t4 b WHERE a.yyyy < b.yyyy;
SELECT * FROM t4 WHERE yyyy = NULL;
SELECT * FROM t4 WHERE yyyy <=> NULL;
SELECT * FROM t4 WHERE yyyy = NOW();
SELECT * FROM t4 WHERE yyyy = 99;
SELECT * FROM t4 WHERE yyyy = 'test';
SELECT * FROM t4 WHERE yyyy = '1999';
SELECT * FROM t4 WHERE yyyy = 1999;
SELECT * FROM t4 WHERE yyyy = 1999.1;
SELECT * FROM t4 WHERE yyyy = 1998.9;
SELECT * FROM t4 WHERE yyyy = 0;
SELECT * FROM t4 WHERE yyyy = '0';
SELECT * FROM t4 WHERE yyyy = '0000';
SELECT * FROM t4 WHERE yyyy = '2000';
SELECT * FROM t4 WHERE yyyy = 2000;
SELECT COUNT(yyyy) FROM t4;
SELECT COUNT(*) FROM t4 WHERE yyyy > -1;
SELECT COUNT(*) FROM t4 WHERE yyyy > -1000000000000000000;
SELECT COUNT(*) FROM t4 WHERE yyyy < 2156;
SELECT COUNT(*) FROM t4 WHERE yyyy < 1000000000000000000;
SELECT * FROM t4 WHERE yyyy < 123;
SELECT * FROM t4 WHERE yyyy > 123;
DROP TABLE t4;
CREATE TABLE t1 (y YEAR NOT NULL, s VARCHAR(4));
INSERT IGNORE INTO t1 (s) VALUES ('bad');
INSERT INTO t1 (y, s) VALUES (0, 0), (2000, 2000), (2001, 2001);
SELECT * FROM t1 ta, t1 tb WHERE ta.y = tb.y;
SELECT * FROM t1 WHERE t1.y = 0;
SELECT * FROM t1 WHERE t1.y = 2000;
SELECT ta.y AS ta_y, ta.s, tb.y AS tb_y, tb.s FROM t1 ta, t1 tb HAVING ta_y = tb_y;
DROP TABLE t1;
CREATE TABLE t1(c1 YEAR);
INSERT INTO t1 VALUES (1901),(2155),(0000);
SELECT * FROM t1;
SELECT COUNT(*) AS total_rows, MIN(c1) AS min_value, MAX(c1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (c1 YEAR(2));
CREATE TABLE t1 (c1 YEAR(0));
CREATE TABLE t1 (c1 YEAR(4294967295));
CREATE TABLE t1 (c1 YEAR(4294967296));
CREATE TABLE t1 (c1 YEAR(4));
SHOW CREATE TABLE t1;
INSERT INTO t1 VALUES (55);
UPDATE t1 SET c1=2016;
CHECK TABLE t1 FOR UPGRADE;
REPAIR TABLE t1;
DELETE FROM t1;
ALTER TABLE t1 MODIFY COLUMN c1 YEAR(2);
DROP TABLE t1;
SET timestamp=UNIX_TIMESTAMP('2011-12-31 15:44:00');
CREATE TABLE t1 (a YEAR);
INSERT INTO t1 VALUES (CURRENT_TIME);
INSERT INTO t1 VALUES (TIME'15:44:00');
INSERT INTO t1 VALUES (TIME'25:00:00');
SELECT * FROM t1;
DROP TABLE t1;
SET timestamp=DEFAULT;
CREATE TABLE t(y YEAR);
INSERT INTO t VALUES (2155), (2155.0);
SELECT * FROM t;
INSERT INTO t VALUES (2155.0E00);
INSERT INTO t VALUES (2.1550E+03);
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t1(id INT, name VARCHAR(10), class CHAR(10), date1 DATETIME);
INSERT INTO t1 VALUES (1,'zhangsan','class1','2014-01-14 15:32:17'), (2,'lisi','class1','2013-12-14 10:21:27'), (3,'wangwu','class2','2003-05-21 08:25:14'), (4,'zhaoliu','class2','2001-07-19 09:35:18');
SELECT COUNT(DISTINCT name), AVG(YEAR(date1)) AS aa, class FROM t1 GROUP BY class ORDER BY aa;
DROP TABLE t1;
CREATE TABLE t(QC_DATE_KEY bigint, QC_DATE date, QC_TIMESTAMP datetime);
INSERT INTO t VALUES (1, '1999-02-28', '1999-11-28 14:45:00'), (2, '1999-12-31', '2000-01-01 00:00:00');
SELECT ((year(QC_DATE) - year(QC_TIMESTAMP))) FROM t WHERE QC_DATE_KEY = 2;
DROP TABLE t;
CREATE TABLE t1(a YEAR(4), b YEAR);
SHOW CREATE TABLE t1;
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 't1';
DESCRIBE t1;
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';
DESCRIBE v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE FUNCTION f1(a YEAR(4)) RETURNS YEAR(4) RETURN 1974;
CREATE FUNCTION f2(a YEAR) RETURNS YEAR RETURN 1974;
SHOW CREATE FUNCTION f1;
SHOW CREATE FUNCTION f2;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f2';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f2';
DROP FUNCTION f1;
DROP FUNCTION f2;
CREATE PROCEDURE p1(a YEAR(4), b YEAR) BEGIN END;
SHOW CREATE PROCEDURE p1;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
DROP PROCEDURE p1;
CREATE TABLE t1(a YEAR UNSIGNED);
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 (y YEAR, d DATE, i INTEGER, v VARCHAR(10));
INSERT INTO t1 VALUES(1901, DATE'1901-01-01', 1, 'one');
SELECT LEAST(d, y) FROM t1;
