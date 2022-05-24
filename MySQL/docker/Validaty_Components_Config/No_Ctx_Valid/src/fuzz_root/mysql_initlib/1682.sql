CREATE TABLE t1(d DATE);
INSERT INTO t1 VALUES('2011-02-20');
SELECT * FROM t1 WHERE d <= '2013-02-32';
SELECT * FROM t1 WHERE d <= '2013-02-30';
SELECT * FROM t1 WHERE d >= '0000-00-00';
SELECT * FROM t1 WHERE d >= 'wrong-date';
SET @old_sql_mode := @@sql_mode;
SET @@sql_mode = 'ALLOW_INVALID_DATES';
SELECT * FROM t1 WHERE d <= '2013-02-32';
SELECT * FROM t1 WHERE d >= 'wrong-date';
SELECT * FROM t1 WHERE d <= '2013-02-30';
SELECT * FROM t1 WHERE d >= '0000-00-00';
SET @@sql_mode = @old_sql_mode;
DROP TABLE t1;
