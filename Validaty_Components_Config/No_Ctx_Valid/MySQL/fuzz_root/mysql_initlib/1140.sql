set optimizer_switch= "use_index_extensions=on";
CREATE TABLE t1 ( pk_1 INT, pk_2 INT, f1 DATETIME, f2 INT, PRIMARY KEY(pk_1, pk_2), KEY k1(f1), KEY k2(f2) ) ENGINE = InnoDB;
INSERT INTO t1 SELECT pk_1 + 60, pk_2, f1, f2 FROM t1;
INSERT INTO t1 SELECT pk_1 + 120, pk_2, f1, f2 FROM t1;
INSERT INTO t1 SELECT pk_1 + 240, pk_2, f1, f2 FROM t1;
INSERT INTO t1 SELECT pk_1, pk_2 + 10, f1, f2 FROM t1;
ANALYZE TABLE t1;
EXPLAIN SELECT count(*) FROM t1 WHERE pk_1 = 3 and f1 = '2000-01-03';
FLUSH STATUS;
SELECT count(*) FROM t1 WHERE pk_1 = 3 and f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT pk_2 FROM t1 WHERE pk_1 = 3 and f1 = '2000-01-03';
FLUSH STATUS;
SELECT pk_2 FROM t1 WHERE pk_1 = 3 and f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT count(*) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
FLUSH STATUS;
SELECT count(*) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT pk_1, pk_2 FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
FLUSH STATUS;
SELECT pk_1, pk_2 FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MIN(pk_1) FROM t1 WHERE f1 = '2000-01-03';
FLUSH STATUS;
SELECT MIN(pk_1) FROM t1 WHERE f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MIN(pk_1) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
FLUSH STATUS;
SELECT MIN(pk_1) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MAX(pk_1) FROM t1 WHERE f1 = '2000-01-03';
FLUSH STATUS;
SELECT MAX(pk_1) FROM t1 WHERE f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MAX(pk_1) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
FLUSH STATUS;
SELECT MAX(pk_1) FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MIN(pk_1) FROM t1 WHERE f2 BETWEEN 13 AND 14 GROUP BY f2;
FLUSH STATUS;
SELECT MIN(pk_1) FROM t1 WHERE f2 BETWEEN 13 AND 14 GROUP BY f2;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT MIN(pk_1) FROM t1 WHERE f2 IN (1, 2) GROUP BY f2;
FLUSH STATUS;
SELECT MIN(pk_1) FROM t1 WHERE f2 IN (1, 2) GROUP BY f2;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT count(*) FROM t1 AS t1 JOIN t1 AS t2 ON t2.pk_1 = t1.pk_1 WHERE t1.f1 = '2000-01-03' AND t2.f1 = '2000-01-03';
FLUSH STATUS;
SELECT count(*) FROM t1 AS t1 JOIN t1 AS t2 ON t2.pk_1 = t1.pk_1 WHERE t1.f1 = '2000-01-03' AND t2.f1 = '2000-01-03';
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT f1, pk_1, pk_2 FROM t1 WHERE pk_1 = 3 AND f1 = '2000-01-03' ORDER BY pk_2 DESC LIMIT 5;
EXPLAIN FORMAT=tree SELECT f1, pk_1, pk_2 FROM t1 WHERE pk_1 = 3 AND f1 = '2000-01-03' ORDER BY pk_2 DESC LIMIT 5;
FLUSH STATUS;
SELECT f1, pk_1, pk_2 FROM t1 WHERE pk_1 = 3 AND f1 = '2000-01-03' ORDER BY pk_2 DESC LIMIT 5;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT f1, pk_1, pk_2 FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03' ORDER BY pk_2 DESC LIMIT 5;
FLUSH STATUS;
SELECT f1, pk_1, pk_2 FROM t1 WHERE pk_1 BETWEEN 3 AND 5 AND f1 = '2000-01-03' ORDER BY pk_2 DESC LIMIT 5;
SHOW STATUS LIKE 'handler_read%';
DROP TABLE t1;
CREATE TABLE t1 ( f1 INT, f2 INT, f3 INT, f4 INT, f5 INT, f6 INT, f7 INT, f8 INT, f9 INT, f10 INT, f11 INT, f12 INT, f13 INT, f14 INT, f15 INT, f16 INT, f17 INT, f18 INT, PRIMARY KEY (f1, f2, f3, f4, f5, f6, f7, f8, f9, f10), KEY k1 (f11, f12, f13, f14, f15, f16, f17) ) ENGINE = InnoDB;
EXPLAIN SELECT f17 FROM t1 FORCE INDEX (k1) WHERE f1 = 0 AND f2 = 0 AND f3 = 0 AND f4 = 0 AND f5 = 0 AND f6 = 0 AND f7 = 0 AND f8 = 0 AND f9 = 0 AND f10 = 0 AND f11 = 0 AND f12 = 0 AND f13 = 0 AND f14 = 0 AND f15 = 0 AND f16 = 0 AND f17 = 0;
EXPLAIN SELECT f17 FROM t1 FORCE INDEX (k1) WHERE f1 = 0 AND f2 = 0 AND f3 = 0 AND f4 = 0 AND f5 = 0 AND f6 = 0 AND f7 = 0 AND f8 = 0 AND f9 = 0 AND f11 = 0 AND f12 = 0 AND f13 = 0 AND f14 = 0 AND f15 = 0 AND f16 = 0 AND f17 = 0;
DROP TABLE t1;
CREATE TABLE t1 ( f1 VARCHAR(500), f2 VARCHAR(500), f3 VARCHAR(500), f4 VARCHAR(500), f5 VARCHAR(500), f6 VARCHAR(500), f7 VARCHAR(500), PRIMARY KEY (f1, f2, f3, f4), KEY k1 (f5, f6, f7) ) charset latin1 ENGINE = InnoDB;
EXPLAIN SELECT f5 FROM t1 FORCE INDEX (k1) WHERE f1 = 'a' AND f2 = 'a' AND f3 = 'a' AND f4 = 'a' AND f5 = 'a' AND f6 = 'a' AND f7 = 'a';
EXPLAIN SELECT f5 FROM t1 FORCE INDEX (k1) WHERE f1 = 'a' AND f2 = 'a' AND f3 = 'a' AND f5 = 'a' AND f6 = 'a' AND f7 = 'a';
EXPLAIN SELECT f5 FROM t1 FORCE INDEX (k1) WHERE f1 = 'a' AND f2 = 'a' AND f4 = 'a' AND f5 = 'a' AND f6 = 'a' AND f7 = 'a';
DROP TABLE t1;
CREATE TABLE t1 ( pk INT NOT NULL auto_increment, f1 INT NOT NULL, KEY (f1), PRIMARY KEY (pk) ) ENGINE = INNODB;
CREATE TABLE t2 ( f1 INT, f2 INT ) ENGINE = INNODB;
INSERT INTO t1(f1) VALUES (1),(2);
INSERT INTO t1(f1) SELECT f1 + 2 FROM t1;
INSERT INTO t1(f1) SELECT f1 + 4 FROM t1;
ANALYZE TABLE t1;
INSERT INTO t2 VALUES (1,1), (2,2);
EXPLAIN SELECT t2.f1 FROM t2 JOIN t1 IGNORE INDEX(primary) ON t2.f1 = t1.pk and t2.f2 = t1.f1;
FLUSH STATUS;
SELECT t2.f1 FROM t2 JOIN t1 IGNORE INDEX(primary) ON t2.f1 = t1.pk and t2.f2 = t1.f1;
SHOW STATUS LIKE 'Handler_read%';
DROP TABLE t1, t2;
CREATE TABLE t1 (a GEOMETRY NOT NULL SRID 0, SPATIAL KEY(a)) ENGINE=INNODB;
INSERT INTO t1 VALUES (point(7, 7));
SELECT st_astext(a) FROM t1 WHERE st_equals(a, point(7, 7));
DROP TABLE t1;
CREATE TABLE t( a VARCHAR(256) NOT NULL, i VARCHAR(512) NOT NULL, PRIMARY KEY (a), KEY (i)) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO t VALUES ('aaa12345678','aaa'), ('aaa2','aaa'), ('aaa4','aaa'), ('aaa3','aaa'),('aaa1','aaa');
ANALYZE TABLE t;
EXPLAIN SELECT DISTINCT(i) FROM t FORCE INDEX(i) WHERE a LIKE '%aaa12345678%';
SELECT DISTINCT(i) FROM t FORCE INDEX(i) WHERE a LIKE '%aaa12345678%';
DROP TABLE t;
set optimizer_switch=default;
