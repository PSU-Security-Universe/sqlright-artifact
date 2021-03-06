SELECT @@global.temptable_use_mmap;
SET @@session.temptable_use_mmap=false;
SET @@global.temptable_use_mmap=NULL;
SET @@global.temptable_use_mmap=false;
SELECT @@global.temptable_use_mmap;
SELECT count_alloc > 0 FROM performance_schema.memory_summary_global_by_event_name WHERE event_name = 'memory/temptable/physical_disk';
CREATE TABLE t (c VARCHAR(128));
INSERT INTO t VALUES (REPEAT('a', 128)), (REPEAT('b', 128)), (REPEAT('c', 128)), (REPEAT('d', 128));
ANALYZE TABLE t;
SET GLOBAL temptable_max_ram = 2097152;
SELECT * FROM t AS t1, t AS t2, t AS t3, t AS t4, t AS t5, t AS t6 ORDER BY 1 LIMIT 2;
SET GLOBAL temptable_max_ram = default;
SELECT count_alloc > 0 FROM performance_schema.memory_summary_global_by_event_name WHERE event_name = 'memory/temptable/physical_disk';
DROP TABLE t;
SET @@global.temptable_use_mmap = true;
SELECT @@global.temptable_use_mmap;
CREATE TABLE t (c LONGBLOB);
INSERT INTO t VALUES (REPEAT('a', 128)), (REPEAT('b', 128)), (REPEAT('c', 128)), (REPEAT('d', 128));
ANALYZE TABLE t;
SET GLOBAL temptable_max_ram = 2097152;
SELECT * FROM t AS t1, t AS t2, t AS t3, t AS t4, t AS t5, t AS t6 ORDER BY 1 LIMIT 2;
SET GLOBAL temptable_max_ram = default;
SET GLOBAL temptable_use_mmap = default;
SELECT @@global.temptable_use_mmap;
SELECT count_alloc > 0 FROM performance_schema.memory_summary_global_by_event_name WHERE event_name = 'memory/temptable/physical_disk';
DROP TABLE t;
CREATE TABLE t (c LONGBLOB);
INSERT INTO t VALUES (REPEAT('a', 128)), (REPEAT('b', 128)), (REPEAT('c', 128)), (REPEAT('d', 128));
ANALYZE TABLE t;
SET GLOBAL temptable_max_ram = 2*1024*1024;
SET GLOBAL temptable_max_mmap = 4*1024*1024;
SELECT * FROM t AS t1, t AS t2, t AS t3, t AS t4, t AS t5, t AS t6 ORDER BY 1 LIMIT 2;
SELECT sum_number_of_bytes_alloc >= 2*1024*1024 FROM performance_schema.memory_summary_global_by_event_name WHERE event_name = 'memory/temptable/physical_ram';
SELECT sum_number_of_bytes_alloc = 4*1024*1024 FROM performance_schema.memory_summary_global_by_event_name WHERE event_name = 'memory/temptable/physical_disk';
DROP TABLE t;
SET GLOBAL temptable_max_ram = default;
SET GLOBAL temptable_max_mmap = default;
SET GLOBAL temptable_use_mmap = default;
