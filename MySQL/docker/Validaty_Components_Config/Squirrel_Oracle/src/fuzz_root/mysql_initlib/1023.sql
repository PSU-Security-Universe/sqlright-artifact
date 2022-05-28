create table t1 (a int, b char(10)) charset latin1 engine=Myisam;
create view v1 as select * from t1 where a != 0 with check option;
load data infile '../../std_data/loaddata3.dat' into table v1 fields terminated by '' enclosed by '' ignore 1 lines;
select * from t1;
select * from v1;
delete from t1;
load data infile '../../std_data/loaddata3.dat' ignore into table v1 fields terminated by '' enclosed by '' ignore 1 lines;
select * from t1 order by a,b;
select * from v1 order by a,b;
drop view v1;
drop table t1;
create table t1 (a int, primary key (a), b int) engine=myisam;
create table t2 (a int, primary key (a), b int) engine=myisam;
insert into t2 values (1000, 2000);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
insert into v3 values (1,2);
insert into v3 select * from t2;
insert into v3(a,b) values (1,2);
insert into v3(a,b) select * from t2;
insert into v3(a) values (1);
insert into v3(b) values (10);
insert into v3(a) select a from t2;
insert into v3(b) select b from t2;
insert into v3(a) values (1) on duplicate key update a=a+10000+VALUES(a);
select * from t1 ;
select * from t2 ;
delete from v3;
delete v3,t1 from v3,t1;
delete t1,v3 from t1,v3;
delete from t1;
set @a= 100;
execute stmt1 using @a;
set @a= 300;
execute stmt1 using @a;
deallocate prepare stmt1;
set @a= 101;
execute stmt1 using @a;
set @a= 301;
execute stmt1 using @a;
deallocate prepare stmt1;
select * from v3 ;
drop view v3;
drop tables t1,t2;
DROP TABLE IF EXISTS t1, t2, t3, table_broken;
DROP VIEW IF EXISTS view_broken;
CREATE VIEW view_broken AS SELECT * FROM t1, t2, t3;
CREATE TABLE table_broken AS SELECT * FROM t1, t2, t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1(a INT) ENGINE=MyISAM;
CREATE TABLE t2(b INT);
CREATE TABLE t3(c INT);
CREATE TABLE t4(d INT);
CREATE VIEW v1 AS SELECT * FROM t2;
RENAME TABLES t1 TO t5, v1 TO v2;
SELECT * FROM v2;
RENAME TABLES t5 TO t1, v2 TO v1, t3 TO t4;
SELECT * FROM v2;
DROP VIEW v2;
DROP TABLES t2, t3, t4, t5;