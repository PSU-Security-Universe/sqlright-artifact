set @start_read_only= @@global.read_only;
DROP TABLE IF EXISTS t1,t2,t3;
set @orig_sql_mode= @@sql_mode;
set global read_only=0;
create table t1 (a int);
insert into t1 values(1);
create table t2 select * from t1;
set global read_only=1;
create table t3 (a int);
drop table t3;
select @@global.read_only;
create table t3 (a int);
insert into t1 values(1);
update t1 set a=1 where 1=0;
update t1,t2 set t1.a=t2.a+1 where t1.a=t2.a;
delete t1,t2 from t1,t2 where t1.a=t2.a;
create temporary table t3 (a int);
create temporary table t4 (a int) select * from t3;
insert into t3 values(1);
insert into t4 select * from t3;
update t1,t3 set t1.a=t3.a+1 where t1.a=t3.a;
update t1,t3 set t3.a=t1.a+1 where t1.a=t3.a;
update t4,t3 set t4.a=t3.a+1 where t4.a=t3.a;
delete t1 from t1,t3 where t1.a=t3.a;
delete t3 from t1,t3 where t1.a=t3.a;
delete t4 from t3,t4 where t4.a=t3.a;
create temporary table t1 (a int);
insert into t1 values(1);
update t1,t3 set t1.a=t3.a+1 where t1.a=t3.a;
delete t1 from t1,t3 where t1.a=t3.a;
drop table t1;
insert into t1 values(1);
set global read_only=0;
lock table t1 write;
lock table t2 write;
set global read_only=1;
unlock tables ;
set global read_only=1;
select @@global.read_only;
unlock tables ;
select @@global.read_only;
set global read_only=0;
lock table t1 read;
lock table t2 read;
set global read_only=1;
unlock tables ;
set global read_only=1;
select @@global.read_only;
select @@global.read_only;
unlock tables ;
set global read_only=0;
BEGIN;
BEGIN;
set global read_only=1;
ROLLBACK;
set global read_only=1;
select @@global.read_only;
ROLLBACK;
set global read_only=0;
flush tables with read lock;
set global read_only=1;
unlock tables;
set global read_only=0;
flush tables with read lock;
set global read_only=1;
select @@global.read_only;
unlock tables;
drop temporary table ttt;
drop temporary table if exists ttt;
set global read_only=0;
drop table t1,t2;
set global read_only= 1;
drop database if exists mysqltest_db1;
drop database if exists mysqltest_db2;
flush privileges;
create user `mysqltest_u1`@`%`;
grant all on mysqltest_db2.* to `mysqltest_u1`@`%`;
create database mysqltest_db1;
grant all on mysqltest_db1.* to `mysqltest_u1`@`%`;
flush privileges;
create database mysqltest_db2;
show databases like '%mysqltest_db2%';
drop database mysqltest_db1;
flush privileges;
drop database mysqltest_db1;
set global read_only= @start_read_only;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2);
CREATE USER user1;
SET GLOBAL read_only= 1;
START TRANSACTION;
COMMIT;
START TRANSACTION READ ONLY;
COMMIT;
START TRANSACTION READ WRITE;
COMMIT;
START TRANSACTION;
INSERT INTO t1 VALUES (3);
UPDATE t1 SET a= 1;
DELETE FROM t1;
COMMIT;
START TRANSACTION READ ONLY;
COMMIT;
START TRANSACTION READ WRITE;
COMMIT;
DROP USER user1;
SET GLOBAL read_only= 0;
DROP TABLE t1;
