CREATE TABLE t1 (a INT PRIMARY KEY) PARTITION BY RANGE (a) ( PARTITION p0 VALUES LESS THAN (1), PARTITION p1 VALUES LESS THAN (2), PARTITION p2 VALUES LESS THAN (3), PARTITION p3 VALUES LESS THAN (4), PARTITION p4 VALUES LESS THAN (5), PARTITION p5 VALUES LESS THAN (6), PARTITION max VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7),(8);
ANALYZE TABLE t1;
EXPLAIN SELECT * FROM t1 WHERE a <= 1;
EXPLAIN SELECT * FROM t1 WHERE a < 7;
EXPLAIN SELECT * FROM t1 WHERE a <= 1;
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY) PARTITION BY RANGE (a) ( PARTITION p0 VALUES LESS THAN (1), PARTITION p1 VALUES LESS THAN (2), PARTITION p2 VALUES LESS THAN (3), PARTITION p3 VALUES LESS THAN (4), PARTITION p4 VALUES LESS THAN (5), PARTITION p5 VALUES LESS THAN (6), PARTITION max VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7),(8);
ANALYZE TABLE t1;
SELECT * FROM t1 WHERE a < 1;
EXPLAIN SELECT * FROM t1 WHERE a < 1;
SELECT * FROM t1 WHERE a < 2;
EXPLAIN SELECT * FROM t1 WHERE a < 2;
SELECT * FROM t1 WHERE a < 3;
EXPLAIN SELECT * FROM t1 WHERE a < 3;
SELECT * FROM t1 WHERE a < 4;
EXPLAIN SELECT * FROM t1 WHERE a < 4;
SELECT * FROM t1 WHERE a < 5;
EXPLAIN SELECT * FROM t1 WHERE a < 5;
SELECT * FROM t1 WHERE a < 6;
EXPLAIN SELECT * FROM t1 WHERE a < 6;
SELECT * FROM t1 WHERE a < 7;
EXPLAIN SELECT * FROM t1 WHERE a < 7;
SELECT * FROM t1 WHERE a <= 1;
EXPLAIN SELECT * FROM t1 WHERE a <= 1;
SELECT * FROM t1 WHERE a <= 2;
EXPLAIN SELECT * FROM t1 WHERE a <= 2;
SELECT * FROM t1 WHERE a <= 3;
EXPLAIN SELECT * FROM t1 WHERE a <= 3;
SELECT * FROM t1 WHERE a <= 4;
EXPLAIN SELECT * FROM t1 WHERE a <= 4;
SELECT * FROM t1 WHERE a <= 5;
EXPLAIN SELECT * FROM t1 WHERE a <= 5;
SELECT * FROM t1 WHERE a <= 6;
EXPLAIN SELECT * FROM t1 WHERE a <= 6;
SELECT * FROM t1 WHERE a <= 7;
EXPLAIN SELECT * FROM t1 WHERE a <= 7;
SELECT * FROM t1 WHERE a = 1;
EXPLAIN SELECT * FROM t1 WHERE a = 1;
SELECT * FROM t1 WHERE a = 2;
EXPLAIN SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 3;
EXPLAIN SELECT * FROM t1 WHERE a = 3;
SELECT * FROM t1 WHERE a = 4;
EXPLAIN SELECT * FROM t1 WHERE a = 4;
SELECT * FROM t1 WHERE a = 5;
EXPLAIN SELECT * FROM t1 WHERE a = 5;
SELECT * FROM t1 WHERE a = 6;
EXPLAIN SELECT * FROM t1 WHERE a = 6;
SELECT * FROM t1 WHERE a = 7;
EXPLAIN SELECT * FROM t1 WHERE a = 7;
SELECT * FROM t1 WHERE a >= 1;
EXPLAIN SELECT * FROM t1 WHERE a >= 1;
SELECT * FROM t1 WHERE a >= 2;
EXPLAIN SELECT * FROM t1 WHERE a >= 2;
SELECT * FROM t1 WHERE a >= 3;
EXPLAIN SELECT * FROM t1 WHERE a >= 3;
SELECT * FROM t1 WHERE a >= 4;
EXPLAIN SELECT * FROM t1 WHERE a >= 4;
SELECT * FROM t1 WHERE a >= 5;
EXPLAIN SELECT * FROM t1 WHERE a >= 5;
SELECT * FROM t1 WHERE a >= 6;
EXPLAIN SELECT * FROM t1 WHERE a >= 6;
SELECT * FROM t1 WHERE a >= 7;
EXPLAIN SELECT * FROM t1 WHERE a >= 7;
SELECT * FROM t1 WHERE a > 1;
EXPLAIN SELECT * FROM t1 WHERE a > 1;
SELECT * FROM t1 WHERE a > 2;
EXPLAIN SELECT * FROM t1 WHERE a > 2;
SELECT * FROM t1 WHERE a > 3;
EXPLAIN SELECT * FROM t1 WHERE a > 3;
SELECT * FROM t1 WHERE a > 4;
EXPLAIN SELECT * FROM t1 WHERE a > 4;
SELECT * FROM t1 WHERE a > 5;
EXPLAIN SELECT * FROM t1 WHERE a > 5;
SELECT * FROM t1 WHERE a > 6;
EXPLAIN SELECT * FROM t1 WHERE a > 6;
SELECT * FROM t1 WHERE a > 7;
EXPLAIN SELECT * FROM t1 WHERE a > 7;
DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY) PARTITION BY RANGE (a) ( PARTITION p0 VALUES LESS THAN (1), PARTITION p1 VALUES LESS THAN (2), PARTITION p2 VALUES LESS THAN (3), PARTITION p3 VALUES LESS THAN (4), PARTITION p4 VALUES LESS THAN (5), PARTITION max VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (-1),(0),(1),(2),(3),(4),(5),(6),(7);
ANALYZE TABLE t1;
SELECT * FROM t1 WHERE a < 1;
EXPLAIN SELECT * FROM t1 WHERE a < 1;
SELECT * FROM t1 WHERE a < 2;
EXPLAIN SELECT * FROM t1 WHERE a < 2;
SELECT * FROM t1 WHERE a < 3;
EXPLAIN SELECT * FROM t1 WHERE a < 3;
SELECT * FROM t1 WHERE a < 4;
EXPLAIN SELECT * FROM t1 WHERE a < 4;
SELECT * FROM t1 WHERE a < 5;
EXPLAIN SELECT * FROM t1 WHERE a < 5;
SELECT * FROM t1 WHERE a < 6;
EXPLAIN SELECT * FROM t1 WHERE a < 6;
SELECT * FROM t1 WHERE a <= 1;
EXPLAIN SELECT * FROM t1 WHERE a <= 1;
SELECT * FROM t1 WHERE a <= 2;
EXPLAIN SELECT * FROM t1 WHERE a <= 2;
SELECT * FROM t1 WHERE a <= 3;
EXPLAIN SELECT * FROM t1 WHERE a <= 3;
SELECT * FROM t1 WHERE a <= 4;
EXPLAIN SELECT * FROM t1 WHERE a <= 4;
SELECT * FROM t1 WHERE a <= 5;
EXPLAIN SELECT * FROM t1 WHERE a <= 5;
SELECT * FROM t1 WHERE a <= 6;
EXPLAIN SELECT * FROM t1 WHERE a <= 6;
SELECT * FROM t1 WHERE a = 1;
EXPLAIN SELECT * FROM t1 WHERE a = 1;
SELECT * FROM t1 WHERE a = 2;
EXPLAIN SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 3;
EXPLAIN SELECT * FROM t1 WHERE a = 3;
SELECT * FROM t1 WHERE a = 4;
EXPLAIN SELECT * FROM t1 WHERE a = 4;
SELECT * FROM t1 WHERE a = 5;
EXPLAIN SELECT * FROM t1 WHERE a = 5;
SELECT * FROM t1 WHERE a = 6;
EXPLAIN SELECT * FROM t1 WHERE a = 6;
SELECT * FROM t1 WHERE a >= 1;
EXPLAIN SELECT * FROM t1 WHERE a >= 1;
