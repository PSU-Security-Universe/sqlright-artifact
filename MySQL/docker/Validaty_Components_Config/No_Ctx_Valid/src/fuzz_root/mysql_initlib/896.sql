drop table if exists t1;
create table t1 SELECT 1,"table 1";
repair table t1 use_frm;
alter table t1 ENGINE=HEAP;
repair table t1 use_frm;
drop table t1;
create table t1(id int PRIMARY KEY, st varchar(10), KEY st_key(st));
insert into t1 values(1, "One");
alter table t1 disable keys;
analyze table t1;
show keys from t1;
repair table t1 extended;
analyze table t1;
show keys from t1;
drop table t1;
repair table t1 use_frm;
create table t1 engine=myisam SELECT 1,"table 1";
flush tables;
repair table t1;
repair table t1 use_frm;
drop table t1;
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES(1),(2),(3),(4),(5);
SET myisam_repair_threads=2;
REPAIR TABLE t1;
ANALYZE TABLE t1;
SHOW INDEX FROM t1;
SET myisam_repair_threads=@@global.myisam_repair_threads;
DROP TABLE t1;
CREATE TABLE t1(a INT);
USE mysql;
REPAIR TABLE test.t1 USE_FRM;
USE test;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(255), KEY(a)) charset latin1;
SET myisam_sort_buffer_size=4096;
SET myisam_repair_threads=2;
REPAIR TABLE t1;
SET myisam_repair_threads=@@global.myisam_repair_threads;
SET myisam_sort_buffer_size=@@global.myisam_sort_buffer_size;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(255), KEY(a)) charset latin1;
SET myisam_sort_buffer_size=4496;
SET myisam_repair_threads=2;
REPAIR TABLE t1;
SET myisam_repair_threads=@@global.myisam_repair_threads;
SET myisam_sort_buffer_size=@@global.myisam_sort_buffer_size;
DROP TABLE t1;
DROP TABLE IF EXISTS tt1;
CREATE TEMPORARY TABLE tt1 (c1 INT);
REPAIR TABLE tt1 USE_FRM;
DROP TABLE tt1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT);
LOCK TABLES t1 READ;
REPAIR TABLE t1;
UNLOCK TABLES;
DROP TABLE t1;
drop tables if exists t1, t2;
create table t1 (i int);
create table t2 (j int);
set @@autocommit= 0;
repair table t1, t2;
set @@autocommit= default;
drop tables t1, t2;
