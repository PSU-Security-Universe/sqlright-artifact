drop table if exists t1, t2;
CREATE TABLE t1 ( a INT, b INT, KEY a (a,b) ) PARTITION BY HASH (a) PARTITIONS 1;
INSERT INTO t1 VALUES (0, 580092), (3, 894076), (4, 805483), (4, 913540), (6, 611137), (8, 171602), (9, 599495), (9, 746305), (10, 272829), (10, 847519), (12, 258869), (12, 929028), (13, 288970), (15, 20971), (15, 105839), (16, 788272), (17, 76914), (18, 827274), (19, 802258), (20, 123677), (20, 587729), (22, 701449), (25, 31565), (25, 230782), (25, 442887), (25, 733139), (25, 851020);
analyze table t1;
EXPLAIN SELECT a, MAX(b) FROM t1 WHERE a IN (10, 100, 3) GROUP BY a;
DROP TABLE t1;
create table t1 (a DATETIME) partition by range (TO_DAYS(a)) subpartition by hash(to_seconds(a)) (partition p0 values less than (1));
show create table t1;
drop table t1;
create table t1 (a int) partition by range (a) ( partition p0 values less than (NULL), partition p1 values less than (MAXVALUE));
create table t1 (a datetime not null) partition by range (TO_SECONDS(a)) ( partition p0 VALUES LESS THAN (TO_SECONDS('2007-03-08 00:00:00')), partition p1 VALUES LESS THAN (TO_SECONDS('2007-04-01 00:00:00')));
select partition_method, partition_expression, partition_description from information_schema.partitions where table_name = "t1";
INSERT INTO t1 VALUES ('2007-03-01 12:00:00'), ('2007-03-07 12:00:00');
INSERT INTO t1 VALUES ('2007-03-08 12:00:00'), ('2007-03-15 12:00:00');
analyze table t1;
explain select * from t1 where a < '2007-03-08 00:00:00';
explain select * from t1 where a < '2007-03-08 00:00:01';
explain select * from t1 where a <= '2007-03-08 00:00:00';
explain select * from t1 where a <= '2007-03-07 23:59:59';
explain select * from t1 where a < '2007-03-07 23:59:59';
show create table t1;
drop table t1;
create table t1 (a date) partition by range(to_seconds(a)) (partition p0 values less than (to_seconds('2004-01-01')), partition p1 values less than (to_seconds('2005-01-01')));
insert into t1 values ('2003-12-30'),('2004-12-31');
select * from t1;
analyze table t1;
explain select * from t1 where a <= '2003-12-31';
select * from t1 where a <= '2003-12-31';
explain select * from t1 where a <= '2005-01-01';
select * from t1 where a <= '2005-01-01';
show create table t1;
drop table t1;
create table t1 (a datetime) partition by range(to_seconds(a)) (partition p0 values less than (to_seconds('2004-01-01 12:00:00')), partition p1 values less than (to_seconds('2005-01-01 12:00:00')));
insert into t1 values ('2004-01-01 11:59:29'),('2005-01-01 11:59:59');
select * from t1;
analyze table t1;
explain select * from t1 where a <= '2004-01-01 11:59.59';
select * from t1 where a <= '2004-01-01 11:59:59';
explain select * from t1 where a <= '2005-01-01';
select * from t1 where a <= '2005-01-01';
show create table t1;
drop table t1;
create table t1 (a int, b char(20)) partition by range columns(a,b) (partition p0 values less than (1));
create table t1 (a int, b char(20)) partition by range(a) (partition p0 values less than (1,"b"));
create table t1 (a int, b char(20)) partition by range(a) (partition p0 values less than (1,"b"));
create table t1 (a int, b char(20)) partition by range columns(b) (partition p0 values less than ("b"));
drop table t1;
create table t1 (a int) partition by range (a) ( partition p0 values less than (maxvalue));
alter table t1 add partition (partition p1 values less than (100000));
show create table t1;
drop table t1;
create table t1 (a integer) partition by range (a) ( partition p0 values less than (4), partition p1 values less than (100));
create trigger tr1 before insert on t1 for each row begin set @a = 1; end;
alter table t1 drop partition p0;
drop table t1;
create table t1 (a integer) partition by range (a) ( partition p0 values less than (4), partition p1 values less than (100));
LOCK TABLES t1 WRITE;
alter table t1 drop partition p0;
alter table t1 reorganize partition p1 into ( partition p0 values less than (4), partition p1 values less than (100));
alter table t1 add partition ( partition p2 values less than (200));
UNLOCK TABLES;
drop table t1;
create table t1 (a int unsigned) partition by range (a) (partition pnull values less than (0), partition p0 values less than (1), partition p1 values less than(2));
insert into t1 values (null),(0),(1);
select * from t1 where a is null;
select * from t1 where a >= 0;
select * from t1 where a < 0;
select * from t1 where a <= 0;
select * from t1 where a > 1;
analyze table t1;
explain select * from t1 where a is null;
explain select * from t1 where a >= 0;
explain select * from t1 where a < 0;
explain select * from t1 where a <= 0;
explain select * from t1 where a > 1;
drop table t1;
create table t1 (a int unsigned, b int unsigned) partition by range (a) subpartition by hash (b) subpartitions 2 (partition pnull values less than (0), partition p0 values less than (1), partition p1 values less than(2));
insert into t1 values (null,0),(null,1),(0,0),(0,1),(1,0),(1,1);
select * from t1 where a is null;
select * from t1 where a >= 0;
select * from t1 where a < 0;
select * from t1 where a <= 0;
select * from t1 where a > 1;
analyze table t1;
explain select * from t1 where a is null;
explain select * from t1 where a >= 0;
explain select * from t1 where a < 0;
explain select * from t1 where a <= 0;
explain select * from t1 where a > 1;
drop table t1;
CREATE TABLE t1 ( a int not null, b int not null, c int not null, primary key(a,b)) partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than maxvalue);
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
INSERT into t1 values (15, 1, 1);
select * from t1;
show create table t1;
ALTER TABLE t1 partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than maxvalue);
select * from t1;
show create table t1;
drop table if exists t1;
CREATE TABLE t1 ( a int not null, b int not null, c int not null) partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than maxvalue);
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
INSERT into t1 values (15, 1, 1);
select * from t1;
SHOW CREATE TABLE t1;
ALTER TABLE t1 partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than maxvalue);
select * from t1;
SHOW CREATE TABLE t1;
drop table if exists t1;
CREATE TABLE t1 ( a int not null, b int not null, c int not null, primary key(a,b)) partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than (15));
INSERT into t1 values (1, 1, 1);
INSERT into t1 values (6, 1, 1);
INSERT into t1 values (10, 1, 1);
INSERT into t1 values (15, 1, 1);
select * from t1;
SHOW CREATE TABLE t1;
ALTER TABLE t1 partition by range (a) partitions 3 (partition x1 values less than (5), partition x2 values less than (10), partition x3 values less than (15));
select * from t1;
SHOW CREATE TABLE t1;
