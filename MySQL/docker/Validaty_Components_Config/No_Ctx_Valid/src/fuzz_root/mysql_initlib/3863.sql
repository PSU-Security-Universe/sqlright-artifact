CREATE TABLE t1 ( id bigint NOT NULL AUTO_INCREMENT, time date, id2 bigint not null, PRIMARY KEY (id,time) ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 /*!50100 PARTITION BY RANGE(TO_DAYS(time)) (PARTITION p10 VALUES LESS THAN (734708) ENGINE = InnoDB, PARTITION p20 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
INSERT INTO t1 (time,id2) VALUES ('2011-07-24',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
CREATE UNIQUE INDEX uk_time_id2 on t1(time,id2);
SELECT COUNT(*) FROM t1;
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 (id INT NOT NULL PRIMARY KEY, user_num CHAR(10) ) ENGINE = InnoDB KEY_BLOCK_SIZE=4 PARTITION BY HASH(id) PARTITIONS 1;
SHOW CREATE TABLE t1;
SET GLOBAL innodb_file_per_table = OFF;
LOCK TABLE t1 WRITE;
ALTER TABLE t1 ADD PARTITION PARTITIONS 1;
SET innodb_strict_mode = OFF;
ALTER TABLE t1 ADD PARTITION PARTITIONS 2;
ALTER TABLE t1 REBUILD PARTITION p0;
UNLOCK TABLES;
SHOW CREATE TABLE t1;
DROP TABLE t1;
SET GLOBAL innodb_file_per_table = default;
