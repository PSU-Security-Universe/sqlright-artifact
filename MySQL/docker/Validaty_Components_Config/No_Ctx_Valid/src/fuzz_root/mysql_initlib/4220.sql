SELECT * FROM performance_schema.global_variables WHERE variable_name LIKE '%offline_mode%';
CREATE USER 'user1'@'localhost';
CREATE USER 'user2'@'localhost';
CREATE USER 'user3'@'localhost';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SHOW STATUS LIKE 'threads_connected';
SET GLOBAL offline_mode = ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SHOW STATUS LIKE 'threads_connected';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SHOW VARIABLES LIKE '%offline_mode%';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SHOW STATUS LIKE 'threads_connected';
DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
DROP USER 'user3'@'localhost';
SET @@global.offline_mode = 0;
