CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (10),(11),(12),(13),(14),(15),(16),(17),(18),(19), (20),(21),(22),(23),(24),(25),(26),(27),(28),(29), (30),(31),(32),(33),(34),(35);
CREATE TABLE t2(a INT, i INT PRIMARY KEY);
INSERT INTO t2 (i) SELECT i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i;
DROP TABLE t2;
CREATE TABLE t2(a INT, i CHAR(2), INDEX(i(1)));
INSERT INTO t2 (i) SELECT i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i;
DROP TABLE t2;
CREATE TABLE t2(a INT, b INT, c INT, d INT, INDEX(a, b, c));
INSERT INTO t2 (a, b, c) SELECT i, i, i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 12;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 12;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT 1 - COUNT(*) FROM t2 WHERE b = 10;
DROP TABLE t2;
CREATE TABLE t2(a INT, b INT, c INT, d INT, INDEX(a, b, c));
INSERT INTO t2 (a, b, c) SELECT i, i, i FROM t1;
INSERT INTO t2 (a, b, c) SELECT t1.i, t1.i, t1.i FROM t1, t1 x1, t1 x2;
FLUSH STATUS;
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 12;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 12;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT 677 - COUNT(*) FROM t2 WHERE b = 10;
DROP TABLE t2;
CREATE TABLE t2 (a CHAR(2), b CHAR(2), c CHAR(2), d CHAR(2), INDEX (a,b(1),c));
INSERT INTO t2 SELECT i, i, i, i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c;
DROP TABLE t2;
CREATE TABLE t2 (a CHAR(2), b CHAR(2), c CHAR(2), d CHAR(2), INDEX (a,b,c)) ENGINE=HEAP;
INSERT INTO t2 SELECT i, i, i, i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 5;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE b = 10 ORDER BY a, c LIMIT 5;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE b = 10 ORDER BY a, c;
DROP TABLE t2;
CREATE TABLE t2 (i INT, key1 INT, key2 INT, INDEX (key1), INDEX (key2)) ENGINE= MyISAM;
INSERT INTO t2 (key1, key2) SELECT i, i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE key1 < 13 or key2 < 14 ORDER BY key1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
EXPLAIN SELECT * FROM t2 WHERE key1 < 13 or key2 < 14 ORDER BY key1;
FLUSH STATUS;
DELETE FROM t2 WHERE key1 < 13 or key2 < 14 ORDER BY key1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE key1 < 13 or key2 < 14 ORDER BY key1;
EXPLAIN SELECT * FROM t2 WHERE key1 < 13 or key2 < 14 ORDER BY key1;
DROP TABLE t2;
CREATE TABLE t2(a INT, i INT PRIMARY KEY);
INSERT INTO t2 (i) SELECT i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i DESC LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i DESC LIMIT 1;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 WHERE i > 10 AND i <= 18 ORDER BY i;
DROP TABLE t2;
CREATE TABLE t2 (a CHAR(2), b CHAR(2), c CHAR(2), INDEX (a, b));
INSERT INTO t2 SELECT i, i, i FROM t1;
FLUSH STATUS;
SELECT * FROM t2 ORDER BY a, b DESC LIMIT 5;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
DELETE FROM t2 ORDER BY a, b DESC LIMIT 5;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
SELECT * FROM t2 ORDER BY a, b DESC;
DROP TABLE t2;
CREATE TABLE t2 (a CHAR(2), b CHAR(2), c CHAR(2), INDEX (a, b));
INSERT INTO t2 (a, b) SELECT i, i FROM t1;
INSERT INTO t2 (a, b) SELECT t1.i, t1.i FROM t1, t1 x1, t1 x2;
FLUSH STATUS;
SELECT * FROM t2 ORDER BY a, b LIMIT 5;
SHOW SESSION STATUS LIKE 'Sort%';
SHOW STATUS LIKE 'Handler_read_%';
FLUSH STATUS;
SELECT * FROM t2 ORDER BY a DESC, b DESC LIMIT 5;
