CREATE TABLE t1 (f1 INT NOT NULL);
INSERT INTO t1 VALUES (9),(0), (7);
CREATE TABLE t2 (f1 INT NOT NULL);
INSERT INTO t2 VALUES (5),(3),(0),(3),(1),(0),(1),(7),(1),(0),(0),(8),(4),(9),(0),(2),(0),(8),(5),(1);
CREATE TABLE t3 (f1 INT NOT NULL);
INSERT INTO t3 VALUES (9),(0), (7), (4), (5);
CREATE TABLE t4 (f1 INT NOT NULL);
INSERT INTO t4 VALUES (0), (7);
CREATE TABLE t5 (f1 INT NOT NULL, PRIMARY KEY(f1));
INSERT INTO t5 VALUES (7);
CREATE TABLE t6(f1 INT NOT NULL, PRIMARY KEY(f1));
INSERT INTO t6 VALUES (7);
ANALYZE TABLE t1, t2, t3, t4, t5, t6;
SELECT count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT /*+ QB_NAME(q1) JOIN_PREFIX(t3, t2, t2@subq2) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t2) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t2);
SELECT /*+ JOIN_PREFIX(t3, t2, t1) JOIN_PREFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_PREFIX(t3, t2, t1) JOIN_PREFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_SUFFIX(t3, t2) JOIN_SUFFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_SUFFIX(t3, t2) JOIN_SUFFIX(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t1, t2, t5) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t1, t2, t5) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t1, t7, t5) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t1, t7, t5) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1) JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) */ count(*)  FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1) JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) */ count(*)  FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t2, t3) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t3, t2) JOIN_ORDER(t2, t3) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t3, t2) JOIN_SUFFIX(t3) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t3, t2) JOIN_SUFFIX(t3) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t3, t2) JOIN_PREFIX(t2) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t3, t2) JOIN_PREFIX(t2) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) JOIN_PREFIX(t2, t5@subq2, t4@subq1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t4@subq1, t3) JOIN_SUFFIX(t1) JOIN_PREFIX(t2, t5@subq2, t4@subq1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+  JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1) JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1) JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+  JOIN_SUFFIX(t2, t5@subq2, t4@subq1, t3, t1) JOIN_ORDER(t2, t5@subq2, t4@subq1, t3, t1) JOIN_PREFIX(t2, t5@subq2, t4@subq1, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT STRAIGHT_JOIN /*+  QB_NAME(q1) JOIN_ORDER(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT STRAIGHT_JOIN /*+  QB_NAME(q1) JOIN_ORDER(t2, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+  QB_NAME(q1) JOIN_FIXED_ORDER(@q1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+  QB_NAME(q1) JOIN_FIXED_ORDER(@q1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+  QB_NAME(q1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+  QB_NAME(q1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
SELECT /*+ JOIN_PREFIX(t3, t1) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT /*+ JOIN_PREFIX(t3, t1) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
SELECT /*+ JOIN_PREFIX(t1, t2, t3) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT /*+ JOIN_PREFIX(t1, t2, t3) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
SELECT /*+ JOIN_SUFFIX(t4, t5) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
explain SELECT /*+ JOIN_SUFFIX(t4, t5) */ count(*) FROM t1 JOIN t2 STRAIGHT_JOIN t3 WHERE t1.f1 IN (SELECT f1 FROM t4) AND t2.f1 IN (SELECT f1 FROM t5);
SELECT /*+ QB_NAME(q1) JOIN_ORDER(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ QB_NAME(q1) JOIN_ORDER(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ QB_NAME(q1) JOIN_PREFIX(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ QB_NAME(q1) JOIN_PREFIX(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
SELECT /*+ QB_NAME(q1) JOIN_SUFFIX(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
explain SELECT /*+ QB_NAME(q1) JOIN_SUFFIX(@q1 t2, t3, t1) */ count(*) FROM t1 JOIN t2 JOIN t3 WHERE t1.f1 IN (SELECT /*+ QB_NAME(subq1) */ f1 FROM t4) AND t2.f1 IN (SELECT /*+ QB_NAME(subq2) */ f1 FROM t5);
DROP TABLE t1, t2, t3, t4 ,t5, t6;
CREATE TABLE t1 (f1 INT);
CREATE TABLE t2 (f1 INT);
CREATE TABLE t3 (f1 INT);
CREATE TABLE t4 (f1 INT);
EXPLAIN SELECT /*+ JOIN_ORDER(t2, t4, t1)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_ORDER(t2, t1, t4)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_ORDER(t4, t1, t2)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_ORDER(t3, t4)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_ORDER(t4, t3)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_SUFFIX(t1)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
EXPLAIN SELECT /*+ JOIN_SUFFIX(t2, t1)  */ 1  FROM t1 JOIN t2 ON 1 RIGHT JOIN t3 ON 1 JOIN t4 ON  1;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 ( f1 INT(11) NOT NULL AUTO_INCREMENT, PRIMARY KEY (f1) );
CREATE TABLE t2 ( f1 INT(11) DEFAULT NULL );
CREATE TABLE t3 ( f1 INT(11) DEFAULT NULL );
EXPLAIN DELETE FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
EXPLAIN DELETE /*+ JOIN_PREFIX(t2, t3, ta2) */ FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
EXPLAIN DELETE /*+ JOIN_PREFIX(t2, t3, ta1, ta2) */ FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
EXPLAIN DELETE /*+ JOIN_PREFIX(t2, t3, ta2, ta1) */ FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
EXPLAIN DELETE /*+ JOIN_SUFFIX(ta2, t3, ta1) */ FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
EXPLAIN DELETE /*+ JOIN_PREFIX(ta1, t2, t3) JOIN_SUFFIX(t3, ta2) */ FROM ta1.* USING t1 AS ta1 JOIN t1 AS ta2 ON 1 RIGHT OUTER JOIN t2 ON (ta1.f1 = t2.f1) WHERE (9) IN (SELECT f1 FROM t3);
DROP TABLE t1, t2, t3;
CREATE TABLE t1(f1 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1);
CREATE TABLE t2(f1 INT) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1);
EXPLAIN SELECT /*+ JOIN_PREFIX(t1, t2)  */ 1 FROM t1 JOIN t2 ON t1.f1 = t2.f1;
EXPLAIN SELECT /*+ JOIN_PREFIX(t2, t1)  */ 1 FROM t1 JOIN t2 ON t1.f1 = t2.f1;
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 int(11) NOT NULL AUTO_INCREMENT, f2 varchar(255) DEFAULT NULL, PRIMARY KEY (f1));
CREATE TABLE t2 ( f1 int(11) NOT NULL AUTO_INCREMENT, f2 varchar(255) CHARACTER SET utf8 DEFAULT NULL, f3 varchar(10) DEFAULT NULL, PRIMARY KEY (f1), KEY f3(f3));
EXPLAIN SELECT /*+ JOIN_SUFFIX(t1, t2) */ t2.f3 FROM t2 LEFT JOIN t1 ON t2.f1 = t1.f1 WHERE t1.f2 NOT LIKE ('FMGAU') OR t2.f2 > 't';
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 int(11) DEFAULT NULL, KEY f1 (f1) );
CREATE TABLE t2 ( f1 int(11) DEFAULT NULL, f2 varchar(255) CHARACTER SET utf8 DEFAULT NULL, KEY f2 (f2), KEY f1 (f1) );
CREATE TABLE t3 ( f1 int(11) DEFAULT NULL, f2 varchar(255) CHARACTER SET cp932 DEFAULT NULL, KEY f1 (f1), KEY f2 (f2) );
EXPLAIN SELECT /*+ JOIN_ORDER(t2, t3) JOIN_ORDER(t1, t2)  */ t3.f1 FROM ( t2 INNER JOIN t3 ON t3.f2 = t2.f2 LEFT JOIN t1 ON t1.f1 = t3.f1 ) WHERE NOT (t2.f1 >= 7);
EXPLAIN SELECT /*+ JOIN_ORDER(t1, t2)  JOIN_ORDER(t2, t3) */ t3.f1 FROM ( t2 INNER JOIN t3 ON t3.f2 = t2.f2 LEFT JOIN t1 ON t1.f1 = t3.f1 ) WHERE NOT (t2.f1 >= 7);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( f1 INT(11) NOT NULL AUTO_INCREMENT, f2 INT(11) DEFAULT NULL, PRIMARY KEY (f1) );
CREATE TABLE t2 ( f1 INT(11) NOT NULL AUTO_INCREMENT, PRIMARY KEY (f1) );
EXPLAIN SELECT /*+ JOIN_PREFIX(t1, t1) */ t2.f1 FROM t1 JOIN t2 ON t1.f2 = t2.f1;
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 DATETIME, f2 DATE, f3 VARCHAR(1), KEY (f1) ) ENGINE=myisam;
CREATE TABLE t2 ( f1 VARCHAR(1), f2 INT, f3 VARCHAR(1), KEY (f1) ) ENGINE=innodb;
CREATE TABLE t3 ( f1 VARCHAR(1), f2 DATE, f3 DATETIME, f4 INT ) ENGINE=myisam;
EXPLAIN UPDATE /*+ JOIN_ORDER(t2, als1, als3) JOIN_FIXED_ORDER()  */ t3 AS als1 JOIN t1 AS als2 ON (als1.f3 = als2 .f1) JOIN t1 AS als3 ON (als1.f1 = als3.f3) RIGHT OUTER JOIN t3 AS als4 ON (als1.f3 = als4.f2) SET als1.f4 = 'eogqjvbhzodzimqahyzlktkbexkhdwxwgifikhcgblhgswxyutepc' WHERE ('i','b') IN (SELECT f3, f1 FROM t2 WHERE f2 <> f2 AND als2.f2 IS NULL);
DROP TABLE t1, t2, t3;
CREATE TABLE t1( f1 VARCHAR(1)) ENGINE=myisam;
CREATE TABLE t2( f1 VARCHAR(1), f2 VARCHAR(1), f3 DATETIME, KEY(f2)) ENGINE=innodb;
CREATE TABLE t3( f1 INT, f2 DATE, f3 VARCHAR(1), KEY(f3)) ENGINE=myisam;
CREATE TABLE t4( f1 VARCHAR(1), KEY(f1)) ENGINE=innodb;
ALTER TABLE t4 DISABLE KEYS;
INSERT INTO t4 VALUES ('x'), (NULL), ('d'), ('x'), ('u');
ALTER TABLE t4 ENABLE KEYS;
CREATE TABLE t5( f1 VARCHAR(1), KEY(f1) ) ENGINE=myisam;
INSERT INTO t5 VALUES  (NULL), ('s'), ('c'), ('x'), ('z');
EXPLAIN UPDATE /*+ JOIN_ORDER(t4, alias1, alias3)  */ t3 AS alias1 JOIN t5 ON (alias1.f3 = t5.f1) JOIN t3 AS alias3 ON (alias1.f2 = alias3.f2 ) RIGHT OUTER JOIN t1 ON (alias1.f3 = t1.f1) SET alias1.f1 = -1 WHERE ( 'v', 'o' )  IN (SELECT DISTINCT t2.f1, t2.f2 FROM t4 RIGHT OUTER JOIN t2 ON (t4.f1 = t2.f1) WHERE t2.f3 BETWEEN '2001-10-04' AND '2003-05-15');
DROP TABLE t1, t2, t3, t4, t5;
