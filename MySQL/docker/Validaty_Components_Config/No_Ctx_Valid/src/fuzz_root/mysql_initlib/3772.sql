CREATE TABLE t1( f0 int auto_increment PRIMARY KEY, f1 int, f2 varchar(200) ) charset latin1;
CREATE TEMPORARY TABLE tmp (f1 int, f2 varchar(20)) charset latin1;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
INSERT INTO tmp SELECT f1,f2 FROM t1;
INSERT INTO t1(f1,f2) SELECT * FROM tmp;
set sort_buffer_size= 32768;
FLUSH STATUS;
SHOW SESSION STATUS LIKE 'Sort%';
SELECT * FROM t1 ORDER BY f2,f0 LIMIT 101;
SHOW SESSION STATUS LIKE 'Sort%';
FLUSH STATUS;
CREATE TABLE t2 (f1 int);
INSERT INTO t2 VALUES (0), (0);
SELECT * FROM t2 where f1 = (SELECT f2 from t1 where t1.f1 = t2.f1 ORDER BY f1 LIMIT 1);
SHOW SESSION STATUS LIKE 'Sort%';
DROP TABLE t1, t2, tmp;
CREATE TABLE t ( col1 INTEGER NOT NULL, col2 BINARY(16) NOT NULL, col3 VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL, col4 INTEGER NOT NULL, col5 TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6), col6 BLOB, PRIMARY KEY (col1), UNIQUE KEY uc_key (col2, col3, col4) );
INSERT INTO t VALUES(1, x'4142434445464748494a414243444546', 'WRITEBACK', 0, TIMESTAMP'2020-01-01 00:00:00.000000', NULL);
SELECT t.col1, t.col2, t.col3, t.col4, t.col5, t.col6 FROM t WHERE t.col2 IN (x'4142434445464748494a414243444546') AND t.col3 IN ('WRITEBACK') ORDER BY t.col2 DESC, t.col3 DESC, t.col4 DESC LIMIT 1;
explain SELECT t.col1, t.col2, t.col3, t.col4, t.col5, t.col6 FROM t WHERE t.col2 IN (x'4142434445464748494a414243444546') AND t.col3 IN ('WRITEBACK') ORDER BY t.col2 DESC, t.col3 DESC, t.col4 DESC LIMIT 1;
DROP TABLE t;
CREATE TABLE t1(vc VARCHAR(20) CHARACTER SET latin1);
INSERT INTO t1 VALUES('2021-02-08'), ('21-02-08');
SELECT * FROM t1 WHERE vc = '2021-02-08' ORDER BY vc ASC;
explain SELECT * FROM t1 WHERE vc = '2021-02-08' ORDER BY vc ASC;
SELECT * FROM t1 WHERE vc = '2021-02-08' ORDER BY vc DESC;
explain SELECT * FROM t1 WHERE vc = '2021-02-08' ORDER BY vc DESC;
set @strvar = _latin1'2021-02-08';
SELECT * FROM t1 WHERE vc = @strvar ORDER BY vc ASC;
explain SELECT * FROM t1 WHERE vc = @strvar ORDER BY vc ASC;
SELECT * FROM t1 WHERE vc = @strvar ORDER BY vc DESC;
explain SELECT * FROM t1 WHERE vc = @strvar ORDER BY vc DESC;
SELECT * FROM t1 WHERE vc = DATE'2021-02-08' ORDER BY vc ASC;
explain SELECT * FROM t1 WHERE vc = DATE'2021-02-08' ORDER BY vc ASC;
SELECT * FROM t1 WHERE vc = DATE'2021-02-08' ORDER BY vc DESC;
explain SELECT * FROM t1 WHERE vc = DATE'2021-02-08' ORDER BY vc DESC;
DROP TABLE t1;
