reset master;
set timestamp=1000000000;
drop table if exists t1,t2,t3,t4,t5,t03,t04;
create table t1 (word varchar(20));
create table t2 (id int auto_increment not null primary key);
insert into t1 values ("abirvalg");
insert into t2 values ();
load data infile '../../std_data/words.dat' into table t1;
load data infile '../../std_data/words.dat' into table t1;
load data infile '../../std_data/words.dat' into table t1;
load data infile '../../std_data/words.dat' into table t1;
load data infile '../../std_data/words.dat' into table t1;
insert into t1 values ("Alas");
flush logs;
select "--- Local --" as "";
drop table t1,t2;
flush logs;
flush logs;
select * from t5  /* must be (1),(1) */;
drop table t5;
flush logs;
create table t5 (c1 int, c2 varchar(128) character set latin1 not null);
insert into t5 values (1, date_format('2001-01-01','%W'));
set lc_time_names=de_DE;
insert into t5 values (2, date_format('2001-01-01','%W'));
set lc_time_names=en_US;
insert into t5 values (3, date_format('2001-01-01','%W'));
select * from t5 order by c1;
flush logs;
drop table t5;
select * from t5 order by c1;
drop table t5;
drop procedure if exists p1;
flush logs;
flush logs;
call p1();
drop procedure p1;
call p1();
call p1();
drop procedure p1;
flush logs;
create table t1 (a varchar(64) character set utf8);
load data infile '../../std_data/loaddata6.dat' into table t1 CHARACTER SET latin1;
set character_set_database=koi8r;
load data infile '../../std_data/loaddata6.dat' into table t1;
set character_set_database=latin1;
load data infile '../../std_data/loaddata6.dat' into table t1;
load data infile '../../std_data/loaddata6.dat' into table t1;
set character_set_database=koi8r;
load data infile '../../std_data/loaddata6.dat' into table t1;
set character_set_database=latin1;
load data infile '../../std_data/loaddata6.dat' into table t1;
load data infile '../../std_data/loaddata6.dat' into table t1 character set koi8r;
select hex(a) from t1;
drop table t1;
flush logs;
CREATE TABLE t1 (c1 CHAR(10));
FLUSH LOGS;
INSERT INTO t1 VALUES ('0123456789');
FLUSH LOGS;
DROP TABLE t1;
CREATE TABLE patch (a BLOB);
LOAD DATA LOCAL INFILE '/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/mysqlbinlog_tmp.dat'      INTO TABLE patch FIELDS TERMINATED BY '' LINES STARTING BY '#';
SELECT COUNT(*) AS `BUG#28293_expect_3` FROM patch WHERE a LIKE '%Query%';
DROP TABLE patch;
FLUSH LOGS;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(connection_id());
FLUSH LOGS;
DROP TABLE t1;
DROP TABLE t1;
set timestamp= default;
FLUSH LOGS;
SET BINLOG_FORMAT='ROW';
CREATE DATABASE mysqltest1;
USE mysqltest1;
CREATE TABLE t1 (a INT, b CHAR(64));
flush logs;
INSERT INTO t1 VALUES (1,USER());
flush logs;
INSERT INTO t1 VALUES (1,USER());
SELECT * FROM t1;
DROP DATABASE mysqltest1;
USE test;
SET BINLOG_FORMAT = STATEMENT;
FLUSH LOGS;
CREATE TABLE t1 (a_real FLOAT, an_int INT, a_decimal DECIMAL(5,2), a_string CHAR(32));
SET @a_real = rand(20) * 1000;
SET @an_int = 1000;
SET @a_decimal = CAST(rand(19) * 999 AS DECIMAL(5,2));
SET @a_string = 'Just a test';
INSERT INTO t1 VALUES (@a_real, @an_int, @a_decimal, @a_string);
FLUSH LOGS;
SELECT * FROM t1;
DROP TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
SET @@global.server_id= 4294967295;
RESET MASTER;
FLUSH LOGS;
SELECT (@a:=LOAD_FILE("/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/mysqlbinlog_bug37313.binlog")) IS NOT NULL AS Loaded;
SET @@global.server_id= 1;
RESET MASTER;
FLUSH LOGS;
RESET MASTER;
FLUSH LOGS;
RESET MASTER;
CREATE TABLE t1 SELECT 1;
FLUSH LOGS;
DROP TABLE t1;
RESET MASTER;
CREATE DATABASE test1;
USE test1;
CREATE TABLE t1(id int);
DROP DATABASE test1;
CREATE DATABASE test1;
