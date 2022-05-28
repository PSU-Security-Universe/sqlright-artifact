drop table if exists t1,t2,t7,t8,t9;
drop database if exists mysqltest;
create table t1 (a int not null auto_increment, b char(16) not null, primary key (a)) engine=myisam;
create table t2 (a int not null auto_increment, b char(16) not null, primary key (a)) engine=myisam;
insert into t1 (b) values ("test"),("test1"),("test2"),("test3");
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
insert into t2 (b) select b from t1;
insert into t1 (b) select b from t2;
drop table t2;
create table t9 (a int not null auto_increment, b char(16) not null, primary key (a))  engine=myisam data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp" index directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/run";
insert into t9 select * from t1;
check table t9;
optimize table t9;
repair table t9;
alter table t9 add column c int not null;
show create table t9;
alter table t9 rename t8, add column d int not null;
alter table t8 rename t7;
rename table t7 to t9;
drop table t1;
SHOW CREATE TABLE t9;
create database mysqltest;
create table mysqltest.t9 (a int not null auto_increment, b char(16) not null, primary key (a))  engine=myisam index directory="/this-dir-does-not-exist";
create table mysqltest.t9 (a int not null auto_increment, b char(16) not null, primary key (a))  engine=myisam index directory="not-hard-path";
create table mysqltest.t9 (a int not null auto_increment, b char(16) not null, primary key (a))  engine=myisam index directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/run";
create table mysqltest.t9 (a int not null auto_increment, b char(16) not null, primary key (a))  engine=myisam data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp";
alter table t9 rename mysqltest.t9;
select count(*) from mysqltest.t9;
show create table mysqltest.t9;
drop database mysqltest;
create table t1 (a int not null) engine=myisam;
alter table t1 data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp";
show create table t1;
alter table t1 add b int;
alter table t1 data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/log";
show create table t1;
alter table t1 index directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/log";
show create table t1;
drop table t1;
CREATE TABLE t1(a INT) ENGINE = MYISAM DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp' INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp';
CREATE TABLE t2(a INT) ENGINE = MYISAM DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp' INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp';
RENAME TABLE t2 TO t1;
DROP TABLE t2;
create temporary table t1 (a int) engine=myisam data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/log" select 9 a;
show create table t1;
create temporary table t1 (a int) engine=myisam data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/log" select 99 a;
show create table t1;
create table t1 (a int) engine=myisam select 42 a;
select * from t1;
select * from t1;
select * from t1;
drop table t1;
SET SESSION keep_files_on_create = TRUE;
CREATE TABLE t1 (a INT) ENGINE MYISAM;
SET SESSION keep_files_on_create = FALSE;
CREATE TABLE t1 (a INT) ENGINE MYISAM;
DROP TABLE t1;
CREATE TABLE t1(a INT) ENGINE=MYISAM INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//mysql';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT) ENGINE=MYISAM DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//test';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT) ENGINE=MYISAM DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT) ENGINE=MYISAM INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data/';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT) ENGINE=MYISAM INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/master-data_var';
SET @OLD_SQL_MODE=@@SQL_MODE, @@SQL_MODE='NO_DIR_IN_CREATE';
CREATE TABLE t1(a INT) DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp' INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp';
DROP TABLE t1;
SET @@SQL_MODE=@OLD_SQL_MODE;
CREATE SCHEMA schema1;
CREATE TABLE schema1.t1 (a INT, b INT) ENGINE=MYISAM;
INSERT INTO schema1.t1 VALUES(1,1);
INSERT INTO schema1.t1 VALUES(2,2);
CREATE TABLE t1(a INT) ENGINE=MYISAM DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/mysql'                             INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/mysql';
FLUSH TABLE t1;
FLUSH TABLE schema1.t1;
DROP TABLE t1;
FLUSH TABLE schema1.t1;
SELECT * FROM schema1.t1;
DROP SCHEMA schema1;
drop table if exists t1, t2;
create table t1 (a int primary key) engine=myisam data directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp"       index directory="/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/run";
show create table t1;
create table t2 like t1;
show create table t2;
drop tables t1, t2;
CREATE DATABASE x;
USE x;
DROP DATABASE x;
CREATE TABLE test.t1(id INT(11)) ENGINE MYISAM DATA DIRECTORY "/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp";
DROP TABLE test.t1;
