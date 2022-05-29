set optimizer_switch='batched_key_access=on,mrr_cost_based=off';
DROP TABLE IF EXISTS t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;
CREATE TABLE t0 (a int, b int, c int);
INSERT INTO t0 VALUES (1,1,0), (1,2,0), (2,2,0);
ANALYZE TABLE t1, t2, t3, t4;
ALTER TABLE t3 CHANGE COLUMN a a1 int, CHANGE COLUMN c c1 int;
