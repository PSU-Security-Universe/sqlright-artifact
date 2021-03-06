drop table if exists t1,t2;
drop view if exists v1;
CREATE TABLE t1 (c int not null, d char (10) not null);
CREATE TEMPORARY TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(4,"e"),(5,"f"),(6,"g");
alter table t1 rename t2;
select * from t1;
select * from t2;
CREATE TABLE t2 (x int not null, y int not null);
alter table t2 rename t1;
select * from t1;
create TEMPORARY TABLE t2 engine=heap select * from t1;
create TEMPORARY TABLE IF NOT EXISTS t2 (a int) engine=heap;
CREATE TEMPORARY TABLE t1 (a int not null, b char (10) not null);
ALTER TABLE t1 RENAME t2;
select * from t2;
alter table t2 add primary key (a,b);
drop table t1,t2;
select * from t1;
drop table t2;
create temporary table t1 select *,2 as "e" from t1;
select * from t1;
drop table t1;
drop table t1;
CREATE TABLE t1 (pkCrash INTEGER PRIMARY KEY,strCrash VARCHAR(255));
INSERT INTO t1 ( pkCrash, strCrash ) VALUES ( 1, '1');
SELECT CONCAT_WS(pkCrash, strCrash) FROM t1;
drop table t1;
create temporary table t1 select 1 as 'x';
drop table t1;
CREATE TABLE t1 (x INT);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TEMPORARY TABLE tmp SELECT *, NULL FROM t1;
drop table t1;
create temporary table t1 (id int(10) not null unique);
create temporary table t2 (id int(10) not null primary key, val int(10) not null);
insert into t1 values (1),(2),(4);
insert into t2 values (1,1),(2,1),(3,1),(4,2);
select one.id, two.val, elt(two.val,'one','two') from t1 one, t2 two where two.id=one.id order by one.id;
drop table t1,t2;
create temporary table t1 (a int not null);
insert into t1 values (1),(1);
alter table t1 add primary key (a);
drop table t1;
create temporary table v1 as select 'This is temp. table' A;
create view v1 as select 'This is view' A;
select * from v1;
show create table v1;
show create view v1;
drop view v1;
select * from v1;
create view v1 as select 'This is view again' A;
select * from v1;
drop table v1;
select * from v1;
drop view v1;
create table t1 (a int, b int, index(a), index(b));
create table t2 (c int auto_increment, d varchar(255), primary key (c));
insert into t1 values (3,1),(3,2);
insert into t2 values (NULL, 'foo'), (NULL, 'bar');
select d, c from t1 left join t2 on b = c where a = 3 order by d;
drop table t1, t2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (i INT);
LOCK TABLE t1 WRITE;
CREATE TEMPORARY TABLE t1 (i INT);
DROP TEMPORARY TABLE t1;
DROP TABLE t1;
CREATE TABLE t1 (i INT);
CREATE TEMPORARY TABLE t2 (i INT);
DROP TEMPORARY TABLE t2, t1;
SELECT * FROM t2;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 ( c FLOAT( 20, 14 ) );
INSERT INTO t1 VALUES( 12139 );
CREATE TABLE t2 ( c FLOAT(30,18) );
INSERT INTO t2 VALUES( 123456 );
SELECT AVG( c ) FROM t1 UNION SELECT 1;
SELECT 1 UNION SELECT AVG( c ) FROM t1;
SELECT 1 UNION SELECT * FROM t2 UNION SELECT 1;
SELECT c/1 FROM t1 UNION SELECT 1;
DROP TABLE t1, t2;
create temporary table t1 (a int);
insert into t1 values (4711);
select * from t1;
truncate t1;
insert into t1 values (42);
select * from t1;
drop table t1;
CREATE TEMPORARY TABLE t1(a INT, b VARCHAR(20));
INSERT INTO t1 VALUES(1, 'val1'), (2, 'val2'), (3, 'val3');
DELETE FROM t1 WHERE a=1;
SELECT count(*) FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1,t2;
DROP FUNCTION IF EXISTS f1;
CREATE TEMPORARY TABLE t1 (a INT);
CREATE TEMPORARY TABLE t2 LIKE t1;
CREATE FUNCTION f1() RETURNS INT BEGIN return 1; END;
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t1 SELECT f1();
CREATE TABLE t3 SELECT * FROM t1;
INSERT INTO t1 SELECT f1();
UPDATE t1,t2 SET t1.a = t2.a;
INSERT INTO t2 SELECT f1();
DROP TABLE t1,t2,t3;
DROP FUNCTION f1;
DROP TEMPORARY TABLE IF EXISTS bug48067.t1;
DROP DATABASE IF EXISTS bug48067;
CREATE DATABASE bug48067;
CREATE TABLE bug48067.t1 (c1 int);
INSERT INTO bug48067.t1 values (1);
CREATE TEMPORARY TABLE bug48067.t1 (c1 int);
DROP DATABASE bug48067;
DROP TEMPORARY table bug48067.t1;
DROP TABLE IF EXISTS t1,t2;
CREATE TEMPORARY TABLE t1(a INT);
CREATE TEMPORARY TABLE t2(b INT);
