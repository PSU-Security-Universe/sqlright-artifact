set optimizer_switch='semijoin=off';
set optimizer_switch='materialization=off';
set optimizer_switch='index_condition_pushdown=off';
set optimizer_switch='mrr=off';
drop table if exists t1, t2;
select 1 in (1,2,3);
select 10 in (1,2,3);
select NULL in (1,2,3);
select 1 in (1,NULL,3);
select 3 in (1,NULL,3);
select 10 in (1,NULL,3);
select 1.5 in (1.5,2.5,3.5);
select 10.5 in (1.5,2.5,3.5);
select NULL in (1.5,2.5,3.5);
select 1.5 in (1.5,NULL,3.5);
select 3.5 in (1.5,NULL,3.5);
select 10.5 in (1.5,NULL,3.5);
CREATE TABLE t1 (a int, b int, c int);
insert into t1 values (1,2,3), (1,NULL,3);
select 1 in (a,b,c) from t1;
select 3 in (a,b,c) from t1;
select 10 in (a,b,c) from t1;
select NULL in (a,b,c) from t1;
drop table t1;
CREATE TABLE t1 (a float, b float, c float);
insert into t1 values (1.5,2.5,3.5), (1.5,NULL,3.5);
select 1.5 in (a,b,c) from t1;
select 3.5 in (a,b,c) from t1;
select 10.5 in (a,b,c) from t1;
drop table t1;
CREATE TABLE t1 (a varchar(10), b varchar(10), c varchar(10));
insert into t1 values ('A','BC','EFD'), ('A',NULL,'EFD');
select 'A' in (a,b,c) from t1;
select 'EFD' in (a,b,c) from t1;
select 'XSFGGHF' in (a,b,c) from t1;
drop table t1;
CREATE TABLE t1 (field char(1));
INSERT INTO t1 VALUES ('A'),(NULL);
SELECT * from t1 WHERE field IN (NULL);
SELECT * from t1 WHERE field NOT IN (NULL);
SELECT * from t1 where field = field;
SELECT * from t1 where field <=> field;
DELETE FROM t1 WHERE field NOT IN (NULL);
SELECT * FROM t1;
drop table t1;
create table t1 (id int(10) primary key);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9);
select * from t1 where id in (2,5,9);
drop table t1;
create table t1 ( a char(1) character set latin1 collate latin1_general_ci, b char(1) character set latin1 collate latin1_swedish_ci, c char(1) character set latin1 collate latin1_danish_ci );
insert into t1 values ('A','B','C');
insert into t1 values ('a','c','c');
select * from t1 where a in (b);
select * from t1 where a in (b,c);
select * from t1 where 'a' in (a,b,c);
select * from t1 where 'a' in (a);
select * from t1 where a in ('a');
set names latin1;
select * from t1 where 'a' collate latin1_general_ci in (a,b,c);
select * from t1 where 'a' collate latin1_bin in (a,b,c);
select * from t1 where 'a' in (a,b,c collate latin1_bin);
explain select * from t1 where 'a' in (a,b,c collate latin1_bin);
drop table t1;
set names utf8mb4;
set names utf8;
create table t1 (a char(10) character set utf8 not null);
insert into t1 values ('bbbb'),(_koi8r x'C3C3C3C3'),(_latin1 x'C4C4C4C4');
select a from t1 where a in ('bbbb',_koi8r x'C3C3C3C3',_latin1 x'C4C4C4C4') order by a;
drop table t1;
create table t1 (a char(10) character set latin1 not null);
insert into t1 values ('a'),('b'),('c');
select a from t1 where a IN ('a','b','c') order by a;
drop table t1;
set names latin1;
select '1.0' in (1,2);
select 1 in ('1.0',2);
select 1 in (1,'2.0');
select 1 in ('1.0',2.0);
select 1 in (1.0,'2.0');
select 1 in ('1.1',2);
select 1 in ('1.1',2.0);
create table t1 (a char(2) character set binary);
insert into t1 values ('aa'), ('bb');
select * from t1 where a in (NULL, 'aa');
drop table t1;
create table t1 (id int, key(id));
insert into t1 values (1),(2),(3);
select count(*) from t1 where id not in (1);
select count(*) from t1 where id not in (1,2);
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 SELECT 1 IN (2, NULL);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a int PRIMARY KEY);
INSERT INTO t1 VALUES (44), (45), (46);
SELECT * FROM t1 WHERE a IN (45);
SELECT * FROM t1 WHERE a NOT IN (0, 45);
SELECT * FROM t1 WHERE a NOT IN (45);
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a NOT IN (45);
SHOW CREATE VIEW v1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2 (a int, filler char(200), key(a));
insert into t2 select C.a*2,   'no'  from t1 A, t1 B, t1 C;
insert into t2 select C.a*2+1, 'yes' from t1 C;
explain  select * from t2 where a NOT IN (0, 2,4,6,8,10,12,14,16,18);
select * from t2 where a NOT IN (0, 2,4,6,8,10,12,14,16,18);
explain select * from t2 force index(a) where a NOT IN (2,2,2,2,2,2);
explain select * from t2 force index(a) where a <> 2;
drop table t2;
create table t2 (a datetime, filler char(200), key(a));
insert into t2 select '2006-04-25 10:00:00' + interval C.a minute, 'no'  from t1 A, t1 B, t1 C where C.a % 2 = 0;
insert into t2 select '2006-04-25 10:00:00' + interval C.a*2+1 minute, 'yes' from t1 C;
explain  select * from t2 where a NOT IN ( '2006-04-25 10:00:00','2006-04-25 10:02:00','2006-04-25 10:04:00',  '2006-04-25 10:06:00', '2006-04-25 10:08:00');
select * from t2 where a NOT IN ( '2006-04-25 10:00:00','2006-04-25 10:02:00','2006-04-25 10:04:00',  '2006-04-25 10:06:00', '2006-04-25 10:08:00');
drop table t2;
create table t2 (a varchar(10), filler char(200), key(a));
insert into t2 select 'foo', 'no' from t1 A, t1 B;
