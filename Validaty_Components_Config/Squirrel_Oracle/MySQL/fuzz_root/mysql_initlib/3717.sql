CREATE TABLE t1(f1 INT, f2 INT);
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
CREATE TABLE t2(f1 INT NOT NULL, f2 INT NOT NULL, f3 CHAR(200), KEY(f1, f2));
INSERT INTO t2 VALUES (1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'), (2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'), (3,1, 'qwerty'),(3,4, 'qwerty'), (4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty'), (1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'), (2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'), (3,1, 'qwerty'),(3,4, 'qwerty'), (4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty');
CREATE TABLE t3 (f1 INT NOT NULL, f2 INT, f3 VARCHAR(32), PRIMARY KEY(f1), KEY f2_idx(f1), KEY f3_idx(f3));
INSERT INTO t3 VALUES (1, 1, 'qwerty'), (2, 1, 'ytrewq'), (3, 2, 'uiop'), (4, 2, 'poiu'), (5, 2, 'lkjh'), (6, 2, 'uiop'), (7, 2, 'poiu'), (8, 2, 'lkjh'), (9, 2, 'uiop'), (10, 2, 'poiu'), (11, 2, 'lkjh'), (12, 2, 'uiop'), (13, 2, 'poiu'), (14, 2, 'lkjh');
INSERT INTO t3 SELECT f1 + 20, f2, f3 FROM t3;
INSERT INTO t3 SELECT f1 + 40, f2, f3 FROM t3;
ANALYZE TABLE t1;
ANALYZE TABLE t2;
ANALYZE TABLE t3;
set optimizer_switch=default;
FLUSH STATUS;
SELECT f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
SHOW STATUS LIKE 'handler_read%';
FLUSH STATUS;
SELECT /*+ NO_RANGE_OPTIMIZATION(t3) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
EXPLAIN SELECT /*+ NO_RANGE_OPTIMIZATION(t3 PRIMARY) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
EXPLAIN SELECT /*+ NO_RANGE_OPTIMIZATION(t3 PRIMARY, f2_idx) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
EXPLAIN SELECT /*+ NO_RANGE_OPTIMIZATION(t3) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
EXPLAIN SELECT /*+ NO_RANGE_OPTIMIZATION(t3 PRIMARY) NO_RANGE_OPTIMIZATION(t3 f2_idx) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
set optimizer_switch='index_condition_pushdown=on';
EXPLAIN SELECT  f2 FROM (SELECT f2, f3, f1 FROM t3 WHERE f1 > 27 AND f3 = 'poiu') AS TD WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
EXPLAIN SELECT /*+ NO_ICP(t3@qb1 f3_idx) */ f2 FROM (SELECT /*+ QB_NAME(QB1) */ f2, f3, f1 FROM t3 WHERE f1 > 27 AND f3 = 'poiu') AS TD WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
EXPLAIN SELECT /*+ NO_ICP(t3@qb1) */ f2 FROM (SELECT /*+ QB_NAME(QB1) */ f2, f3, f1 FROM t3 WHERE f1 > 27 AND f3 = 'poiu') AS TD WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
EXPLAIN SELECT f2 FROM (SELECT /*+ NO_ICP(t3 f3_idx, f1_idx, f2_idx) */ f2, f3, f1 FROM t3 WHERE f1 > 27 AND f3 = 'poiu') AS TD WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
EXPLAIN SELECT f2 FROM (SELECT /*+ NO_ICP(t3 f1_idx, f2_idx) */ f2, f3, f1 FROM t3 WHERE f1 > 27 AND f3 = 'poiu') AS TD WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
set optimizer_switch=default;
set optimizer_switch='batched_key_access=off,mrr_cost_based=off';
FLUSH STATUS;
SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
SHOW STATUS LIKE 'handler_read%';
FLUSH STATUS;
SELECT /*+ BKA() */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA() */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t1, t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ QB_NAME(QB1) BKA(t2@QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
set optimizer_switch='batched_key_access=off,mrr_cost_based=on';
EXPLAIN SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA() */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t1, t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ QB_NAME(QB1) BKA(t2@QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
set optimizer_switch='batched_key_access=on,mrr_cost_based=off';
EXPLAIN SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
set optimizer_switch='mrr=off';
EXPLAIN SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
set optimizer_switch='mrr=on';
EXPLAIN SELECT /*+ NO_BKA(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ NO_BKA() */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ NO_BKA(t1, t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ QB_NAME(QB1) NO_BKA(t2@QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
set optimizer_switch='batched_key_access=off,mrr_cost_based=off,semijoin=off,materialization=off';
EXPLAIN UPDATE t3 SET f3 = 'mnbv' WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN (SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN UPDATE /*+ NO_RANGE_OPTIMIZATION(t3 PRIMARY) */ t3 SET f3 = 'mnbv' WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN (SELECT /*+ BKA(t2) NO_BNL(t1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN DELETE FROM t3 WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN (SELECT /*+ QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN DELETE /*+ NO_RANGE_OPTIMIZATION(t3 PRIMARY, f2_idx) NO_BNL(t1@QB1) */ FROM t3 WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN (SELECT /*+ QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN INSERT INTO t3(f1, f2, f3) (SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN INSERT INTO t3(f1, f2, f3) (SELECT /*+ NO_ICP(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN INSERT /*+ NO_ICP(t2@QB1 f1) */ INTO t3(f1, f2, f3) (SELECT /*+ QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN REPLACE INTO t3(f1, f2, f3) (SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN REPLACE INTO t3(f1, f2, f3) (SELECT /*+ NO_ICP(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
EXPLAIN REPLACE /*+ NO_ICP(t2@qb1) */ INTO t3(f1, f2, f3) SELECT /*+ QB_NAME(qb2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN REPLACE /*+ NO_ICP(t2@qb1) */ INTO t3(f1, f2, f3) SELECT /*+ QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ QB_NAME(qb1) QB_NAME(qb1 ) */ * FROM t2;
EXPLAIN SELECT /*+ BKA(@qb1) QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
PREPARE stmt1 FROM "SELECT /*+ BKA(t2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1";
EXECUTE stmt1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
EXPLAIN SELECT tbl2.f1, tbl2.f2, tbl2.f3 FROM t1 tbl1,t2 tbl2 WHERE tbl1.f1=tbl2.f1 AND tbl2.f2 BETWEEN tbl1.f1 and tbl1.f2 and tbl2.f2 + 1 >= tbl1.f1 + 1;
EXPLAIN SELECT /*+ BKA(tbl1, tbl2) */ tbl2.f1, tbl2.f2, tbl2.f3 FROM t1 tbl1,t2 tbl2 WHERE tbl1.f1=tbl2.f1 AND tbl2.f2 BETWEEN tbl1.f1 and tbl1.f2 and tbl2.f2 + 1 >= tbl1.f1 + 1;
EXPLAIN SELECT /*+ BKA(t2) NO_BNL(t1) BKA(t3) NO_RANGE_OPTIMIZATION(t3 idx1) NO_RANGE_OPTIMIZATION(t3) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
EXPLAIN SELECT /*+ BKA(qb1 t3@qb1) */ f2 FROM (SELECT /*+ QB_NAME(qb1) */ f2, f3, f1 FROM t3 WHERE f1 > 2 AND f3 = 'poiu') AS TD WHERE TD.f1 > 2 AND TD.f3 = 'poiu';
EXPLAIN SELECT * FROM (SELECT /*+ QB_NAME(qb1) BKA(@qb1 t1@qb1, t2@qb1, t3) */ t2.f1, t2.f2, t2.f3 FROM t1,t2,t3) tt;
EXPLAIN SELECT /*+ BKA(@qb1 t2) */ * FROM (SELECT /*+ QB_NAME(QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1) AS s1;
EXPLAIN SELECT * FROM (SELECT /*+ BKA(t2) */ tb2.f1, tb2.f2, tb2.f3 FROM t1 tb1,t2 tb2 WHERE tb1.f1=tb2.f1 AND tb2.f2 BETWEEN tb1.f1 and tb1.f2 and tb2.f2 + 1 >= tb1.f1 + 1) AS s1;
EXPLAIN SELECT * FROM (SELECT /*+ BKA(tb2) */ tb2.f1, tb2.f2, tb2.f3 FROM t1 tb1,t2 tb2 WHERE tb1.f1=tb2.f1 AND tb2.f2 BETWEEN tb1.f1 and tb1.f2 and tb2.f2 + 1 >= tb1.f1 + 1) AS s1;
FLUSH STATUS;
SELECT /*+ BKA(@qb1 t2) */ * FROM (SELECT /*+ QB_NAME(QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1) AS s1;
SHOW STATUS LIKE 'handler_read%';
PREPARE stmt1 FROM "SELECT /*+ BKA(@qb1 t2) */ * FROM (SELECT /*+ QB_NAME(QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1) AS s1";
FLUSH STATUS;
EXECUTE stmt1;
SHOW STATUS LIKE 'handler_read%';
FLUSH STATUS;
EXECUTE stmt1;
SHOW STATUS LIKE 'handler_read%';
DEALLOCATE PREPARE stmt1;
DROP TABLE t1, t2, t3;
set optimizer_switch=default;
set optimizer_switch='block_nested_loop=on';
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(2,2);
CREATE TABLE t2 (a INT, b INT);
INSERT INTO t2 VALUES (1,1),(2,2);
CREATE TABLE t3 (a INT, b INT);
INSERT INTO t3 VALUES (1,1),(2,2);
FLUSH STATUS;
SELECT t1.* FROM t1,t2,t3;
SHOW STATUS LIKE 'handler_read%';
FLUSH STATUS;
SELECT /*+ NO_BNL() */t1.* FROM t1,t2,t3;
SHOW STATUS LIKE 'handler_read%';
EXPLAIN SELECT t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ NO_BNL() */t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ NO_BNL(t2, t3) */t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ NO_BNL(t1, t3) */t1.* FROM t1,t2,t3;
set optimizer_switch='block_nested_loop=off';
EXPLAIN SELECT t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ BNL() */t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ BNL(t2, t3) */t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ BNL(t1, t3) */t1.* FROM t1,t2,t3;
EXPLAIN SELECT /*+ BNL(t2) BNL(t3) */t1.* FROM t1,t2,t3;
DROP TABLE t1, t2, t3;
