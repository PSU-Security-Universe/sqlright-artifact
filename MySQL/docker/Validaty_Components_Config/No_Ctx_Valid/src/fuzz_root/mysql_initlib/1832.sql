SET @previous_binlog_format__htnt542nh=@@GLOBAL.binlog_format;
SET @@GLOBAL.binlog_format=STATEMENT;
SET binlog_format=STATEMENT;
CREATE TABLE t1 ( a int );
INSERT INTO t1 VALUES (1),(2),(1);
CREATE TABLE t2 ( PRIMARY KEY (a) ) ENGINE=INNODB SELECT a FROM t1;
select * from t2;
CREATE TEMPORARY TABLE t2 ( PRIMARY KEY (a) ) ENGINE=INNODB SELECT a FROM t1;
select * from t2;
drop table t1;
SET @@GLOBAL.binlog_format=@previous_binlog_format__htnt542nh;
