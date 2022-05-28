DROP TABLE IF EXISTS t1;
SET NAMES hebrew;
CREATE TABLE t1 (a char(1)) DEFAULT CHARSET=hebrew;
INSERT INTO t1 VALUES (0xFD),(0xFE);
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8;
SELECT HEX(a) FROM t1;
DROP TABLE t1;
