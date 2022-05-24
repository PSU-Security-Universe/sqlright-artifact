CREATE TABLE t1 ( pk INT PRIMARY KEY AUTO_INCREMENT, i INT, j INT, INDEX (i), INDEX (j) );
INSERT INTO t1 (i,j) VALUES (1,1);
set @d=1;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
INSERT INTO t1 (i,j) SELECT i+@d, j+@d from t1;
set @d=@d*2;
ANALYZE TABLE t1;
EXPLAIN SELECT * FROM t1 WHERE i<100 AND j<10 ORDER BY i LIMIT 5;
SELECT * FROM t1 WHERE i<100 AND j<10 ORDER BY i LIMIT 5;
DROP TABLE t1;
CREATE TABLE t0 ( i0 INTEGER NOT NULL );
INSERT INTO t0 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 ( pk INTEGER PRIMARY KEY, i1 INTEGER NOT NULL, i2 INTEGER NOT NULL, INDEX k1 (i1), INDEX k2 (i1,i2) ) ENGINE=InnoDB;
INSERT INTO t1 SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0, (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 1000, (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 1000 FROM t0 AS a0, t0 AS a1;
CREATE TABLE t2 ( pk INTEGER PRIMARY KEY, i1 INTEGER NOT NULL, INDEX k1 (i1) ) ENGINE=InnoDB;
INSERT INTO t2 SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0, (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 500 FROM t0 AS a0, t0 AS a1;
ANALYZE TABLE t1,t2;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t1.i1 > 2 ORDER BY t1.i1 LIMIT 2;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t1.i1 > 2 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t1.i1 > 2 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t1.i1 > 800 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t1.i1 > 800 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 1000 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 1000 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT t1.i1,t1.i2 FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1  WHERE t1.pk > 100 ORDER BY t1.i1 LIMIT 5;
SELECT t1.i1,t1.i2 FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1  WHERE t1.pk > 100 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t2.pk = 100 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 and t2.pk = 100 ORDER BY t1.i1 LIMIT 5;
INSERT INTO t2 SELECT a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0 + 1, (a0.i0 + 10*a1.i0 + 100*a0.i0 + 1000*a1.i0) % 500 FROM t0 AS a0, t0 AS a1;
ANALYZE TABLE t2;
EXPLAIN SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
EXPLAIN SELECT * FROM t1 FORCE INDEX FOR ORDER BY (k2) STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
SELECT * FROM t1 FORCE INDEX FOR ORDER BY (k2) STRAIGHT_JOIN t2 ON t1.i1=t2.i1 WHERE t1.pk > 7000 ORDER BY t1.i1 LIMIT 5;
DROP TABLE t0, t1, t2;
CREATE TABLE t1 ( pk int(11) NOT NULL, col_int int(11), col_varchar_key varchar(20), PRIMARY KEY (pk), KEY col_varchar_key (col_varchar_key), KEY col_varchar_key_2 (col_varchar_key(5)) );
INSERT INTO t1 VALUES (1,2,'t'), (2,5,'efqsdksj'), (3,NULL,'fqsdksjijcs'),(4,8,'qsdksjijc'), (5,40,NULL),(6,3,'dkz'),(7,2,NULL), (8,3,'dks'),(9,0,'ksjijcsz'), (10,84,'sjijcszxwbjj');
ANALYZE TABLE t1;
SET @@SESSION.sql_mode='NO_ENGINE_SUBSTITUTION';
EXPLAIN SELECT DISTINCT col_int FROM t1 WHERE col_varchar_key <> 'c'    OR col_varchar_key > 'w' ORDER BY col_varchar_key LIMIT 100;
SELECT DISTINCT col_int FROM t1 WHERE col_varchar_key <> 'c'    OR col_varchar_key > 'w' ORDER BY col_varchar_key LIMIT 100;
DROP TABLE t1;
CREATE TABLE t1 ( col_int_unique INT DEFAULT NULL, col_int_key INT DEFAULT NULL, UNIQUE KEY col_int_unique (col_int_unique), KEY col_int_key (col_int_key) );
INSERT INTO t1 VALUES (49,49), (9,7), (0,1), (2,42);
CREATE TABLE t2 ( col_int_unique INT DEFAULT NULL, pk INT NOT NULL, PRIMARY KEY (pk), UNIQUE KEY col_int_unique (col_int_unique) );
INSERT INTO t2 VALUES (2,8), (5,2), (6,1);
ANALYZE TABLE t1,t2;
EXPLAIN SELECT STRAIGHT_JOIN t1.col_int_key AS field1 FROM t1 JOIN t2 ON t2.pk = t1.col_int_unique OR t2.col_int_unique = t1.col_int_key ORDER BY field1 LIMIT 2;
DROP TABLE t1,t2;
CREATE TABLE t (id BIGINT NOT NULL, other_id BIGINT NOT NULL, covered_column VARCHAR(50) NOT NULL, non_covered_column VARCHAR(50) NOT NULL, PRIMARY KEY (id), INDEX index_other_id_covered_column (other_id, covered_column));
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (10, 10, '10', '10');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (9, 9, '9', '9');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (8, 8, '8', '8');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (7, 7, '7', '7');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (6, 6, '6', '6');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (5, 5, '5', '5');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (4, 4, '4', '4');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (3, 3, '3', '3');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (2, 2, '2', '2');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (1, 1, '1', '1');
SET optimizer_trace = "enabled=on", optimizer_trace_max_mem_size = 1000000, end_markers_in_json = ON;
SET optimizer_switch = "prefer_ordering_index=on";
ANALYZE TABLE t;
EXPLAIN SELECT non_covered_column FROM t WHERE other_id > 3 ORDER BY id ASC LIMIT 2;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
EXPLAIN SELECT non_covered_column FROM t WHERE other_id > 3 ORDER BY id ASC LIMIT 2;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_0 FROM information_schema.optimizer_trace;
SET optimizer_switch = default;
EXPLAIN SELECT non_covered_column FROM t WHERE other_id > 3 ORDER BY id ASC LIMIT 2;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=on";
EXPLAIN SELECT /*+ ORDER_INDEX(t PRIMARY) */ non_covered_column FROM t WHERE other_id > 3 ORDER BY id ASC LIMIT 2;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
EXPLAIN SELECT /*+ ORDER_INDEX(t PRIMARY) */ non_covered_column FROM t WHERE other_id > 3 ORDER BY id ASC LIMIT 2;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (10+1+10, 10, '10', '10');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (9+1+10, 9, '9', '9');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (8+1+10, 8, '8', '8');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (7+1+10, 7, '7', '7');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (6+1+10, 6, '6', '6');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (5+1+10, 5, '5', '5');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (4+1+10, 4, '4', '4');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (3+1+10, 3, '3', '3');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (2+1+10, 2, '2', '2');
INSERT INTO t (id, other_id, covered_column, non_covered_column) VALUES (1+1+10, 1, '1', '1');
SET optimizer_switch = "prefer_ordering_index=on";
ANALYZE TABLE t;
EXPLAIN SELECT non_covered_column FROM t WHERE id > 8 GROUP BY other_id LIMIT 1;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
EXPLAIN SELECT non_covered_column FROM t WHERE id > 8 GROUP BY other_id LIMIT 1;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_0 FROM information_schema.optimizer_trace;
SET optimizer_switch = default;
EXPLAIN SELECT non_covered_column FROM t WHERE id > 8 GROUP BY id LIMIT 1;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=on";
EXPLAIN SELECT /*+ GROUP_INDEX(t index_other_id_covered_column) */ non_covered_column FROM t WHERE id > 8 GROUP BY other_id LIMIT 1;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
SET optimizer_switch = "prefer_ordering_index=off";
EXPLAIN SELECT /*+ GROUP_INDEX(t index_other_id_covered_column) */ non_covered_column FROM t WHERE id > 8 GROUP BY other_id LIMIT 1;
SELECT (trace LIKE '%"plan_changed": true%') AS should_be_1 FROM information_schema.optimizer_trace;
DROP TABLE t;
CREATE TABLE p ( pid int unsigned NOT NULL AUTO_INCREMENT, cid int unsigned NOT NULL, pl char(255) DEFAULT '', PRIMARY KEY (pid), KEY cid (cid) );
INSERT INTO p (cid) VALUES (1), (2), (3), (4), (5), (6), (7), (8);
INSERT INTO p (cid) SELECT 1 FROM p;
INSERT INTO p (cid) SELECT 2 FROM p;
INSERT INTO p (cid) SELECT 3 FROM p;
