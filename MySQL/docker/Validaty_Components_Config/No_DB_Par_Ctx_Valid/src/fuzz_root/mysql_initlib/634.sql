CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t1 ORDER BY i;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE SCHEMA s2;
IMPORT TABLE FROM 's2/t1*.sdi';
DROP SCHEMA s2;
IMPORT TABLE FROM 't1_*.sdi';
IMPORT TABLE FROM 's1/t1_*.sdi';
CREATE TABLE t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT i FROM t1 ORDER BY i;
IMPORT TABLE FROM 't1*.sdi';
DROP TABLE t1;
IMPORT TABLE FROM 'pattern_which_matches_nothing';
IMPORT TABLE FROM '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/mysql-test/t/import.test';
CREATE TABLE t1 (i int) ENGINE MYISAM;
IMPORT TABLE FROM 't1.MYD';
IMPORT TABLE FROM 't1.sdi';
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE MYISAM;
DROP TABLE t1;
CREATE TABLE t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO t1 VALUES ('AAA'), ('BBB'), ('CCC');
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE t1;
IMPORT TABLE FROM 't1_*.sdi';
IMPORT TABLE FROM 't1_*.sdi';
REPAIR TABLE t1;
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE MYISAM;
LOCK TABLES t1 WRITE;
SET @@session.lock_wait_timeout= 1;
IMPORT TABLE FROM 't1_*.sdi';
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE=MYISAM;
IMPORT TABLE FROM 't1_.sdi';
DROP TABLE t1;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i INT) ENGINE MYISAM;
IMPORT TABLE FROM 's1/t1_*.sdi';
IMPORT TABLE FROM 's1/t1_*.sdi';
IMPORT TABLE FROM 't1_*.sdi';
IMPORT TABLE FROM 't1_*.sdi';
IMPORT TABLE FROM 't1_*.sdi';
IMPORT TABLE FROM 't1_*.sdi';
DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE TABLE t1 (i INT) ENGINE=MYISAM;
INSERT INTO t1 VALUES (1), (3), (5);
SELECT * FROM t1;
CREATE TABLE t2 (i INT) ENGINE=MYISAM;
INSERT INTO t2 VALUES (2), (4), (6);
SELECT * FROM t2;
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT * FROM v2;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE t1;
DROP TABLE t2;
CHECK TABLE v2;
IMPORT TABLE FROM 't1_*.sdi', 't2_*.sdi';
SHOW CREATE TABLE t1;
SHOW CREATE TABLE t2;
SELECT * FROM t1;
SELECT * FROM t2;
CHECK TABLE v2;
SELECT * FROM v2;
DROP VIEW v2;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (i INT) ENGINE MYISAM;
INSERT INTO t1 VALUES (1), (3), (5);
SELECT * FROM t1 ORDER BY i;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE t1;
IMPORT TABLE FROM 't1_.sdi';
SELECT * FROM t1 ORDER BY k;
DROP TABLE t1;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t1 ORDER BY i;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE s1.t1;
ALTER SCHEMA s1 DEFAULT COLLATE latin1_bin;
IMPORT TABLE FROM 's1/t1*.sdi';
SELECT i FROM s1.t1 ORDER BY i;
SHOW CREATE TABLE s1.t1;
CREATE TABLE s1.t2(i VARCHAR(32));
INSERT INTO s1.t2 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t2 ORDER BY i;
SHOW CREATE TABLE s1.t2;
DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT i FROM s1.t1 ORDER BY i;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
DROP TABLE s1.t1;
DROP SCHEMA s1;