set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;
SET @old_log_output = @@global.log_output;
SET GLOBAL LOG_OUTPUT = 'FILE';
flush status;
CREATE VIEW v1 AS SELECT VARIABLE_NAME AS NAME, CONVERT(VARIABLE_VALUE, UNSIGNED) AS VALUE FROM performance_schema.global_status;
SELECT VALUE INTO @tc FROM v1 WHERE NAME = 'Threads_connected';
SELECT NAME FROM v1 WHERE NAME = 'Threads_created' AND VALUE < @tc;
DROP VIEW v1;
set @@global.concurrent_insert= @old_concurrent_insert;
SET GLOBAL log_output = @old_log_output;
