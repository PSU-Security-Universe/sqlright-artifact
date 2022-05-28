SET PERSIST event_scheduler=DISABLED;
SET PERSIST_ONLY event_scheduler=123.456;
SET PERSIST_ONLY event_scheduler=DISABLED;
RESET PERSIST event_scheduler;
CREATE DATABASE bug27374791;
USE bug27374791;
CREATE TABLE T( i int);
RESET MASTER;
BEGIN;
INSERT INTO T values (9);
SET PERSIST max_connections=31;
RESET PERSIST;
SET GLOBAL max_connections=DEFAULT;
DROP DATABASE bug27374791;
SELECT @@max_binlog_cache_size;
SET PERSIST max_binlog_cache_size= @@global.max_binlog_cache_size;
SELECT * FROM performance_schema.persisted_variables WHERE VARIABLE_NAME= 'max_binlog_cache_size';
SET PERSIST_ONLY max_binlog_cache_size= @@global.max_binlog_cache_size;
SELECT * FROM performance_schema.persisted_variables WHERE VARIABLE_NAME= 'max_binlog_cache_size';
SET @a=cast(@@max_binlog_cache_size as char);
SELECT @a;
RESET PERSIST;
SET GLOBAL max_binlog_cache_size= DEFAULT;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login, @@global.auto_increment_increment, @@global.auto_increment_offset, @@global.binlog_error_action, @@global.binlog_format, @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit, @@global.innodb_monitor_disable, @@global.histogram_generation_max_mem_size, @@global.innodb_max_dirty_pages_pct, @@global.init_connect, @@global.max_join_size;
SET PERSIST optimizer_trace_offset = default;
SET PERSIST activate_all_roles_on_login= ON;
SET PERSIST auto_increment_increment= 4, auto_increment_offset= 2;
SET PERSIST binlog_error_action= IGNORE_ERROR, binlog_format= ROW;
SET PERSIST cte_max_recursion_depth= 4294967295, eq_range_index_dive_limit= 4294967295;
SET PERSIST innodb_monitor_disable='latch';
SET PERSIST innodb_max_dirty_pages_pct= 97.3;
SET PERSIST init_connect='SET autocommit=0';
SET PERSIST max_join_size= 18446744073709551615;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login, @@global.auto_increment_increment, @@global.auto_increment_offset, @@global.binlog_error_action, @@global.binlog_format, @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit, @@global.innodb_monitor_disable, @@global.innodb_max_dirty_pages_pct, @@global.init_connect, @@global.max_join_size;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT @@global.optimizer_trace_offset, @@global.activate_all_roles_on_login, @@global.auto_increment_increment, @@global.auto_increment_offset, @@global.binlog_error_action, @@global.binlog_format, @@global.cte_max_recursion_depth, @@global.eq_range_index_dive_limit, @@global.innodb_monitor_disable, @@global.innodb_max_dirty_pages_pct, @@global.init_connect, @@global.max_join_size;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
RESET PERSIST;
SET GLOBAL optimizer_trace_offset = default, activate_all_roles_on_login = default, auto_increment_increment = default, auto_increment_offset = default, binlog_error_action = default, binlog_format = default, cte_max_recursion_depth = default, eq_range_index_dive_limit = default, innodb_monitor_disable = default, innodb_max_dirty_pages_pct = default, init_connect = default, max_join_size = default;
SET PERSIST max_join_size= 10000000;
SET PERSIST init_connect='';
SELECT COUNT(DISTINCT MICROSECOND(set_time)) FROM performance_schema.variables_info WHERE variable_name IN ('max_join_size', 'init_connect');
SET GLOBAL max_join_size=DEFAULT, init_connect=DEFAULT;
RESET PERSIST;
SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;
SET @@global.binlog_cache_size= 4096;
SET @@persist_only.binlog_cache_size= default, @@persist_only.collation_database= default, @@persist_only.optimizer_trace_offset= default, @@persist_only.optimizer_switch= default, @@persist_only.enforce_gtid_consistency= default, @@persist_only.sql_mode= default;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
SELECT @@global.binlog_cache_size;
SELECT @@global.collation_database;
SELECT @@global.optimizer_trace_offset;
SELECT @@global.optimizer_switch;
SELECT @@global.enforce_gtid_consistency;
SELECT @@global.sql_mode;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
RESET PERSIST;
SET PERSIST mandatory_roles= default;
SELECT * FROM performance_schema.persisted_variables ORDER BY 1;
RESET PERSIST;
CREATE DATABASE bug27903874;
USE bug27903874;