drop table if exists t1;
create table t1 (a int not null,b int not null, primary key using BTREE (a)) engine=heap comment="testing heaps" avg_row_length=100 min_rows=1 max_rows=100;
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a=1 or a=0;
show keys from t1;
select * from t1;
select * from t1 where a=4;
update t1 set b=5 where a=4;
update t1 set b=b+1 where a>=3;
replace t1 values (3,3);
select * from t1;
alter table t1 add c int not null, add key using BTREE (c,a);
drop table t1;
create table t1 (a int not null,b int not null, primary key using BTREE (a)) engine=heap comment="testing heaps";
insert into t1 values(-2,-2),(-1,-1),(0,0),(1,1),(2,2),(3,3),(4,4);
delete from t1 where a > -3;
select * from t1;
drop table t1;
create table t1 (x int not null, y int not null, key x  using BTREE (x,y), unique y  using BTREE (y)) engine=heap;
insert into t1 values (1,1),(2,2),(1,3),(2,4),(2,5),(2,6);
explain select * from t1 where x=1;
select * from t1 where x=1;
select * from t1,t1 as t2 where t1.x=t2.y;
explain select * from t1,t1 as t2 where t1.x=t2.y;
drop table t1;
create table t1 (a int) engine=heap;
insert into t1 values(1);
select max(a) from t1;
drop table t1;
CREATE TABLE t1 ( a int not null default 0, b int not null default 0,  key  using BTREE (a,b),  key  using BTREE (b)  ) ENGINE=HEAP;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
explain select * from t1 where a=1 order by a,b;
explain select * from t1 where a=1 order by b;
select * from t1 where b=1;
explain select * from t1 where b=1;
drop table t1;
create table t1 (id int unsigned not null, primary key  using BTREE (id)) engine=HEAP;
insert into t1 values(1);
select max(id) from t1;
insert into t1 values(2);
select max(id) from t1;
replace into t1 values(1);
drop table t1;
create table t1 (n int) engine=heap;
drop table t1;
create table t1 (n int) engine=heap;
drop table if exists t1;
CREATE table t1(f1 int not null,f2 char(20) not  null,index(f2)) engine=heap;
INSERT into t1 set f1=12,f2="bill";
INSERT into t1 set f1=13,f2="bill";
INSERT into t1 set f1=14,f2="bill";
INSERT into t1 set f1=15,f2="bill";
INSERT into t1 set f1=16,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
INSERT into t1 set f1=12,f2="ted";
delete from t1 where f2="bill";
select * from t1;
drop table t1;
create table t1 (btn char(10) not null, key using BTREE (btn)) charset utf8mb4 engine=heap;
insert into t1 values ("hello"),("hello"),("hello"),("hello"),("hello"),("a"),("b"),("c"),("d"),("e"),("f"),("g"),("h"),("i");
explain select * from t1 where btn like "i%";
explain select * from t1 where btn like "h%";
explain select * from t1 where btn like "a%";
explain select * from t1 where btn like "b%";
select * from t1 where btn like "ff%";
select * from t1 where btn like " %";
select * from t1 where btn like "q%";
alter table t1 add column new_col char(1) not null, add key using BTREE (btn,new_col), drop key btn;
update t1 set new_col=left(btn,1);
explain select * from t1 where btn="a";
explain select * from t1 where btn="a" and new_col="a";
drop table t1;
CREATE TABLE t1 ( a int default NULL, b int default NULL, KEY a using BTREE (a), UNIQUE b using BTREE (b) ) engine=heap;
INSERT INTO t1 VALUES (NULL,99),(99,NULL),(1,1),(2,2),(1,3);
SELECT * FROM t1 WHERE a=NULL;
explain SELECT * FROM t1 WHERE a IS NULL;
SELECT * FROM t1 WHERE a<=>NULL;
SELECT * FROM t1 WHERE b=NULL;
explain SELECT * FROM t1 WHERE b IS NULL;
SELECT * FROM t1 WHERE b<=>NULL;
INSERT INTO t1 VALUES (1,3);
DROP TABLE t1;
CREATE TABLE t1 (a int, b int, c int, key using BTREE (a, b, c)) engine=heap;
INSERT INTO t1 VALUES (1, NULL, NULL), (1, 1, NULL), (1, NULL, 1);
SELECT * FROM t1 WHERE a=1 and b IS NULL;
SELECT * FROM t1 WHERE a=1 and c IS NULL;
SELECT * FROM t1 WHERE a=1 and b IS NULL and c IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (a int not null, primary key using BTREE (a)) engine=heap;
INSERT into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
DELETE from t1 where a < 100;
SELECT * from t1;
DROP TABLE t1;
create table t1(a int not null, key using btree(a)) engine=heap;
insert into t1 values (2), (2), (2), (1), (1), (3), (3), (3), (3);
select a from t1 where a > 2 order by a;
delete from t1 where a < 4;
select a from t1 order by a;
insert into t1 values (2), (2), (2), (1), (1), (3), (3), (3), (3);
select a from t1 where a > 4 order by a;
delete from t1 where a > 4;
select a from t1 order by a;
select a from t1 where a > 3 order by a;
delete from t1 where a >= 2;
select a from t1 order by a;
drop table t1;
CREATE TABLE t1 ( c1 CHAR(3), c2 INTEGER, KEY USING BTREE(c1), KEY USING BTREE(c2) ) ENGINE= MEMORY;
INSERT INTO t1 VALUES ('ABC',0), ('A',0), ('B',0), ('C',0);
UPDATE t1 SET c2= c2 + 1 WHERE c1 = 'A';
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 ( c1 ENUM('1', '2'), UNIQUE USING BTREE(c1) ) ENGINE= MEMORY DEFAULT CHARSET= utf8;
INSERT INTO t1 VALUES('1'), ('2');
DROP TABLE t1;
CREATE TABLE t1 ( c1 SET('1', '2'), UNIQUE USING BTREE(c1) ) ENGINE= MEMORY DEFAULT CHARSET= utf8;
INSERT INTO t1 VALUES('1'), ('2');
DROP TABLE t1;