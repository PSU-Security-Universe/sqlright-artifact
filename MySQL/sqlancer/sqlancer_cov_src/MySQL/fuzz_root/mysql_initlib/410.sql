SET @previous_binlog_format__htnt542nh=@@GLOBAL.binlog_format;
SET @@GLOBAL.binlog_format=STATEMENT;
SET binlog_format=STATEMENT;
RESET MASTER;
SET NAMES gb18030;
CREATE TABLE t1 ( f1 BLOB ) DEFAULT CHARSET=gb18030;
CREATE PROCEDURE p1(IN val BLOB) BEGIN SET @tval = val; SET @sql_cmd = CONCAT_WS(' ', 'INSERT INTO t1(f1) VALUES(?)'); PREPARE stmt FROM @sql_cmd; EXECUTE stmt USING @tval; DEALLOCATE PREPARE stmt; END;
SET @`tcontent`:='����binlog���ƣ��������ֽڱ���:�9�1�9�2�9�3,���3�6���F';
CALL p1(@`tcontent`);
FLUSH LOGS;
DROP PROCEDURE p1;
RENAME TABLE t1 to t2;
RESET MASTER;
SELECT hex(f1), f1 FROM t2;
SELECT hex(f1), f1 FROM t1;
DROP PROCEDURE p1;
DROP TABLE t1;
DROP TABLE t2;
SET @@GLOBAL.binlog_format=@previous_binlog_format__htnt542nh;