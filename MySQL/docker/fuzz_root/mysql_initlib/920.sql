SET @global_saved_tmp =  @@global.offline_mode;
CREATE USER 'user1'@'localhost';
use test;
CREATE TABLE t2 (c1 int,c2 char(10));
INSERT INTO t2 VALUES (1,'aaaaaaaaaa');
INSERT INTO t2 VALUES (2,'bbbbbbbbbb');
LOCK TABLE t2 read;
alter table t2 add column j int;
SET GLOBAL offline_mode = ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = OFF;
UNLOCK TABLES;
SELECT * FROM t2 ORDER BY c1;
DROP TABLE t2;
SET GLOBAL offline_mode = ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
DROP USER 'user1'@'localhost';
SET @@global.offline_mode = @global_saved_tmp;