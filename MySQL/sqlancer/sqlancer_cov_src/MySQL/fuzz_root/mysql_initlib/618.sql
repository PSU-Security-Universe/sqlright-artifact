SET SESSION DEFAULT_STORAGE_ENGINE = MyISAM;
drop table if exists t1,t3,t4,t5;
create table t1 (a int, b char(10), key a(a), key b(a,b));
insert into t1 values (17,"ddd"),(18,"eee"),(19,"fff"),(19,"yyy"), (14,"aaa"),(15,"bbb"),(16,"ccc"),(16,"xxx"), (20,"ggg"),(21,"hhh"),(22,"iii");
handler t1 open as t2;
handler t2 read a first;
handler t2 read a next;
handler t2 read a next;
handler t2 read a prev;
handler t2 read a last;
handler t2 read a prev;
handler t2 read a prev;
handler t2 read a first;
handler t2 read a prev;
handler t2 read a last;
handler t2 read a prev;
handler t2 read a next;
handler t2 read a next;
handler t2 read a=(15);
handler t2 read a=(16);
handler t2 read a=(19,"fff");
handler t2 read b=(19,"fff");
handler t2 read b=(19,"yyy");
handler t2 read b=(19);
handler t1 read a last;
handler t2 read a=(11);
handler t2 read a>=(11);
handler t2 read a=(18);
handler t2 read a>=(18);
handler t2 read a>(18);
handler t2 read a<=(18);
handler t2 read a<(18);
handler t2 read a first limit 5;
handler t2 read a next  limit 3;
handler t2 read a prev  limit 10;
handler t2 read a>=(16) limit 4;
handler t2 read a>=(16) limit 2,2;
handler t2 read a last  limit 3;
handler t2 read a=(19);
handler t2 read a=(19) where b="yyy";
handler t2 read first;
handler t2 read next;
handler t2 read next;
handler t2 close;
handler t1 open;
handler t1 read a next;
handler t1 read a next;
handler t1 close;
handler t1 open;
handler t1 read a prev;
handler t1 read a prev;
handler t1 close;
handler t1 open as t2;
handler t2 read first;
alter table t1 engine = MyISAM;
handler t2 read first;
handler t1 open as t2;
drop table t1;
create table t1 (a int);
insert into t1 values (17);
handler t2 read first;
handler t1 open as t2;
alter table t1 engine=MEMORY;
handler t2 read first;
drop table t1;
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5),(6);
delete from t1 limit 2;
handler t1 open;
handler t1 read first;
handler t1 read first limit 1,1;
handler t1 read first limit 2,2;
delete from t1 limit 3;
handler t1 read first;
drop table t1;
create table t1(a int, index(a));
insert into t1 values (1), (2), (3);
handler t1 open;
handler t1 read a=(W);
handler t1 read a=(a);
drop table t1;
create table t1 (a char(5));
insert into t1 values ("Ok");
handler t1 open as t;
handler t read first;
use mysql;
handler t read first;
handler t close;
handler test.t1 open as t;
handler t read first;
handler t close;
use test;
drop table t1;
create table t1 ( a int, b int, INDEX a (a) );
insert into t1 values (1,2), (2,1);
handler t1 open;
handler t1 read a=(1) where b=2;
handler t1 read a=(1) where b=3;
handler t1 read a=(1) where b=1;
handler t1 close;
drop table t1;
drop database if exists test_test;
create database test_test;
use test_test;
create table t1(table_id char(20) primary key);
insert into t1 values ('test_test.t1');
insert into t1 values ('');
handler t1 open;
handler t1 read first limit 9;
create table t2(table_id char(20) primary key);
insert into t2 values ('test_test.t2');
insert into t2 values ('');
handler t2 open;
handler t2 read first limit 9;
use test;
drop table if exists t1;
create table t1(table_id char(20) primary key);
insert into t1 values ('test.t1');
insert into t1 values ('');
handler t1 open;