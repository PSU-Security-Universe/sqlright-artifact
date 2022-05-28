CREATE TABLE t1 ( pk int NOT NULL, col_int_key int DEFAULT NULL, col_int int DEFAULT NULL, col_varchar varchar(1) DEFAULT NULL, PRIMARY KEY (pk), KEY col_int_key (col_int_key) );
INSERT INTO t1 VALUES (10,7,5,'l'), (12,7,4,'o');
CREATE TABLE t2 ( col_date_key date DEFAULT NULL, col_datetime_key datetime DEFAULT NULL, col_int_key int(11) DEFAULT NULL, col_varchar_key varchar(1) DEFAULT NULL, col_varchar varchar(1) DEFAULT NULL, col_time time DEFAULT NULL, pk int NOT NULL, col_date date DEFAULT NULL, col_time_key time DEFAULT NULL, col_datetime datetime DEFAULT NULL, col_int int DEFAULT NULL, PRIMARY KEY (pk), KEY col_date_key (col_date_key), KEY col_datetime_key (col_datetime_key), KEY col_int_key (col_int_key), KEY col_varchar_key (col_varchar_key), KEY col_time_key (col_time_key) );
INSERT INTO t2(col_int_key,col_varchar_key,col_varchar,pk,col_int)  VALUES (8,'a','w',1,5), (9,'y','f',7,0), (9,'z','i',11,9), (9,'r','s',12,3), (7,'n','i',13,6), (9,'j','v',17,9), (240,'u','k',20,6);
CREATE TABLE t3 ( col_int int DEFAULT NULL, col_int_key int(11) DEFAULT NULL, pk int NOT NULL, PRIMARY KEY (pk), KEY col_int_key (col_int_key) );
INSERT INTO t3 VALUES (8,4,1);
ANALYZE TABLE t1, t2, t3;
SELECT table2.col_int_key AS field1 FROM (SELECT sq1_t1.* FROM t1 AS sq1_t1 RIGHT OUTER JOIN t2 AS sq1_t2 ON sq1_t2.col_varchar_key = sq1_t1.col_varchar ) AS table1 LEFT JOIN t1 AS table2 RIGHT JOIN t2 AS table3 ON table3.pk = table2.col_int_key ON table3.col_int_key = table2.col_int WHERE table3.col_int_key >= ALL (SELECT sq2_t1.col_int AS sq2_field1 FROM t2 AS sq2_t1 STRAIGHT_JOIN t3 AS sq2_t2 ON sq2_t2.col_int = sq2_t1.pk AND sq2_t1.col_varchar IN (SELECT sq21_t1.col_varchar AS sq21_field1 FROM t2 AS sq21_t1 STRAIGHT_JOIN t1 AS sq21_t2 ON sq21_t2.col_int_key = sq21_t1.pk WHERE sq21_t1.pk = 7 ) WHERE sq2_t2.col_int_key >= table2.col_int AND sq2_t1.col_int_key <= table2.col_int_key );
DROP TABLE t1, t2, t3;
CREATE TABLE t1(k VARCHAR(10) PRIMARY KEY);
CREATE TABLE t2(k VARCHAR(10) PRIMARY KEY);
SET SQL_MODE='';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
EXPLAIN SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
SET SQL_MODE=ONLY_FULL_GROUP_BY;
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
EXPLAIN SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
SET SQL_MODE=STRICT_TRANS_TABLES;
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
EXPLAIN SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
SET SQL_MODE=DEFAULT;
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX' FROM t1 WHERE k ='X';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX', SUM(k) FROM t1;
EXPLAIN SELECT SUM(k), k FROM t1 HAVING (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX';
EXPLAIN SELECT (SELECT 'X' FROM t2 WHERE t2.k = CONCAT(t1.k, 'X') AND SUM(t1.k)) = 'XXX' FROM t1;
DROP TABLE t1,t2;
SET sql_mode='';
CREATE TABLE a(d INT,e BIGINT, KEY(e));
INSERT a VALUES (0,0);
CREATE TABLE b(f TIME);
INSERT b VALUES (null),(null),(null);
CREATE TABLE c(g DATETIME(6) NOT NULL);
INSERT c(g) VALUES (now()+interval 1 day);
INSERT c(g) VALUES (now()-interval 1 day);
SELECT 1 FROM a WHERE (SELECT f FROM b WHERE (SELECT 1 FROM c)) <=> e GROUP BY d;
SET sql_mode=default;
DROP TABLES a, b, c;
CREATE TABLE p (Id INT,PRIMARY KEY (Id));
INSERT INTO p VALUES (1);
CREATE TABLE s (Id INT, u INT, UNIQUE KEY o(Id, u) );
INSERT INTO s VALUES (1, NULL),(1, NULL);
ANALYZE TABLE s;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s WHERE Id=1 AND u IS NULL)ORDER BY Id DESC;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s WHERE Id=1 AND u IS NULL)ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
CREATE TABLE s1 (Id INT, u INT, UNIQUE KEY o(Id, u) );
INSERT INTO s1 VALUES (1, 2),(1, 3);
ANALYZE TABLE s1;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s1.Id FROM s1 WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s1.Id FROM s1 WHERE Id=1 AND u != 1) ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s1.Id FROM s1 WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s1.Id FROM s1 WHERE Id=1 AND u != 1) ORDER BY Id DESC;
CREATE TABLE s2 (Id INT, u INT, KEY o(Id, u) );
INSERT INTO s2 VALUES (1, NULL),(1, NULL);
ANALYZE TABLE s2;
CREATE TABLE s3 (Id INT NOT NULL, u INT NOT NULL, UNIQUE KEY o(Id, u));
INSERT INTO s3 VALUES (1, 2),(1, 3);
ANALYZE TABLE s3;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s2 s WHERE Id=1 AND u IS NULL) ORDER BY Id DESC;
EXPLAIN SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s3 s WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s2 s WHERE Id=1 AND u IS NULL) ORDER BY Id DESC;
SELECT p.Id FROM (p) WHERE p.Id IN ( SELECT s.Id FROM s3 s WHERE Id=1 AND u IS NOT NULL) ORDER BY Id DESC;
DROP TABLE p, s, s1, s2, s3;
CREATE TABLE t1 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('5');
CREATE TABLE t2 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t2 VALUES ('Y');
PREPARE prep_stmt FROM "SELECT t2.f1 FROM (t2 LEFT JOIN t1  ON (1 = ANY (SELECT f1 FROM t1 WHERE 1 IS NULL)))" ;
EXECUTE prep_stmt ;
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('Z') ;
CREATE TABLE t2 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t2 VALUES ('Z') ;
PREPARE prep_stmt FROM " SELECT t2.f1 FROM t2 LEFT OUTER JOIN (SELECT  * FROM t2 WHERE ('y',1)  IN (SELECT alias1.f1 , 0 FROM t1 AS alias1 LEFT JOIN t2 ON 0)) AS alias ON 0";
EXECUTE prep_stmt ;
PREPARE prep_stmt FROM " SELECT t2.f1 FROM (t2 LEFT OUTER JOIN (SELECT  * FROM t2 WHERE ('y',1)  IN (SELECT alias1.f1 , 0 FROM      (t1 INNER JOIN  (t1 AS alias1 LEFT JOIN t2 ON 0) ON 0))) AS alias ON 0)";
EXECUTE prep_stmt ;
DROP TABLE t1,t2;
CREATE TABLE t1 (cv VARCHAR(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('h'), ('Q'), ('I'), ('q'), ('W');
ANALYZE TABLE t1;
EXPLAIN SELECT cv FROM t1 WHERE EXISTS (SELECT alias1.cv AS field1 FROM t1 AS alias1 RIGHT JOIN t1 AS alias2 ON alias1.cv = alias2.cv );
SELECT cv FROM t1 WHERE EXISTS (SELECT alias1.cv AS field1 FROM t1 AS alias1 RIGHT JOIN t1 AS alias2 ON alias1.cv = alias2.cv );
DROP TABLE t1;
CREATE TABLE t1 (col_varchar_key varchar(1) DEFAULT NULL);
EXPLAIN SELECT * FROM t1 WHERE col_varchar_key IN (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = (SELECT col_varchar_key FROM t1 WHERE col_varchar_key > @var1 ) );
SELECT * FROM t1 WHERE col_varchar_key IN (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = (SELECT col_varchar_key FROM t1 WHERE col_varchar_key > @var1 ) );
EXPLAIN SELECT * FROM t1 WHERE col_varchar_key IN (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = RAND() ) );
SELECT * FROM t1 WHERE col_varchar_key IN (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = (SELECT col_varchar_key FROM t1 WHERE col_varchar_key = RAND() ) );
DROP TABLE t1;
CREATE TABLE t1 ( pk integer NOT NULL PRIMARY KEY, f1 varchar(1), KEY k1 (f1) );
CREATE TABLE t2 ( pk integer NOT NULL PRIMARY KEY );
CREATE VIEW v2 AS select * FROM t2;
INSERT INTO t1 VALUES (1, 'G');
INSERT INTO t1 VALUES (2, 'j');
INSERT INTO t1 VALUES (3, 'K');
INSERT INTO t1 VALUES (4, 'v');
INSERT INTO t1 VALUES (5, 'E');
ANALYZE TABLE t1, t2;
EXPLAIN FORMAT=tree SELECT * FROM t1 WHERE pk IN ( SELECT pk FROM t1 LEFT JOIN v2 USING (pk) WHERE f1 >= 'o' );
DROP TABLE t1, t2;
DROP VIEW v2;
CREATE TABLE t1 ( f1 varchar(1), KEY k1 (f1) );
INSERT INTO t1 VALUES ('6'),('6');
