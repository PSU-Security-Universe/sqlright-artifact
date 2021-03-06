drop table if exists t1,t2,t3;
create table t1 (a int not null,b int not null, primary key (a)) engine=heap comment="testing heaps" avg_row_length=100 min_rows=1 max_rows=100;
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a=1 or a=0;
analyze table t1;
show keys from t1;
select * from t1;
select * from t1 where a=4;
update t1 set b=5 where a=4;
update t1 set b=b+1 where a>=3;
replace t1 values (3,3);
select * from t1;
alter table t1 add c int not null, add key (c,a);
drop table t1;
create table t1 (a int not null,b int not null, primary key (a)) engine=memory comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
delete from t1 where a > 0;
select * from t1;
drop table t1;
create table t1 (a int not null,b int not null, primary key (a)) engine=heap comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
alter table t1 modify a int not null auto_increment, engine=innodb, comment="new innodb table";
select * from t1;
drop table t1;
create table t1 (a int not null) engine=heap;
insert into t1 values (869751),(736494),(226312),(802616),(728912);
select * from t1 where a > 736494;
alter table t1 add unique uniq_id(a);
select * from t1 where a > 736494;
select * from t1 where a = 736494;
select * from t1 where a=869751 or a=736494;
select * from t1 where a in (869751,736494,226312,802616);
alter table t1 engine=innodb;
explain select * from t1 where a in (869751,736494,226312,802616);
drop table t1;
create table t1 (x int not null, y int not null, key x (x), unique y (y)) engine=heap;
insert into t1 values (1,1),(2,2),(1,3),(2,4),(2,5),(2,6);
select * from t1 where x=1;
select * from t1,t1 as t2 where t1.x=t2.y;
explain select * from t1,t1 as t2 where t1.x=t2.y;
drop table t1;
create table t1 (a int) engine=heap;
insert into t1 values(1);
select max(a) from t1;
drop table t1;
CREATE TABLE t1 ( a int not null default 0, b int not null default 0,  key(a),  key(b)  ) ENGINE=HEAP;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
insert into t1 values(1,1),(1,2),(2,3),(1,3),(1,4),(1,5),(1,6);
select * from t1 where a=1;
drop table t1;
create table t1 (id int unsigned not null, primary key (id)) engine=HEAP;
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
create table t1 (btn char(10) not null, key(btn)) charset utf8mb4 engine=heap;
insert into t1 values ("hello"),("hello"),("hello"),("hello"),("hello"),("a"),("b"),("c"),("d"),("e"),("f"),("g"),("h"),("i");
explain select * from t1 where btn like "q%";
select * from t1 where btn like "q%";
alter table t1 add column new_col char(1) not null, add key (btn,new_col), drop key btn;
update t1 set new_col=left(btn,1);
explain select * from t1 where btn="a";
explain select * from t1 where btn="a" and new_col="a";
drop table t1;
CREATE TABLE t1 ( a int default NULL, b int default NULL, KEY a (a), UNIQUE b (b) ) engine=heap;
INSERT INTO t1 VALUES (NULL,99),(99,NULL),(1,1),(2,2),(1,3);
SELECT * FROM t1 WHERE a=NULL;
explain SELECT * FROM t1 WHERE a IS NULL;
SELECT * FROM t1 WHERE a<=>NULL;
SELECT * FROM t1 WHERE b=NULL;
explain SELECT * FROM t1 WHERE b IS NULL;
SELECT * FROM t1 WHERE b<=>NULL;
INSERT INTO t1 VALUES (1,3);
DROP TABLE t1;
CREATE TABLE t1 ( a int default NULL, key a (a) ) ENGINE=HEAP;
INSERT INTO t1 VALUES (10), (10), (10);
EXPLAIN SELECT * FROM t1 WHERE a=10;
SELECT * FROM t1 WHERE a=10;
DROP TABLE t1;
CREATE TABLE t1 (a int not null, primary key(a)) engine=heap;
INSERT into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11);
DELETE from t1 where a < 100;
SELECT * from t1;
DROP TABLE t1;
CREATE TABLE `job_titles` ( `job_title_id` int(6) unsigned NOT NULL default '0', `job_title` char(18) NOT NULL default '', PRIMARY KEY  (`job_title_id`), UNIQUE KEY `job_title_id` (`job_title_id`,`job_title`) ) ENGINE=HEAP;
SELECT MAX(job_title_id) FROM job_titles;
DROP TABLE job_titles;
CREATE TABLE t1 (a INT NOT NULL, B INT, KEY(B)) ENGINE=HEAP;
INSERT INTO t1 VALUES(1,1), (1,NULL);
SELECT * FROM t1 WHERE B is not null;
DROP TABLE t1;
CREATE TABLE t1 (pseudo char(35) PRIMARY KEY, date int(10) unsigned NOT NULL) ENGINE=HEAP;
INSERT INTO t1 VALUES ('massecot',1101106491),('altec',1101106492),('stitch+',1101106304),('Seb Corgan',1101106305),('beerfilou',1101106263),('flaker',1101106529),('joce8',5),('M4vrick',1101106418),('gabay008',1101106525),('Vamp irX',1101106291),('ZoomZip',1101106546),('rip666',1101106502),('CBP ',1101106397),('guezpard',1101106496);
DELETE FROM t1 WHERE date<1101106546;
SELECT * FROM t1;
DROP TABLE t1;
create table t1(a char(2)) engine=memory;
insert into t1 values (NULL), (NULL);
delete from t1 where a is null;
insert into t1 values ('2'), ('3');
select * from t1;
drop table t1;
