drop table if exists t1,t2;
create table t1 ( n int auto_increment primary key);
lock tables t1 write;
insert into t1 values(NULL);
unlock tables;
check table t1;
lock tables t1 write, t1 as t0 read;
insert into t1 values(NULL);
unlock tables;
check table t1;
lock tables t1 write, t1 as t0 read, t1 as t2 read;
insert into t1 values(NULL);
unlock tables;
check table t1;
lock tables t1 write, t1 as t0 write, t1 as t2 read;
insert into t1 values(NULL);
unlock tables;
check table t1;
lock tables t1 write, t1 as t0 write, t1 as t2 read, t1 as t3 read;
insert into t1 values(NULL);
unlock tables;
check table t1;
lock tables t1 write, t1 as t0 write, t1 as t2 write;
insert into t1 values(NULL);
unlock tables;
check table t1;
drop table t1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
lock tables t1 write,t1 as b write, t2 write, t2 as c read;
drop table t1,t2;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
lock tables t1 write,t1 as b write, t2 write, t2 as c read;
drop table t2,t1;
unlock tables;
create temporary table t1(f1 int);
lock tables t1 write;
insert into t1 values (1);
show columns from t1;
insert into t1 values(2);
drop table t1;
unlock tables;
CREATE TABLE t1(a INT);
CREATE PROCEDURE p1() CREATE VIEW v1 AS SELECT * FROM t1;
CREATE TRIGGER trg_p1_t1 AFTER INSERT ON t1 FOR EACH ROW CALL p1();
LOCK TABLES t1 WRITE;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
CREATE VIEW v1 AS SELECT a+1 FROM t1;
LOCK TABLES t1 WRITE;
UNLOCK TABLES;
INSERT INTO t1 VALUES (1);
DROP TRIGGER trg_p1_t1;
DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t2(a INT);
CREATE PROCEDURE p1() RENAME TABLE t2 TO t3;
CREATE FUNCTION f1() RETURNS INT BEGIN CALL p1(); RETURN 1; END ;
SELECT f1();
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP TABLE t2;
