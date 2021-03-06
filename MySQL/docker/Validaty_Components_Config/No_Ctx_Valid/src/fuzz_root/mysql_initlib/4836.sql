drop table if exists t1,t2,t3,t4,t9,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop view if exists t1,t2,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop database if exists mysqltest;
use test;
create view v1 (c,d) as select a,b from t1;
create temporary table t1 (a int, b int);
create view v1 (c) as select b+1 from t1;
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c,d) as select a,b+@@global.max_user_connections from t1;
create view v1 (c,d) as select a,b from t1 where a = @@global.max_user_connections;
CREATE VIEW v1 AS SELECT @a=1 FROM DUAL;
CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE @a>1;
CREATE VIEW v1 AS SELECT (@a:= 1) AS one FROM DUAL;
CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE (@a:= 1);
create view v1 (c) as select b+1 from t1;
select c from v1;
select is_updatable from information_schema.views where table_name='v1';
create temporary table t1 (a int, b int);
select * from t1;
select c from v1;
show create table v1;
show create view v1;
show create view t1;
drop table t1;
select a from v1;
select v1.a from v1;
select b from v1;
select v1.b from v1;
analyze table t1;
explain select c from v1;
create algorithm=temptable view v2 (c) as select b+1 from t1;
show create view v2;
select c from v2;
explain select c from v2;
create view v3 (c) as select a+1 from v1;
create view v3 (c) as select b+1 from v1;
create view v3 (c) as select c+1 from v1;
select c from v3;
explain select c from v3;
create algorithm=temptable view v4 (c) as select c+1 from v2;
select c from v4;
explain select c from v4;
create view v5 (c) as select c+1 from v2;
select c from v5;
explain select c from v5;
create algorithm=temptable view v6 (c) as select c+1 from v1;
select c from v6;
explain select c from v6;
show tables;
show full tables;
show table status;
drop view v1,v2,v3,v4,v5,v6;
create view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;
create view v2 as select c, d from v1;
select * from v1;
select * from v2;
create view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;
create or replace view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;
drop view v2;
alter view v2 as select c, d from v1;
create or replace view v2 as select c, d from v1;
alter view v1 (c,d) as select a,max(b) from t1 group by a;
select * from v1;
select * from v2;
drop view v100;
drop view t1;
drop table v1;
drop view v1,v2;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3);
create view v1 (a) as select a+1 from t1;
create view v2 (a) as select a-1 from t1;
select * from t1 natural left join v1;
select * from v2 natural left join t1;
select * from v2 natural left join v1;
drop view v1, v2;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3), (1), (2), (3);
analyze table t1;
create view v1 as select distinct a from t1;
select * from v1;
explain select * from v1;
select * from t1;
drop view v1;
drop table t1;
create table t1 (a int);
create view v1 as select distinct a from t1 WITH CHECK OPTION;
create view v1 as select a from t1 WITH CHECK OPTION;
create view v2 as select a from t1 WITH CASCADED CHECK OPTION;
create view v3 as select a from t1 WITH LOCAL CHECK OPTION;
drop view v3 RESTRICT;
drop view v2 CASCADE;
drop view v1;
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c) as select b+1 from t1;
select test.c from v1 test;
create algorithm=temptable view v2 (c) as select b+1 from t1;
select test.c from v2 test;
select test1.* from v1 test1, v2 test2 where test1.c=test2.c;
select test2.* from v1 test1, v2 test2 where test1.c=test2.c;
drop table t1;
drop view v1,v2;
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
analyze table t1;
create view v1 as select a+1 from t1 order by 1 desc limit 2;
select * from v1;
explain select * from v1;
drop view v1;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
create view v1 as select a+1 from t1;
create table t2 select * from v1;
show columns from t2;
select * from t2;
