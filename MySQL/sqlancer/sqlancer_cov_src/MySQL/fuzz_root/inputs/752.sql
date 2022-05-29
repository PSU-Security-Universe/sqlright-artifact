set optimizer_switch='semijoin=off';
set @save_storage_engine= @@session.default_storage_engine;
set session default_storage_engine = MyISAM;
SET GLOBAL innodb_stats_persistent=0;
set end_markers_in_json=on;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2), (3);
FLUSH STATUS;
SHOW STATUS WHERE (Variable_name LIKE 'Sort%' OR Variable_name LIKE 'Handler_read_%' OR Variable_name = 'Handler_write' OR Variable_name = 'Handler_update' OR Variable_name = 'Handler_delete') AND Value <> 0;
UPDATE t1 SET a = 10 WHERE a < 10;
DROP TABLE t1;
DELETE   FROM t1 WHERE a < 10;
