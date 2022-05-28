SET @old_log_output= @@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
drop table if exists t1,t2;
drop table if exists t1aa,t2aa;
drop database if exists mysqltest;
drop database if exists mysqltest1;
flush privileges;
create table t1 (a int not null primary key, b int not null,c int not null, key(b,c));
insert into t1 values (1,2,2),(2,2,3),(3,2,4),(4,2,4);
check table t1 fast;
check table t1 fast;
check table t1 changed;
insert into t1 values (5,5,5);
check table t1 changed;
check table t1 medium;
check table t1 extended;
analyze table t1;
show index from t1;
insert into t1 values (5,5,5);
optimize table t1;
optimize table t1;
drop table t1;
show variables like "wait_timeout%";
show variables like "WAIT_timeout%";
show variables like "this_doesn't_exists%";
show table status from test like "this_doesn't_exists%";
show databases;
show databases like "test%";
create temporary table t1 (a int not null);
show create table t1;
alter table t1 rename t2;
show create table t2;
drop table t2;
create table t1 ( test_set set( 'val1', 'val2', 'val3' ) not null default '', name char(20) default 'O''Brien' comment 'O''Brien as default', c int not null comment 'int column', `c-b` int comment 'name with a minus', `space 2` int comment 'name with a space'   ) comment = 'it\'s a table' ;
show create table t1;
set sql_quote_show_create=0;
show create table t1;
set sql_quote_show_create=1;
show full columns from t1;
drop table t1;
create table t1 (a int not null, unique aa (a));
show create table t1;
drop table t1;
create table t1 (a int not null, primary key (a));
show create table t1;
drop table t1;
flush tables;
show open tables;
create table t1(n int);
insert into t1 values (1);
show open tables;
drop table t1;
create table t1 (a decimal(9,2), b decimal (9,0), e double(9,2), f double(5,0), h float(3,2), i float(3,0));
show columns from t1;
show full columns from t1;
drop table t1;
create table t1 (a int not null);
create table t2 select max(a) from t1;
show columns from t2;
drop table t1,t2;
create table t1 (c decimal, d double, f float, r real);
show columns from t1;
drop table t1;
create table t1 (c decimal(3,3), d double(3,3), f float(3,3));
show columns from t1;
drop table t1;
SET @old_sql_mode= @@sql_mode, sql_mode= '';
SET @old_sql_quote_show_create= @@sql_quote_show_create, sql_quote_show_create= OFF;
CREATE TABLE ```ab``cd``` (i INT);
SHOW CREATE TABLE ```ab``cd```;
DROP TABLE ```ab``cd```;
CREATE TABLE ```ab````cd``` (i INT);
SHOW CREATE TABLE ```ab````cd```;
DROP TABLE ```ab````cd```;
CREATE TABLE ```a` (i INT);
SHOW CREATE TABLE ```a`;
DROP TABLE ```a`;
CREATE TABLE `a.1` (i INT);
SHOW CREATE TABLE `a.1`;
DROP TABLE `a.1`;
SET sql_mode= 'ANSI_QUOTES';
CREATE TABLE """a" (i INT);
SHOW CREATE TABLE """a";
DROP TABLE """a";
SET sql_mode= '';
SET sql_quote_show_create= OFF;
CREATE TABLE t1 (i INT);
SHOW CREATE TABLE t1;
DROP TABLE t1;
CREATE TABLE `table` (i INT);
SHOW CREATE TABLE `table`;
DROP TABLE `table`;
SET sql_quote_show_create= @old_sql_quote_show_create;
SET sql_mode= @old_sql_mode;
select @@max_heap_table_size;
CREATE TABLE t1 ( a int(11) default NULL, KEY a USING BTREE (a) ) ENGINE=HEAP;
CREATE TABLE t2 ( b int(11) default NULL, index(b) ) ENGINE=HEAP;
CREATE TABLE t3 ( a int(11) default NULL, b int(11) default NULL, KEY a USING BTREE (a), index(b) ) ENGINE=HEAP;
insert into t1 values (1),(2);
insert into t2 values (1),(2);
insert into t3 values (1,1),(2,2);
analyze table t1, t2, t3;
show table status;
insert into t1 values (3),(4);
insert into t2 values (3),(4);
insert into t3 values (3,3),(4,4);
analyze table t1, t2, t3;
show table status;
insert into t1 values (5);
insert into t2 values (5);
insert into t3 values (5,5);
analyze table t1, t2, t3;
show table status;
delete from t1 where a=3;
delete from t2 where b=3;
delete from t3 where a=3;
analyze table t1, t2, t3;
show table status;
truncate table t1;
truncate table t2;
