SET @global_saved_tmp =  @@global.offline_mode;
SET @global_autocommit =  @@global.autocommit;
SET @@global.autocommit= OFF;
CREATE USER 'user1'@'localhost';
START TRANSACTION;
CREATE TABLE t2 (c1 int,c2 char(10));
INSERT INTO t2 VALUES (1,'aaaaaaaaaa');
COMMIT;
INSERT INTO t2 VALUES (2,'bbbbbbbbbb');
SET GLOBAL offline_mode = ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = OFF;
SELECT * FROM t2 ORDER BY c1;
DROP TABLE t2;
SET GLOBAL offline_mode = ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
DROP USER 'user1'@'localhost';
SET @@global.offline_mode = @global_saved_tmp;
SET @@global.autocommit= @global_autocommit;
