drop database if exists `mysqltest1`;
drop database if exists `mysqltest-1`;
drop database if exists `#mysql50#mysqltest-1`;
create database `mysqltest1`;
create database `#mysql50#mysqltest-1`;
create table `mysqltest1`.`t1` (a int);
create table `mysqltest1`.`#mysql50#t-1` (a int);
create table `#mysql50#mysqltest-1`.`t1` (a int);
create table `#mysql50#mysqltest-1`.`#mysql50#t-1` (a int);
show create database `mysqltest1`;
show create database `mysqltest-1`;
show create database `#mysql50#mysqltest-1`;
show tables in `mysqltest1`;
show tables in `#mysql50#mysqltest-1`;
show create database `mysqltest1`;
show create database `#mysql50#mysqltest-1`;
show tables in `mysqltest1`;
show tables in `#mysql50#mysqltest-1`;
drop database `mysqltest1`;
drop database `#mysql50#mysqltest-1`;
drop table if exists `txu@0023p@0023p1`;
drop table if exists `txu#p#p1`;
create table `txu#p#p1` (s1 int);
insert into `txu#p#p1` values (1);
select * from `txu@0023p@0023p1`;
create table `txu@0023p@0023p1` (s1 int);
insert into `txu@0023p@0023p1` values (2);
select * from `txu@0023p@0023p1`;
select * from `txu#p#p1`;
drop table `txu@0023p@0023p1`;
drop table `txu#p#p1`;
use test;
USE `#mysql50#.`;
USE `#mysql50#../blablabla`;
