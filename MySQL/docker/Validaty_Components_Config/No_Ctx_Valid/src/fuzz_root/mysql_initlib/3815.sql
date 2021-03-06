DROP TABLE IF EXISTS t1;
CREATE TABLE t1(id INT) PARTITION BY RANGE (id) (PARTITION p0 VALUES LESS THAN (100), PARTITION pmax VALUES LESS THAN (MAXVALUE));
INSERT INTO t1 VALUES (1), (10), (100), (1000);
RESET MASTER;
ALTER TABLE t1 TRUNCATE PARTITION p1;
ALTER TABLE t1 DROP PARTITION p1;
ALTER TABLE t1 ANALYZE PARTITION p1;
ALTER TABLE t1 CHECK PARTITION p1;
ALTER TABLE t1 OPTIMIZE PARTITION p1;
ALTER TABLE t1 REPAIR PARTITION p1;
ALTER TABLE t1 ANALYZE PARTITION p0;
ALTER TABLE t1 CHECK PARTITION p0;
ALTER TABLE t1 OPTIMIZE PARTITION p0;
ALTER TABLE t1 REPAIR PARTITION p0;
ALTER TABLE t1 TRUNCATE PARTITION p0;
ALTER TABLE t1 DROP PARTITION p0;
DROP TABLE t1;
