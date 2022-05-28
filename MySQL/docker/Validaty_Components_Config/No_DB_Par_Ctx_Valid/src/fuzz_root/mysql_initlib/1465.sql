SET binlog_format= 'ROW';
CREATE TABLE t1 (c1 INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1), (2), (3);
SET sql_log_bin= 0;
DELETE FROM t1;
SET sql_log_bin= 1;
INSERT INTO t1 VALUES (1), (2), (3);
DELETE FROM t1;
DROP TABLE t1;
SET binlog_format= 'MIXED';
CREATE TABLE t1 (c1 INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1), (2), (3);
SET sql_log_bin= 0;
DELETE FROM t1;
SET sql_log_bin= 1;
INSERT INTO t1 VALUES (1), (2), (3);
DELETE FROM t1;
DROP TABLE t1;
SET binlog_format= 'STATEMENT';
CREATE TABLE t1 (c1 INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1), (2), (3);
SET sql_log_bin= 0;
DELETE FROM t1;
SET sql_log_bin= 1;
INSERT INTO t1 VALUES (1), (2), (3);
DELETE FROM t1;
DROP TABLE t1;
