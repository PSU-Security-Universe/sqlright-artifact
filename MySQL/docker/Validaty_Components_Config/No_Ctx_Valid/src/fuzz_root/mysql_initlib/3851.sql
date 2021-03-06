create table thread_to_monitor(thread_id int);
insert into thread_to_monitor(thread_id) SELECT THREAD_ID FROM performance_schema.threads WHERE PROCESSLIST_ID=CONNECTION_ID();
CREATE TABLE t1 (a int) ENGINE = InnoDB PARTITION BY HASH (a) PARTITIONS 2;
INSERT INTO t1 VALUES (0), (1), (2), (3);
CREATE VIEW v1 AS SELECT a FROM t1 PARTITION (p0);
SHOW CREATE VIEW v1;
FLUSH STATUS;
SELECT * FROM v1;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
SELECT a FROM t1 PARTITION (p0);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
INSERT INTO v1 VALUES (10);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
INSERT INTO v1 VALUES (11);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
SELECT * FROM v1;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
SELECT a FROM t1 PARTITION (p0);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM t1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT a FROM t1 PARTITION (p0) WITH CHECK OPTION;
SHOW CREATE VIEW v1;
FLUSH STATUS;
INSERT INTO v1 VALUES (20);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
INSERT INTO v1 VALUES (21);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM v1;
SELECT * FROM t1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT a FROM t1 PARTITION (p0) WHERE a = 30 WITH CHECK OPTION;
SHOW CREATE VIEW v1;
FLUSH STATUS;
INSERT INTO v1 VALUES (30);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
INSERT INTO v1 VALUES (31);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
INSERT INTO v1 VALUES (32);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM v1;
SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
SET @old_default_storage_engine = @@default_storage_engine;
SET @@default_storage_engine = 'InnoDB';
FLUSH STATUS;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
CREATE TABLE t1 (a INT NOT NULL, b varchar (64), INDEX (b,a), PRIMARY KEY (a)) ENGINE = InnoDB charset latin1 PARTITION BY RANGE (a) SUBPARTITION BY HASH (a) SUBPARTITIONS 2 (PARTITION pNeg VALUES LESS THAN (0) (SUBPARTITION subp0, SUBPARTITION subp1), PARTITION `p0-9` VALUES LESS THAN (10) (SUBPARTITION subp2, SUBPARTITION subp3), PARTITION `p10-99` VALUES LESS THAN (100) (SUBPARTITION subp4, SUBPARTITION subp5), PARTITION `p100-99999` VALUES LESS THAN (100000) (SUBPARTITION subp6, SUBPARTITION subp7));
SHOW CREATE TABLE t1;
INSERT INTO t1 PARTITION (pNonExisting) VALUES (1, "error");
INSERT INTO t1 PARTITION (pNeg, pNonExisting) VALUES (1, "error");
FLUSH STATUS;
INSERT INTO t1 PARTITION (pNeg, pNeg) VALUES (-1, "pNeg(-subp1)");
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
INSERT INTO t1 PARTITION (pNeg, subp0) VALUES (-3, "pNeg(-subp1)");
INSERT INTO t1 PARTITION (pNeg, subp0) VALUES (-2, "(pNeg-)subp0");
INSERT INTO t1 PARTITION (`p100-99999`) VALUES (100, "`p100-99999`(-subp6)"), (101, "`p100-99999`(-subp7)"), (1000, "`p100-99999`(-subp6)");
INSERT INTO t1 PARTITION(`p10-99`,subp3) VALUES (1, "subp3"), (10, "p10-99");
FLUSH STATUS;
INSERT INTO t1 PARTITION(subp3) VALUES (3, "subp3");
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
LOCK TABLE t1 WRITE;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
INSERT INTO t1 PARTITION(`p0-9`) VALUES (5, "p0-9:subp3");
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
UNLOCK TABLES;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
INSERT INTO t1 PARTITION (pNeg, pNeg) VALUES (1, "error");
INSERT INTO t1 PARTITION (pNeg, subp0) VALUES (1, "error");
INSERT INTO t1 PARTITION (`p100-99999`) VALUES (1, "error"), (10, "error");
INSERT INTO t1 VALUES (1000000, "error"), (9999999, "error");
INSERT INTO t1 PARTITION (`p100-99999`) VALUES (1000000, "error"), (9999999, "error");
INSERT INTO t1 PARTITION (pNeg, subp4) VALUES (-7, "pNeg(-subp1)"), (-10, "pNeg(-subp0)"), (-1, "pNeg(-subp1)"), (-99, "pNeg(-subp1)");
SELECT * FROM t1 ORDER BY a;
ANALYZE TABLE t1;
SET @save_innodb_stats_on_metadata=@@global.innodb_stats_on_metadata;
SET @@global.innodb_stats_on_metadata=ON;
SELECT PARTITION_NAME, SUBPARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' ORDER BY SUBPARTITION_NAME;
SET @@global.innodb_stats_on_metadata=@save_innodb_stats_on_metadata;
FLUSH STATUS;
SELECT * FROM t1 PARTITION (pNonexistent);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
SELECT * FROM t1 PARTITION (subp2);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
SELECT * FROM t1 PARTITION (subp2,pNeg) AS TableAlias;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
FLUSH STATUS;
LOCK TABLE t1 READ, t1 as TableAlias READ;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM t1 PARTITION (subp3) AS TableAlias;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT COUNT(*) FROM t1 PARTITION (`p10-99`);
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM t1 WHERE a = 1000000;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
SELECT * FROM t1 PARTITION (pNeg) WHERE a = 100;
UNLOCK TABLES;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
EXPLAIN SELECT * FROM t1 PARTITION (pNonexistent);
EXPLAIN SELECT * FROM t1 PARTITION (subp2);
FLUSH STATUS;
EXPLAIN SELECT * FROM t1 PARTITION (subp2,pNeg) AS tablealias;
SELECT VARIABLE_NAME, VARIABLE_VALUE FROM performance_schema.status_by_thread WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0 AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);
EXPLAIN SELECT * FROM t1 PARTITION (subp3) AS tablealias;
EXPLAIN SELECT COUNT(*) FROM t1 PARTITION (`p10-99`);
EXPLAIN SELECT * FROM t1 WHERE a = 1000000;
EXPLAIN SELECT * FROM t1 PARTITION (pNeg) WHERE a = 100;
