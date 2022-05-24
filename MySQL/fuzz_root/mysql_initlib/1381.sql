set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;
SET @old_log_output = @@global.log_output;
SET GLOBAL LOG_OUTPUT = 'FILE';
flush status;
show status like 'Table_lock%';
select * from performance_schema.session_status where variable_name like 'Table_lock%';
set sql_log_bin=0;
set @old_general_log = @@global.general_log;
set global general_log = 'OFF';
drop table if exists t1;
create table t1(n int);
insert into t1 values(1);
select get_lock('mysqltest_lock', 100);
update t1 set n = get_lock('mysqltest_lock', 100) ;
update t1 set n = 3;
select release_lock('mysqltest_lock');
select release_lock('mysqltest_lock');
show status like 'Table_locks_waited';
drop table t1;
set global general_log = @old_general_log;
select 1;
show status like 'last_query_cost';
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
insert into t1 values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
analyze table t1;
select * from t1 where a=6;
show status like 'last_query_cost';
show status like 'last_query_cost';
select 1;
show status like 'last_query_cost';
drop table t1;
FLUSH STATUS;
SET @wait_left = 10;
SET @max_used_connections = SUBSTRING('Max_used_connections	1', 21)+0;
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SET @save_thread_cache_size=@@thread_cache_size;
SET GLOBAL thread_cache_size=3;
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
FLUSH STATUS;
SET @wait_left = 10;
SET @max_used_connections = SUBSTRING('Max_used_connections	2', 21)+0;
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SHOW STATUS LIKE 'max_used_connections';
SELECT * FROM performance_schema.session_status WHERE VARIABLE_NAME LIKE 'max_used_connections';
SET GLOBAL thread_cache_size=@save_thread_cache_size;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1), (2);
analyze table t1;
SELECT a FROM t1 LIMIT 1;
SHOW SESSION STATUS LIKE 'Last_query_cost';
EXPLAIN SELECT a FROM t1;
SHOW SESSION STATUS LIKE 'Last_query_cost';
SELECT a FROM t1 UNION SELECT a FROM t1 ORDER BY a;
SHOW SESSION STATUS LIKE 'Last_query_cost';
EXPLAIN SELECT a FROM t1 UNION SELECT a FROM t1 ORDER BY a;
SHOW SESSION STATUS LIKE 'Last_query_cost';
SELECT a IN (SELECT a FROM t1) FROM t1 LIMIT 1;
SHOW SESSION STATUS LIKE 'Last_query_cost';
SELECT (SELECT a FROM t1 LIMIT 1) x FROM t1 LIMIT 1;
SHOW SESSION STATUS LIKE 'Last_query_cost';
SELECT * FROM t1 a, t1 b ORDER BY a.a, b.a LIMIT 1;
SHOW SESSION STATUS LIKE 'Last_query_cost';
DROP TABLE t1;
flush status;
show status like 'Com%function';
create function f1 (x INTEGER) returns integer begin declare ret integer; set ret = x * 10; return ret; end ;
drop function f1;
show status like 'Com%function';
create database db37908;
create table db37908.t1(f1 int);
insert into db37908.t1 values(1);
create function func37908() returns int sql security invoker return (select * from db37908.t1 limit 1);
select * from db37908.t1;
show status where variable_name ='uptime' and 2 in (select * from db37908.t1);
show procedure status where name ='proc37908' and 1 in (select f1 from db37908.t1);
show function status where name ='func37908' and 1 in (select func37908());
drop database db37908;
drop procedure proc37908;
drop function func37908;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
CREATE FUNCTION f1() RETURNS INTEGER BEGIN DECLARE foo INTEGER; DECLARE bar INTEGER; SET foo=1; SET bar=2; RETURN foo; END ;
CREATE PROCEDURE p1() BEGIN SELECT 1; END ;
SELECT f1();
CALL p1();
SELECT 9;
DROP PROCEDURE p1;
DROP FUNCTION f1;
create table t1 (i int);
create table t2 (j int);
create table t3 (k int);
flush tables;
flush status;
set @old_table_open_cache= @@table_open_cache;
show status like 'table_open_cache_%';
select * from t1;
show status like 'table_open_cache_%';
select * from t1;
show status like 'table_open_cache_%';
select * from t2;
show status like 'table_open_cache_%';
select * from t2;
show status like 'table_open_cache_%';
select * from t1 as a, t2 as b, t1 as c, t2 as d, t1 as e, t2 as f;
show status like 'table_open_cache_%';
