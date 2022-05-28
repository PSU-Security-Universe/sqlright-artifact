set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
drop database if exists mysqltest;
drop view if exists v1,v2,v3;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create table mysqltest.t2 (a int, b int);
create view v1 as select * from mysqltest.t1;
alter view v1 as select * from mysqltest.t1;
create or replace view v1 as select * from mysqltest.t1;
create view mysqltest.v2  as select * from mysqltest.t1;
create view v2 as select * from mysqltest.t2;
show create view v1;
use test;
alter view v1 as select * from mysqltest.t1;
create or replace view v1 as select * from mysqltest.t1;
drop database mysqltest;
drop view test.v1;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select d from mysqltest.v1;
drop database mysqltest;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create algorithm=temptable view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select d from mysqltest.v1;
drop database mysqltest;
flush privileges;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create table mysqltest.t2 (a int, b int);
create view mysqltest.v1 (c,d) as select a+1,b+1 from mysqltest.t1;
create algorithm=temptable view mysqltest.v2 (c,d) as select a+1,b+1 from mysqltest.t1;
create view mysqltest.v3 (c,d) as select a+1,b+1 from mysqltest.t2;
create algorithm=temptable view mysqltest.v4 (c,d) as select a+1,b+1 from mysqltest.t2;
create view mysqltest.v5 (c,d) as select a+1,b+1 from mysqltest.t1;
select c from mysqltest.v1;
select c from mysqltest.v2;
select c from mysqltest.v3;
select c from mysqltest.v4;
select c from mysqltest.v5;
show columns from mysqltest.v1;
show columns from mysqltest.v2;
explain select c from mysqltest.v1;
show create view mysqltest.v1;
explain select c from mysqltest.v2;
show create view mysqltest.v2;
explain select c from mysqltest.v3;
show create view mysqltest.v3;
explain select c from mysqltest.v4;
show create view mysqltest.v4;
explain select c from mysqltest.v5;
show create view mysqltest.v5;
show create view mysqltest.v5;
explain select c from mysqltest.v1;
show create view mysqltest.v1;
explain select c from mysqltest.v1;
show create view mysqltest.v1;
explain select c from mysqltest.v2;
show create view mysqltest.v2;
explain select c from mysqltest.v3;
show create view mysqltest.v3;
explain select c from mysqltest.v4;
show create view mysqltest.v4;
explain select c from mysqltest.v5;
explain select c from mysqltest.v1;
show create view mysqltest.v1;
explain select c from mysqltest.v2;
show create view mysqltest.v2;
explain select c from mysqltest.v3;
show create view mysqltest.v3;
explain select c from mysqltest.v4;
show create view mysqltest.v4;
drop database mysqltest;
flush privileges;
create database mysqltest;
create table mysqltest.t1 (a int, b int, primary key(a));
insert into mysqltest.t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create table mysqltest.t2 (x int);
insert into mysqltest.t2 values (3), (4), (5), (6);
create view mysqltest.v1 (a,c) as select a, b+1 from mysqltest.t1;
create view mysqltest.v2 (a,c) as select a, b from mysqltest.t1;
create view mysqltest.v3 (a,c) as select a, b+1 from mysqltest.t1;
