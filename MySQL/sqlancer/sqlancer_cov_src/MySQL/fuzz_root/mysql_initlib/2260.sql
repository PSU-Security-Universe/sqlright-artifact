CREATE TABLE t1 (a INT) ENGINE=innodb;
RESET MASTER;
SET AUTOCOMMIT=0;
SELECT 1;
FLUSH TABLES WITH READ LOCK;
INSERT INTO t1 VALUES (1);
UNLOCK TABLES;
DROP TABLE t1;
SET AUTOCOMMIT=1;
create table t1 (a int) engine=innodb;
flush tables with read lock;
begin;
insert into t1 values (1);;
unlock tables;
commit;
drop table t1;
