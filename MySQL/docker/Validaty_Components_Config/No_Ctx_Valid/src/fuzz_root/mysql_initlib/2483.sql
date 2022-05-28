SELECT GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE FROM INFORMATION_SCHEMA.USER_PRIVILEGES WHERE PRIVILEGE_TYPE LIKE 'FLUSH_%' ORDER BY 1,2,3;
FLUSH HOSTS;
TRUNCATE TABLE performance_schema.host_cache;
FLUSH OPTIMIZER_COSTS;
FLUSH HOSTS;
FLUSH STATUS;
FLUSH HOSTS;
FLUSH USER_RESOURCES;
FLUSH HOSTS;
CREATE TABLE t1(a int);
FLUSH TABLES;
FLUSH TABLES t1;
FLUSH TABLES WITH READ LOCK;
UNLOCK TABLES;
FLUSH TABLES t1 WITH READ LOCK;
UNLOCK TABLES;
FLUSH TABLES t1 FOR EXPORT;
UNLOCK TABLES;
FLUSH HOSTS;
DROP TABLE t1;
FLUSH HOSTS;
FLUSH OPTIMIZER_COSTS;
FLUSH STATUS;
FLUSH USER_RESOURCES;
FLUSH TABLES;
FLUSH STATUS,OPTIMIZER_COSTS;
FLUSH OPTIMIZER_COSTS,STATUS;
FLUSH STATUS,PRIVILEGES;
FLUSH STATUS,USER_RESOURCES;
SET @saved_log_output = @@global.log_output;
SET @saved_general_log = @@global.general_log;
SET global log_output='table';
SET global general_log=on;
SET global general_log=@saved_general_log;
SET global log_output=@saved_log_output;
SELECT command_type, argument FROM mysql.general_log WHERE command_type='Query';
TRUNCATE TABLE mysql.general_log;
