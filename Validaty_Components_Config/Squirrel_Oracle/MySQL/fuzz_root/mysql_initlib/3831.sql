drop table if exists t1;
CREATE TABLE t1 ( id INT NOT NULL, name VARCHAR(255), department VARCHAR(10), country VARCHAR(255) ) PARTITION BY LIST COLUMNS (department, country) ( PARTITION first_office VALUES IN (('dep1', 'Russia'), ('dep1', 'Croatia')), PARTITION second_office VALUES IN (('dep2', 'Russia')) );
INSERT INTO t1 VALUES(1, 'Ann', 'dep1', 'Russia');
INSERT INTO t1 VALUES(2, 'Bob', 'dep1', 'Croatia');
INSERT INTO t1 VALUES(3, 'Cecil', 'dep2', 'Russia');
INSERT INTO t1 VALUES(3, 'Dan', 'dep2', 'Croatia');
SELECT PARTITION_NAME,TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 't1';
SHOW CREATE TABLE t1;
SELECT * FROM t1 WHERE department = 'dep2' and country = 'Croatia';
SELECT * FROM t1 WHERE department = 'dep1' and country = 'Croatia';
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL) PARTITION BY RANGE COLUMNS (a) (PARTITION p0 VALUES LESS THAN (0));
CREATE TABLE t1 (a BLOB) PARTITION BY RANGE COLUMNS (a) (PARTITION p0 VALUES LESS THAN ("X"));
CREATE TABLE t1 (a TEXT) PARTITION BY RANGE COLUMNS (a) (PARTITION p0 VALUES LESS THAN ("X"));
CREATE TABLE t1 (a FLOAT) PARTITION BY RANGE COLUMNS (a) (PARTITION p0 VALUES LESS THAN (0.0));
CREATE TABLE t1 (a DOUBLE) PARTITION BY RANGE COLUMNS (a) (PARTITION p0 VALUES LESS THAN (0.0));
CREATE TABLE t1 (d TIMESTAMP) PARTITION BY RANGE COLUMNS(d) (PARTITION p0 VALUES LESS THAN ('2000-01-01'), PARTITION p1 VALUES LESS THAN ('2040-01-01'));
CREATE TABLE t1 (d BIT(1)) PARTITION BY RANGE COLUMNS(d) (PARTITION p0 VALUES LESS THAN (0), PARTITION p1 VALUES LESS THAN (1));
CREATE TABLE t1 (d ENUM("YES","NO")) PARTITION BY RANGE COLUMNS(d) (PARTITION p0 VALUES LESS THAN ("NO"), PARTITION p1 VALUES LESS THAN (MAXVALUE));
CREATE TABLE t1 (d SET("Car","MC")) PARTITION BY RANGE COLUMNS(d) (PARTITION p0 VALUES LESS THAN ("MC"), PARTITION p1 VALUES LESS THAN (MAXVALUE));
create table t1 (a int, b int) partition by range columns (a,b) ( partition p0 values less than (maxvalue, 10), partition p1 values less than (maxvalue, maxvalue));
create table t1 (a int, b int, c int) partition by range columns (a,b,c) ( partition p0 values less than (1, maxvalue, 10), partition p1 values less than (1, maxvalue, maxvalue));
create table t1 (a varchar(5) character set ucs2 collate ucs2_bin) partition by range columns (a) (partition p0 values less than (0x0041));
insert into t1 values (0x00410000);
select hex(a) from t1 where a like 'A_';
analyze table t1;
explain select hex(a) from t1 where a like 'A_';
alter table t1 remove partitioning;
select hex(a) from t1 where a like 'A_';
create index a on t1 (a);
select hex(a) from t1 where a like 'A_';
insert into t1 values ('A_');
select hex(a) from t1;
drop table t1;
set names latin1;
create table t1 (a varchar(1) character set latin1 collate latin1_general_ci) partition by range columns(a) ( partition p0 values less than ('a'), partition p1 values less than ('b'), partition p2 values less than ('c'), partition p3 values less than ('d'));
insert into t1 values ('A'),('a'),('B'),('b'),('C'),('c');
select * from t1 where a > 'B' collate latin1_bin;
select * from t1 where a <> 'B' collate latin1_bin;
alter table t1 remove partitioning;
select * from t1 where a > 'B' collate latin1_bin;
select * from t1 where a <> 'B' collate latin1_bin;
drop table t1;
create table t1 (a varchar(2) character set latin1, b varchar(2) character set latin1) partition by list columns(a,b) (partition p0 values in (('a','a')));
insert into t1 values ('A','A');
select * from t1 where b <> 'a' collate latin1_bin AND a = 'A' collate latin1_bin;
alter table t1 remove partitioning;
select * from t1 where b <> 'a' collate latin1_bin AND a = 'A' collate latin1_bin;
drop table t1;
set names utf8mb4;
create table t1 (a varchar(5)) partition by list columns(a) ( partition p0 values in ('\''),   partition p1 values in ('\\'),   partition p2 values in ('\0'));
show create table t1;
drop table t1;
set @@sql_mode=allow_invalid_dates;
create table t1 (a char, b char, c date) partition by range columns (a,b,c) ( partition p0 values less than (0,0,to_days('3000-11-31')));
create table t1 (a char, b char, c date) partition by range columns (a,b,c) ( partition p0 values less than (0,0,'3000-11-31'));
set @@sql_mode='';
create table t1 (a int, b char(10), c varchar(25), d datetime) partition by range columns(a,b,c,d) subpartition by hash (to_seconds(d)) subpartitions 4 ( partition p0 values less than (1, 0, MAXVALUE, '1900-01-01'), partition p1 values less than (1, 'a', MAXVALUE, '1999-01-01'), partition p2 values less than (1, 'a', MAXVALUE, MAXVALUE), partition p3 values less than (1, MAXVALUE, MAXVALUE, MAXVALUE));
create table t1 (a int, b char(10), c varchar(25), d datetime) partition by range columns(a,b,c,d) subpartition by hash (to_seconds(d)) subpartitions 4 ( partition p0 values less than (1, '0', MAXVALUE, '1900-01-01'), partition p1 values less than (1, 'a', MAXVALUE, '1999-01-01'), partition p2 values less than (1, 'b', MAXVALUE, MAXVALUE), partition p3 values less than (1, MAXVALUE, MAXVALUE, MAXVALUE));
select partition_method, partition_expression, partition_description from information_schema.partitions where table_name = "t1";
show create table t1;
drop table t1;
create table t1 (a int, b int) partition by range columns (a,b) (partition p0 values less than (NULL, maxvalue));
create table t1 (a int, b int) partition by list columns(a,b) ( partition p0 values in ((maxvalue, 0)));
create table t1 (a int, b int) partition by list columns (a,b) ( partition p0 values in ((0,0)));
alter table t1 add partition (partition p1 values in (maxvalue, maxvalue));
drop table t1;
create table t1 (a int, b int) partition by key (a,a);
create table t1 (a int, b int) partition by list columns(a,a) ( partition p values in ((1,1)));
create table t1 (a int signed) partition by list (a) ( partition p0 values in (1, 3, 5, 7, 9, NULL), partition p1 values in (2, 4, 6, 8, 0));
insert into t1 values (NULL),(0),(1),(2),(2),(4),(4),(4),(8),(8);
select * from t1 where NULL <= a;
select * from t1 where a is null;
analyze table t1;
explain select * from t1 where a is null;
select * from t1 where a <= 1;
drop table t1;
create table t1 (a int signed) partition by list columns(a) ( partition p0 values in (1, 3, 5, 7, 9, NULL), partition p1 values in (2, 4, 6, 8, 0));
insert into t1 values (NULL),(0),(1),(2),(2),(4),(4),(4),(8),(8);
select * from t1 where a <= NULL;
select * from t1 where a is null;
analyze table t1;
explain select * from t1 where a is null;
select * from t1 where a <= 1;
drop table t1;
create table t1 (a int, b int) partition by list columns(a,b) ( partition p0 values in ((1, NULL), (2, NULL), (NULL, NULL)), partition p1 values in ((1,1), (2,2)), partition p2 values in ((3, NULL), (NULL, 1)));
select partition_method, partition_expression, partition_description from information_schema.partitions where table_name = "t1";
show create table t1;
insert into t1 values (3, NULL);
insert into t1 values (NULL, 1);
insert into t1 values (NULL, NULL);
insert into t1 values (1, NULL);
insert into t1 values (2, NULL);
insert into t1 values (1,1);
insert into t1 values (2,2);
select * from t1 where a = 1;
select * from t1 where a = 2;
select * from t1 where a > 8;
select * from t1 where a not between 8 and 8;
show create table t1;
drop table t1;
create table t1 (a int) partition by list (a) ( partition p0 values in (1), partition p1 values in (1));
create table t1 (a int) partition by list (a) ( partition p0 values in (2, 1), partition p1 values in (4, NULL, 3));
select partition_method, partition_expression, partition_description from information_schema.partitions where table_name = "t1";
show create table t1;
insert into t1 values (1);
insert into t1 values (2);
insert into t1 values (3);
insert into t1 values (4);
insert into t1 values (NULL);
insert into t1 values (5);
drop table t1;
create table t1 (a int) partition by list columns(a) ( partition p0 values in (2, 1), partition p1 values in ((4), (NULL), (3)));
create table t1 (a int) partition by list columns(a) ( partition p0 values in (2, 1), partition p1 values in (4, NULL, 3));
select partition_method, partition_expression, partition_description from information_schema.partitions where table_name = "t1";
show create table t1;
insert into t1 values (1);
insert into t1 values (2);
insert into t1 values (3);
insert into t1 values (4);
insert into t1 values (NULL);
insert into t1 values (5);
