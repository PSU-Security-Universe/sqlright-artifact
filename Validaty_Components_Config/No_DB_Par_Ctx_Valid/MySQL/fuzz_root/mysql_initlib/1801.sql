DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=innodb;
START TRANSACTION WITH CONSISTENT SNAPSHOT;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
COMMIT;
DELETE FROM t1;
START TRANSACTION;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
COMMIT;
START TRANSACTION WITH CONSISTENT SNAPSHOT;
DELETE FROM t1;
COMMIT WORK AND CHAIN;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
COMMIT;
DROP TABLE t1;
