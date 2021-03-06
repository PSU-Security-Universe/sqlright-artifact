drop database if exists events_test;
drop database if exists mysqltest_no_such_database;
create database events_test;
use events_test;
set autocommit=off;
select @@autocommit;
create table t1 (a varchar(255)) engine=innodb;
begin work;
insert into t1 (a) values ("OK: create event");
create event e1 on schedule every 1 day do select 1;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: alter event");
alter event e1 on schedule every 2 day do select 2;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: alter event rename");
alter event e1 rename to e2;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: drop event");
drop event e2;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: drop event if exists");
drop event if exists e2;
rollback work;
select * from t1;
delete from t1;
commit work;
create event e1 on schedule every 1 day do select 1;
begin work;
insert into t1 (a) values ("OK: create event if not exists");
create event if not exists e1 on schedule every 2 day do select 2;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: create event: event already exists");
create event e1 on schedule every 2 day do select 2;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: alter event rename: rename to same name");
alter event e1 rename to e1;
rollback work;
select * from t1;
delete from t1;
commit work;
create event e2 on schedule every 3 day do select 3;
begin work;
insert into t1 (a) values ("OK: alter event rename: destination exists");
alter event e2 rename to e1;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: create event: database does not exist");
create event mysqltest_no_such_database.e1 on schedule every 1 day do select 1;
rollback work;
select * from t1;
delete from t1;
commit work;
USE test;
DROP TABLE IF EXISTS t1, t2;
DROP EVENT IF EXISTS e1;
CREATE TABLE t1 (a INT) ENGINE=InnoDB;
CREATE TABLE t2 (a INT);
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
START TRANSACTION;
INSERT INTO t1 VALUES (1);
SAVEPOINT A;
SHOW CREATE EVENT e1;
SELECT * FROM t2;
ROLLBACK WORK TO SAVEPOINT A;
DROP TABLE t1, t2;
DROP EVENT e1;
drop database if exists mysqltest_db2;
use events_test;
create database mysqltest_db2;
set autocommit=off;
select @@autocommit;
create table t1 (a varchar(255)) engine=innodb;
begin work;
insert into t1 (a) values ("OK: create event: insufficient privileges");
create event e1 on schedule every 1 day do select 1;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: alter event: insufficient privileges");
alter event e1 on schedule every 1 day do select 1;
rollback work;
select * from t1;
delete from t1;
commit work;
begin work;
insert into t1 (a) values ("OK: drop event: insufficient privileges");
drop event e1;
rollback work;
select * from t1;
delete from t1;
commit work;
