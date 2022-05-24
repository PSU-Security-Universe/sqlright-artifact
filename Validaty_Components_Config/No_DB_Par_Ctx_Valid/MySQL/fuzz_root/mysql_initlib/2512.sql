CREATE TABLE t (a INT, b INT, c INT, d INT, KEY k1(a, b, c, d)) ENGINE=innodb;
CREATE TEMPORARY TABLE a (a INT);
INSERT INTO a VALUES (10);
INSERT INTO a VALUES (9);
INSERT INTO a VALUES (8);
INSERT INTO a VALUES (7);
INSERT INTO a VALUES (6);
INSERT INTO a VALUES (5);
INSERT INTO a VALUES (4);
INSERT INTO a VALUES (3);
INSERT INTO a VALUES (2);
INSERT INTO a VALUES (1);
CREATE TEMPORARY TABLE b (a INT);
INSERT INTO b VALUES (5);
INSERT INTO b VALUES (4);
INSERT INTO b VALUES (3);
INSERT INTO b VALUES (2);
INSERT INTO b VALUES (1);
CREATE TEMPORARY TABLE c (a INT);
INSERT INTO c VALUES (5);
INSERT INTO c VALUES (4);
INSERT INTO c VALUES (3);
INSERT INTO c VALUES (2);
INSERT INTO c VALUES (1);
CREATE TEMPORARY TABLE d (a INT);
INSERT INTO d VALUES (10);
INSERT INTO d VALUES (9);
INSERT INTO d VALUES (8);
INSERT INTO d VALUES (7);
INSERT INTO d VALUES (6);
INSERT INTO d VALUES (5);
INSERT INTO d VALUES (4);
INSERT INTO d VALUES (3);
INSERT INTO d VALUES (2);
INSERT INTO d VALUES (1);
INSERT INTO t SELECT a.a, b.a, c.a, d.a FROM a, b, c, d;
INSERT INTO t VALUES (11, 2, 3, -10);
INSERT INTO t VALUES (11, 3, 3, 20);
INSERT INTO t VALUES (11, 15, NULL, -20);
INSERT INTO t VALUES (11, NULL, 40, 30);
INSERT INTO t VALUES (12, 15, 3, -15);
INSERT INTO t VALUES (12, 15, 40, -20);
INSERT INTO t VALUES (12, 2, 40, -23);
INSERT INTO t VALUES (12, 2, 3, NULL);
DROP TEMPORARY TABLE a, b, c, d;
ANALYZE TABLE t;
EXPLAIN SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15 OR b = 3) AND (c = 3 OR c = 40) GROUP BY a;
FLUSH STATUS;
SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15 OR b = 3) AND (c = 3 OR c = 40) GROUP BY a;
SHOW STATUS LIKE 'handler_read%';
create table group_query SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15 OR b = 3) AND (c = 3 OR c = 40) GROUP BY a;
create table no_group_query SELECT a, MAX(d), MIN(d) FROM t IGNORE INDEX(k1)  WHERE (b = 2 OR b = 15 OR b = 3) AND (c = 3 OR c = 40) GROUP BY a;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-group_query';;
set @@sort_buffer_size = @save_sbs;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.no_group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-no_group_query';;
set @@sort_buffer_size = @save_sbs;
drop tables test.group_query, test.no_group_query;
EXPLAIN SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
FLUSH STATUS;
SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
SHOW STATUS LIKE 'handler_read%';
create table group_query SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
create table no_group_query SELECT a, MAX(d), MIN(d) FROM t IGNORE INDEX(k1)  WHERE (b = 2 OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-group_query';;
set @@sort_buffer_size = @save_sbs;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.no_group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-no_group_query';;
set @@sort_buffer_size = @save_sbs;
drop tables test.group_query, test.no_group_query;
EXPLAIN SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c IS NULL) GROUP BY a;
FLUSH STATUS;
SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c IS NULL) GROUP BY a;
SHOW STATUS LIKE 'handler_read%';
create table group_query SELECT a, MAX(d), MIN(d) FROM t  WHERE (b = 2 OR b = 15) AND (c = 3 OR c IS NULL) GROUP BY a;
create table no_group_query SELECT a, MAX(d), MIN(d) FROM t IGNORE INDEX(k1)  WHERE (b = 2 OR b = 15) AND (c = 3 OR c IS NULL) GROUP BY a;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-group_query';;
set @@sort_buffer_size = @save_sbs;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.no_group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-no_group_query';;
set @@sort_buffer_size = @save_sbs;
drop tables test.group_query, test.no_group_query;
EXPLAIN SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
FLUSH STATUS;
SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
SHOW STATUS LIKE 'handler_read%';
create table group_query SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
create table no_group_query SELECT a, MAX(d), MIN(d) FROM t IGNORE INDEX(k1)  WHERE (b IS NULL OR b = 15) AND (c = 3 OR c = 40) GROUP BY a;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-group_query';;
set @@sort_buffer_size = @save_sbs;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.no_group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-no_group_query';;
set @@sort_buffer_size = @save_sbs;
drop tables test.group_query, test.no_group_query;
EXPLAIN SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 2) AND (c = 3 OR c = 40) GROUP BY a;
FLUSH STATUS;
SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 2) AND (c = 3 OR c = 40) GROUP BY a;
SHOW STATUS LIKE 'handler_read%';
create table group_query SELECT a, MAX(d), MIN(d) FROM t  WHERE (b IS NULL OR b = 2) AND (c = 3 OR c = 40) GROUP BY a;
create table no_group_query SELECT a, MAX(d), MIN(d) FROM t IGNORE INDEX(k1)  WHERE (b IS NULL OR b = 2) AND (c = 3 OR c = 40) GROUP BY a;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-group_query';;
set @@sort_buffer_size = @save_sbs;
set @save_sbs = @@sort_buffer_size;
set @@sort_buffer_size = 1048576;
SELECT * FROM test.no_group_query ORDER BY `a`,`MAX(d)`,`MIN(d)` INTO OUTFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/mysqld.1/data//diff_table--test-no_group_query';;
set @@sort_buffer_size = @save_sbs;
drop tables test.group_query, test.no_group_query;
EXPLAIN SELECT a FROM t  WHERE (b = 2 OR b = 15 OR b = 3) AND (c = 3 OR c = 40) GROUP BY a;
