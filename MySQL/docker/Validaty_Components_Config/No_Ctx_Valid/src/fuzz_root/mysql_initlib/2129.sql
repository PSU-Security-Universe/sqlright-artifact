DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (n INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT * FROM t1;
DROP TABLE t1;
SELECT GET_LOCK("dangling", 0);
SELECT GET_LOCK('dangling', 3600);;
SELECT GET_LOCK('dangling', 3600);;
SELECT RELEASE_LOCK('dangling');
