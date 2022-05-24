DROP TABLE IF EXISTS t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;
CREATE TABLE t0 (a int, b int, c int);
CREATE TABLE t1 (a int, b int, c int);
CREATE TABLE t2 (a int, b int, c int);
CREATE TABLE t3 (a int, b int, c int);
CREATE TABLE t4 (a int, b int, c int);
CREATE TABLE t5 (a int, b int, c int);
CREATE TABLE t6 (a int, b int, c int);
CREATE TABLE t7 (a int, b int, c int);
CREATE TABLE t8 (a int, b int, c int);
CREATE TABLE t9 (a int, b int, c int);
INSERT INTO t0 VALUES (1,1,0), (1,2,0), (2,2,0);
INSERT INTO t1 VALUES (1,3,0), (2,2,0), (3,2,0);
INSERT INTO t2 VALUES (3,3,0), (4,2,0), (5,3,0);
INSERT INTO t3 VALUES (1,2,0), (2,2,0);
INSERT INTO t4 VALUES (3,2,0), (4,2,0);
INSERT INTO t5 VALUES (3,1,0), (2,2,0), (3,3,0);
INSERT INTO t6 VALUES (3,2,0), (6,2,0), (6,1,0);
INSERT INTO t7 VALUES (1,1,0), (2,2,0);
INSERT INTO t8 VALUES (0,2,0), (1,2,0);
INSERT INTO t9 VALUES (1,1,0), (1,2,0), (3,3,0);
CREATE TABLE t34 (a3 int, b3 int, c3 int, a4 int, b4 int, c4 int);
INSERT INTO t34 SELECT t3.*, t4.* FROM t3 CROSS JOIN t4;
CREATE TABLE t345 (a3 int, b3 int, c3 int, a4 int, b4 int, c4 int, a5 int, b5 int, c5 int);
INSERT INTO t345 SELECT t3.*, t4.*, t5.* FROM t3 CROSS JOIN t4 CROSS JOIN t5;
CREATE TABLE t67 (a6 int, b6 int, c6 int, a7 int, b7 int, c7 int);
INSERT INTO t67 SELECT t6.*, t7.* FROM t6 CROSS JOIN t7;
SELECT t2.a,t2.b FROM t2;
SELECT t3.a,t3.b FROM t3;
SELECT t4.a,t4.b FROM t4;
SELECT t3.a,t3.b,t4.a,t4.b FROM t3,t4;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t2.b=t4.b;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4 FROM t2 LEFT JOIN t34 ON t2.b=t34.b4;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4 FROM t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4;
ANALYZE TABLE t1, t2, t3, t4;
EXPLAIN SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t2.b=t4.b WHERE t3.a=1 OR t3.c IS NULL;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t2.b=t4.b WHERE t3.a=1 OR t3.c IS NULL;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4 FROM t2 LEFT JOIN t34 ON t2.b=t34.b4 WHERE t34.a3=1 OR t34.c3 IS NULL;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t2.b=t4.b WHERE t3.a>1 OR t3.c IS NULL;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4 FROM t2 LEFT JOIN t34 ON t2.b=t34.b4 WHERE t34.a3>1 OR t34.c3 IS NULL;
SELECT t5.a,t5.b FROM t5;
SELECT t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t3,t4,t5;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t2 LEFT JOIN               (t3, t4, t5) ON t2.b=t4.b;
SELECT t2.a,t2.b,t345.a3,t345.b3,t345.a4,t345.b4,t345.a5,t345.b5 FROM t2 LEFT JOIN t345 ON t2.b=t345.b4;
ANALYZE TABLE t2, t3, t4, t5;
EXPLAIN SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t2 LEFT JOIN               (t3, t4, t5) ON t2.b=t4.b WHERE t3.a>1 OR t3.c IS NULL;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t2 LEFT JOIN               (t3, t4, t5) ON t2.b=t4.b WHERE t3.a>1 OR t3.c IS NULL;
SELECT t2.a,t2.b,t345.a3,t345.b3,t345.a4,t345.b4,t345.a5,t345.b5 FROM t2 LEFT JOIN t345 ON t2.b=t345.b4 WHERE t345.a3>1 OR t345.c3 IS NULL;
ANALYZE TABLE t2, t3, t4, t5;
EXPLAIN SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t2 LEFT JOIN               (t3, t4, t5) ON t2.b=t4.b WHERE (t3.a>1 OR t3.c IS NULL) AND  (t5.a<3 OR t5.c IS NULL);
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b,t5.a,t5.b FROM t2 LEFT JOIN               (t3, t4, t5) ON t2.b=t4.b WHERE (t3.a>1 OR t3.c IS NULL) AND  (t5.a<3 OR t5.c IS NULL);
SELECT t2.a,t2.b,t345.a3,t345.b3,t345.a4,t345.b4,t345.a5,t345.b5 FROM t2 LEFT JOIN t345 ON t2.b=t345.b4 WHERE (t345.a3>1 OR t345.c3 IS NULL) AND  (t345.a5<3 OR t345.c5 IS NULL);
SELECT t6.a,t6.b FROM t6;
SELECT t7.a,t7.b FROM t7;
SELECT t6.a,t6.b,t7.a,t7.b FROM t6,t7;
SELECT t8.a,t8.b FROM t8;
ANALYZE TABLE t6, t7, t8;
EXPLAIN SELECT t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10;
SELECT t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10;
SELECT t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10;
SELECT t5.a,t5.b FROM t5;
SELECT t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b;
SELECT t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7;
SELECT t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b AND (t8.a < 1 OR t8.c IS NULL);
SELECT t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7 AND (t8.a < 1 OR t8.c IS NULL);
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4 FROM t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b;
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4, t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4 CROSS JOIN t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b WHERE t2.a > 3 AND (t6.a < 6 OR t6.c IS NULL);
SELECT t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4, t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4 CROSS JOIN t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7 WHERE t2.a > 3 AND (t67.a6 < 6 OR t67.c6 IS NULL);
SELECT t1.a,t1.b FROM t1;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t1 LEFT JOIN                 (  t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b  ) ON (t3.b=2 OR t3.c IS NULL) AND (t6.b=2 OR t6.c IS NULL) AND (t1.b=t5.b OR t3.c IS NULL OR t6.c IS NULL or t8.c IS NULL) AND (t1.a != 2);
SELECT t1.a,t1.b,t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4, t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t1 LEFT JOIN                 (  t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4 CROSS JOIN t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7  ) ON (t34.b3=2 OR t34.c3 IS NULL) AND (t67.b6=2 OR t67.c6 IS NULL) AND (t1.b=t5.b OR t34.c3 IS NULL OR t67.c6 IS NULL or t8.c IS NULL) AND (t1.a <> 2);
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t1 LEFT JOIN                 (  t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b  ) ON (t3.b=2 OR t3.c IS NULL) AND (t6.b=2 OR t6.c IS NULL) AND (t1.b=t5.b OR t3.c IS NULL OR t6.c IS NULL or t8.c IS NULL) AND (t1.a != 2) WHERE (t2.a >= 4 OR t2.c IS NULL);
SELECT t1.a,t1.b,t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4, t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t1 LEFT JOIN                 (  t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4 CROSS JOIN t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7  ) ON (t34.b3=2 OR t34.c3 IS NULL) AND (t67.b6=2 OR t67.c6 IS NULL) AND (t1.b=t5.b OR t34.c3 IS NULL OR t67.c6 IS NULL or t8.c IS NULL) AND (t1.a <> 2) WHERE (t2.a >= 4 OR t2.c IS NULL);
SELECT t0.a,t0.b FROM t0;
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8;
EXPLAIN SELECT t0.a,t0.b,t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t0,t1 LEFT JOIN                 (  t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b  ) ON (t3.b=2 OR t3.c IS NULL) AND (t6.b=2 OR t6.c IS NULL) AND (t1.b=t5.b OR t3.c IS NULL OR t6.c IS NULL or t8.c IS NULL) AND (t1.a != 2) WHERE t0.a=1 AND t0.b=t1.b AND           (t2.a >= 4 OR t2.c IS NULL);
SELECT t0.a,t0.b,t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b, t5.a,t5.b,t6.a,t6.b,t7.a,t7.b,t8.a,t8.b FROM t0,t1 LEFT JOIN                 (  t2 LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b, t5  LEFT JOIN  (  (t6, t7) LEFT JOIN  t8 ON t7.b=t8.b AND t6.b < 10 ) ON t6.b >= 2 AND t5.b=t7.b  ) ON (t3.b=2 OR t3.c IS NULL) AND (t6.b=2 OR t6.c IS NULL) AND (t1.b=t5.b OR t3.c IS NULL OR t6.c IS NULL or t8.c IS NULL) AND (t1.a != 2) WHERE t0.a=1 AND t0.b=t1.b AND           (t2.a >= 4 OR t2.c IS NULL);
SELECT t0.a,t0.b,t1.a,t1.b,t2.a,t2.b,t34.a3,t34.b3,t34.a4,t34.b4, t5.a,t5.b,t67.a6,t67.b6,t67.a7,t67.b7,t8.a,t8.b FROM t0 CROSS JOIN t1 LEFT JOIN                 (  t2 LEFT JOIN t34 ON t34.a3=1 AND t2.b=t34.b4 CROSS JOIN t5  LEFT JOIN  (  t67 LEFT JOIN  t8 ON t67.b7=t8.b AND t67.b6 < 10 ) ON t67.b6 >= 2 AND t5.b=t67.b7  ) ON (t34.b3=2 OR t34.c3 IS NULL) AND (t67.b6=2 OR t67.c6 IS NULL) AND (t1.b=t5.b OR t34.c3 IS NULL OR t67.c6 IS NULL or t8.c IS NULL) AND (t1.a <> 2) WHERE t0.a=1 AND t0.b=t1.b AND           (t2.a >= 4 OR t2.c IS NULL);
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
SELECT t9.a,t9.b FROM t9;
SELECT t1.a,t1.b FROM t1;
SELECT t2.a,t2.b FROM t2;
SELECT t3.a,t3.b FROM t3;
SELECT t2.a,t2.b,t3.a,t3.b FROM t2  LEFT JOIN               t3 ON t2.b=t3.b;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b FROM t1, t2  LEFT JOIN               t3 ON t2.b=t3.b WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b FROM t1 CROSS JOIN t2 LEFT JOIN               t3 ON t2.b=t3.b WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b FROM t1, t3  RIGHT JOIN               t2 ON t2.b=t3.b WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b FROM t1 CROSS JOIN ( t3 RIGHT JOIN               t2 ON t2.b=t3.b ) WHERE t1.a <= 2;
SELECT t3.a,t3.b,t4.a,t4.b FROM t3,t4;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2  LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t2 LEFT JOIN               (t3 CROSS JOIN t4) ON t3.a=1 AND t2.b=t4.b;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1 CROSS JOIN ( t2  LEFT JOIN               (t3, t4) ON t3.a=1 AND t2.b=t4.b ) WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1 CROSS JOIN ( t2 LEFT JOIN               (t3 CROSS JOIN t4) ON t3.a=1 AND t2.b=t4.b ) WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1, (t3, t4)  RIGHT JOIN               t2 ON t3.a=1 AND t2.b=t4.b WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1 CROSS JOIN ( (t3 CROSS JOIN t4) RIGHT JOIN               t2 ON t3.a=1 AND t2.b=t4.b ) WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1, (t3, t4) RIGHT JOIN               t2 ON t3.a=1 AND t2.b=t4.b WHERE t1.a <= 2;
SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1 CROSS JOIN ( (t3 CROSS JOIN t4) RIGHT JOIN               t2 ON t3.a=1 AND t2.b=t4.b ) WHERE t1.a <= 2;
EXPLAIN SELECT t1.a,t1.b,t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM t1, (t3, t4) RIGHT JOIN t2 ON t3.a=1 AND t2.b=t4.b WHERE t1.a <= 2;
CREATE INDEX idx_b ON t2(b);
EXPLAIN SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM (t3,t4) LEFT JOIN               (t1,t2) ON t3.a=1 AND t3.b=t2.b AND t2.b=t4.b;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM (t3,t4) LEFT JOIN               (t1,t2) ON t3.a=1 AND t3.b=t2.b AND t2.b=t4.b;
SELECT t2.a,t2.b,t3.a,t3.b,t4.a,t4.b FROM (t3 CROSS JOIN t4) LEFT JOIN               (t1 CROSS JOIN t2) ON t3.a=1 AND t3.b=t2.b AND t2.b=t4.b;
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
CREATE INDEX idx_b ON t4(b);
CREATE INDEX idx_b ON t5(b);
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
CREATE INDEX idx_b ON t8(b);
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
CREATE INDEX idx_b ON t1(b);
CREATE INDEX idx_a ON t0(a);
ANALYZE TABLE t0, t1, t2, t3, t4, t5, t6, t7, t8, t9;
SELECT t2.a,t2.b FROM t2;
SELECT t3.a,t3.b FROM t3;
SELECT t2.a,t2.b,t3.a,t3.b FROM t2 LEFT JOIN t3 ON t2.b=t3.b WHERE t2.a = 4 OR (t2.a > 4 AND t3.a IS NULL);
SELECT t2.a,t2.b,t3.a,t3.b FROM t2 LEFT JOIN (t3) ON t2.b=t3.b WHERE t2.a = 4 OR (t2.a > 4 AND t3.a IS NULL);
ALTER TABLE t3 CHANGE COLUMN a a1 int, CHANGE COLUMN c c1 int;
SELECT t2.a,t2.b,t3.a1,t3.b FROM t2 LEFT JOIN t3 ON t2.b=t3.b WHERE t2.a = 4 OR (t2.a > 4 AND t3.a1 IS NULL);
SELECT t2.a,t2.b,t3.a1,t3.b FROM t2 NATURAL LEFT JOIN t3 WHERE t2.a = 4 OR (t2.a > 4 AND t3.a1 IS NULL);
