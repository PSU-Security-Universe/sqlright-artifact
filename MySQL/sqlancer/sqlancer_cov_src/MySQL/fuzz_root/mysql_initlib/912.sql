CREATE TABLE t_innodb(c1 INT NOT NULL PRIMARY KEY, c2 INT NOT NULL, c3 char(20), KEY c3_idx(c3))ENGINE=INNODB;
INSERT INTO t_innodb VALUES (1, 1, 'a'), (2,2,'a'), (3,3,'a');
ANALYZE TABLE t_innodb;
CREATE TABLE t_myisam(c1 INT NOT NULL PRIMARY KEY, c2 INT NOT NULL DEFAULT 1, c3 char(20), KEY c3_idx(c3)) ENGINE=MYISAM;
INSERT INTO t_myisam(c1) VALUES (1), (2);
ANALYZE TABLE t_myisam;
EXPLAIN SELECT COUNT(*) FROM t_innodb;
EXPLAIN SELECT COUNT(*) FROM t_myisam;
EXPLAIN SELECT COUNT(*) FROM t_myisam, t_innodb;
EXPLAIN SELECT MIN(c2), COUNT(*), MAX(c1) FROM t_innodb;
EXPLAIN SELECT MIN(c3), COUNT(*) FROM t_innodb;
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_myisam;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_myisam, t_innodb;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT MIN(c2), COUNT(*), MAX(c1) FROM t_innodb;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT MIN(c3), COUNT(*) FROM t_innodb;
SHOW STATUS LIKE 'Handler_%';
CREATE TABLE t_nopk(c1 INT NOT NULL , c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_nopk SELECT c1, c2 FROM t_innodb;
ANALYZE TABLE t_nopk;
SHOW CREATE TABLE t_nopk;
EXPLAIN SELECT COUNT(*) FROM t_nopk;
FLUSH STATUS;
SELECT COUNT(*) FROM t_nopk;
SHOW STATUS LIKE 'Handler_%';
CREATE INDEX c2_idx on t_nopk(c2);
SHOW CREATE TABLE t_nopk;
EXPLAIN SELECT COUNT(*) FROM t_nopk;
FLUSH STATUS;
SELECT COUNT(*) FROM t_nopk;
SHOW STATUS LIKE 'Handler_%';
DROP TABLE t_nopk;
CREATE TABLE t_innodb_nopk_sk(c1 INT NOT NULL, c2 INT NOT NULL, KEY c2_idx(c2))ENGINE=INNODB;
CREATE TABLE t_innodb_pk_nosk(c1 INT NOT NULL PRIMARY KEY, c2 INT NOT NULL)ENGINE=INNODB;
CREATE TABLE t_innodb_nopk_nosk(c1 INT NOT NULL, c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_innodb_nopk_sk(c1,c2) VALUES (1, 1), (2,2), (3,3);
INSERT INTO t_innodb_pk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
INSERT INTO t_innodb_nopk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
ANALYZE TABLE t_innodb_nopk_sk, t_innodb_pk_nosk, t_innodb_nopk_nosk;
EXPLAIN SELECT COUNT(*) FROM t_innodb_nopk_sk;
EXPLAIN SELECT COUNT(*) FROM t_innodb_pk_nosk;
EXPLAIN SELECT COUNT(*) FROM t_innodb_nopk_nosk;
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb_nopk_sk;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb_pk_nosk;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb_nopk_nosk;
SHOW STATUS LIKE 'Handler_%';
DROP TABLE t_innodb_pk_nosk, t_innodb_nopk_sk, t_innodb_nopk_nosk;
CREATE TABLE t_heap(c1 INT NOT NULL PRIMARY KEY, c2 INT NOT NULL, c3 char(20)) ENGINE=HEAP;
CREATE TABLE t_archive(c1 INT NOT NULL, c2 char(20)) ENGINE=ARCHIVE;
INSERT INTO t_heap SELECT * FROM t_innodb WHERE c1 > 1;
INSERT INTO t_archive SELECT c1, c3 FROM t_innodb WHERE c1 > 1;
EXPLAIN SELECT COUNT(*) FROM t_heap;
EXPLAIN SELECT COUNT(*) FROM t_innodb, t_heap;
EXPLAIN SELECT COUNT(*) FROM t_archive;
EXPLAIN SELECT COUNT(*) FROM t_innodb, t_archive;
FLUSH STATUS;
SELECT COUNT(*) FROM t_heap;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb, t_heap;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_archive;
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb, t_archive;
SHOW STATUS LIKE 'Handler_%';
DROP TABLE t_archive, t_heap;
EXPLAIN SELECT COUNT(*) FROM t_innodb FORCE INDEX(c3_idx);
EXPLAIN SELECT COUNT(*) FROM t_myisam FORCE INDEX(c3_idx);
FLUSH STATUS;
SELECT COUNT(*) FROM t_innodb FORCE INDEX(c3_idx);
SHOW STATUS LIKE 'Handler_%';
FLUSH STATUS;
SELECT COUNT(*) FROM t_myisam FORCE INDEX(c3_idx);
SHOW STATUS LIKE 'Handler_%';
SELECT COUNT(*) FROM (SELECT DISTINCT c1 FROM t_myisam) dt, t_myisam;
SET @s =1;
SELECT @s, COUNT(*) FROM t_innodb;
set sql_mode='';
SELECT 1 AS c1, (SELECT COUNT(*) FROM t_innodb HAVING c1 > 0) FROM DUAL;
SELECT 1 FROM t_innodb HAVING COUNT(*) > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 7;
EXPLAIN FORMAT=tree SELECT COUNT(*) c FROM t_innodb HAVING c > 7;
EXPLAIN FORMAT=tree SELECT COUNT(*) c FROM t_myisam HAVING c > 7;
SELECT COUNT(*) c FROM t_innodb LIMIT 10 OFFSET 5;
set sql_mode=default;
SELECT SQL_BIG_RESULT COUNT(*) FROM t_innodb;
SELECT SQL_BIG_RESULT COUNT(*) FROM t_innodb, t_myisam;
SELECT /*+ BNL(t2) */ -(t1.c1 + t2.c1) FROM t_innodb t1, t_innodb t2 UNION ALL SELECT COUNT(*) FROM t_innodb;
DROP TABLE t_innodb, t_myisam;