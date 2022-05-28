drop table if exists t1,t2,t3;
create table t1 (a int);
select count(a) as b from t1 where a=0 having b > 0;
insert into t1 values (null);
select count(a) as b from t1 where a=0 having b > 0;
select count(a) as b from t1 where a=0 having b >=0;
analyze table t1;
explain select count(a) as b from t1 where a=0 having b >=0;
drop table t1;
CREATE TABLE t1 ( raw_id int(10) NOT NULL default '0', chr_start int(10) NOT NULL default '0', chr_end int(10) NOT NULL default '0', raw_start int(10) NOT NULL default '0', raw_end int(10) NOT NULL default '0', raw_ori int(2) NOT NULL default '0' );
INSERT INTO t1 VALUES (469713,1,164123,1,164123,1),(317330,164124,317193,101,153170,1),(469434,317194,375620,101,58527,1),(591816,375621,484273,1,108653,1),(591807,484274,534671,91,50488,1),(318885,534672,649362,101,114791,1),(318728,649363,775520,102,126259,1),(336829,775521,813997,101,38577,1),(317740,813998,953227,101,139330,1),(1,813998,953227,101,139330,1);
CREATE TABLE t2 ( id int(10) unsigned NOT NULL default '0', contig_id int(10) unsigned NOT NULL default '0', seq_start int(10) NOT NULL default '0', seq_end int(10) NOT NULL default '0', strand tinyint(2) NOT NULL default '0', KEY id (id) );
INSERT INTO t2 VALUES (133195,469713,61327,61384,1),(133196,469713,64113,64387,1),(133197,1,1,1,0),(133197,1,1,1,-2);
SELECT e.id, MIN( IF(sgp.raw_ori=1, (e.seq_start+sgp.chr_start-sgp.raw_start),   (sgp.chr_start+sgp.raw_end-e.seq_end))) as start,  MAX( IF(sgp.raw_ori=1, (e.seq_end+sgp.chr_start-sgp.raw_start),   (sgp.chr_start+sgp.raw_end-e.seq_start))) as end,  AVG(IF (sgp.raw_ori=1,e.strand,(-e.strand))) as chr_strand  FROM  t1 sgp, t2 e   WHERE sgp.raw_id=e.contig_id  GROUP BY e.id  HAVING chr_strand= -1 and end >= 0  AND start <= 999660;
drop table t1,t2;
CREATE TABLE t1 (Fld1 int(11) default NULL,Fld2 int(11) default NULL);
INSERT INTO t1 VALUES (1,10),(1,20),(2,NULL),(2,NULL),(3,50);
select Fld1, max(Fld2) as q from t1 group by Fld1 having q is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having max(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having avg(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having std(Fld2) is not null;
select Fld1, max(Fld2) from t1 group by Fld1 having variance(Fld2) is not null;
drop table t1;
create table t1 (id int not null, qty int not null);
insert into t1 values (1,2),(1,3),(2,4),(2,5);
select id, sum(qty) as sqty from t1 group by id having sqty>2;
select sum(qty) as sqty from t1 group by id having count(id) > 0;
select sum(qty) as sqty from t1 group by id having count(distinct id) > 0;
drop table t1;
CREATE TABLE t1 ( `id` bigint(20) NOT NULL default '0', `description` text );
CREATE TABLE t2 ( `id` bigint(20) NOT NULL default '0', `description` varchar(20) );
INSERT INTO t1  VALUES (1, 'test');
INSERT INTO t2 VALUES (1, 'test');
CREATE TABLE t3 ( `id`       bigint(20) NOT NULL default '0', `order_id` bigint(20) NOT NULL default '0' );
select a.id, a.description, count(b.id) as c  from t1 a left join t3 b on a.id=b.order_id  group by a.id, a.description  having (a.description is not null) and (c=0);
select a.*,  count(b.id) as c  from t2 a left join t3 b on a.id=b.order_id  group by a.id, a.description having (a.description is not null) and (c=0);
INSERT INTO t1  VALUES (2, 'test2');
select a.id, a.description, count(b.id) as c  from t1 a left join t3 b on a.id=b.order_id  group by a.id, a.description  having (a.description is not null) and (c=0);
drop table t1,t2,t3;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (3), (4), (1), (3), (1);
SELECT SUM(a) FROM t1 GROUP BY a HAVING SUM(a)>0;
SELECT SUM(a) FROM t1 GROUP BY a HAVING SUM(a);
DROP TABLE t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2), (1), (3), (2), (1);
SELECT a FROM t1 GROUP BY a HAVING a > 1;
SELECT a FROM t1 GROUP BY a HAVING 1 != 1 AND a > 1;
SELECT 0 AS x, a FROM t1 GROUP BY x,a HAVING x=1 AND a > 1;
analyze table t1;
EXPLAIN SELECT a FROM t1 GROUP BY a HAVING 1 != 1 AND a > 1;
EXPLAIN SELECT 0 AS x, a FROM t1 GROUP BY x,a HAVING x=1 AND a > 1;
DROP table t1;
CREATE TABLE t1 (a int PRIMARY KEY);
CREATE TABLE t2 (b int PRIMARY KEY, a int);
CREATE TABLE t3 (b int, flag int);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1,1), (2,1), (3,1);
INSERT INTO t3(b,flag) VALUES (2, 1);
SELECT t1.a FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
SELECT DISTINCT t1.a, MAX(t3.flag) FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
SELECT DISTINCT t1.a FROM t1 INNER JOIN t2 ON t1.a=t2.a LEFT JOIN t3 ON t2.b=t3.b GROUP BY t1.a, t2.b HAVING MAX(t3.flag)=0;
DROP TABLE t1,t2,t3;
create table t1 (col1 int, col2 varchar(5), col_t1 int);
create table t2 (col1 int, col2 varchar(5), col_t2 int);
create table t3 (col1 int, col2 varchar(5), col_t3 int);
insert into t1 values(10,'hello',10);
insert into t1 values(20,'hello',20);
insert into t1 values(30,'hello',30);
insert into t1 values(10,'bye',10);
insert into t1 values(10,'sam',10);
insert into t1 values(10,'bob',10);
insert into t2 select * from t1;
insert into t3 select * from t1;
select count(*) from t1 group by col1 having col1 = 10;
select count(*) as count_col1 from t1 group by col1 having col1 = 10;
select count(*) as count_col1 from t1 as tmp1 group by col1 having col1 = 10;
select count(*) from t1 group by col2 having col2 = 'hello';
select count(*) from t1 group by col2 having col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by col1 having col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by col1 having count_col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by count_col1 having col1 = 10;
select col1 as count_col1 from t1 as tmp1 group by count_col1 having count_col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having count_col1 = 10;
select col1 as count_col1,col2 from t1 as tmp1 group by col1,col2 having col2 = 'hello';
select col1 as count_col1,col2 as group_col2 from t1 as tmp1 group by col1,col2 having group_col2 = 'hello';
select sum(col1) as co12 from t1 group by col2 having col2 10;
select sum(col1) as co2, count(col2) as cc from t1 group by col1 having col1 =10;
select t2.col2 from t2 group by t2.col1, t2.col2 having t1.col1 <= 10;
select t1.col1 from t1 where t1.col2 in  (select t2.col2 from t2  group by t2.col1, t2.col2 having t2.col1 <= 10);
select t1.col1 from t1 where t1.col2 in  (select t2.col2 from t2 group by t2.col1, t2.col2 having t2.col1 <= (select min(t3.col1) from t3));
select t1.col1 from t1 where t1.col2 in (select t2.col2 from t2  group by t2.col1, t2.col2 having t1.col1 <= 10);
select t1.col1 from t1 where t1.col2 in  (select t2.col2 from t2  group by t2.col1, t2.col2 having col_t1 <= 10);
select sum(col1) from t1 group by col_t1 having (select col_t1 from t2 where col_t1 = col_t2 order by col_t2 limit 1);
select t1.col1 from t1 where t1.col2 in  (select t2.col2 from t2  group by t2.col1, t2.col2 having col_t1 <= 10) having col_t1 <= 20;
set @previous_sql_mode_htnt542nh=@@sql_mode;
set sql_mode=(select replace(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select t1.col1 from t1 where t1.col2 in  (select t2.col2 from t2  group by t2.col1, t2.col2 having col_t1 <= 10) group by col_t1 having col_t1 <= 20;
set @@sql_mode=@previous_sql_mode_htnt542nh;
select col_t1, sum(col1) from t1 group by col_t1 having col_t1 > 10 and exists (select sum(t2.col1) from t2 group by t2.col2 having t2.col2 > 'b');
select sum(col1) from t1 group by col_t1 having col_t1 in (select sum(t2.col1) from t2 group by t2.col2, t2.col1 having t2.col1 = t1.col1);
select sum(col1) from t1 group by col_t1 having col_t1 in (select sum(t2.col1) from t2 group by t2.col2, t2.col1 having t2.col1 = col_t1);
select t1.col1, t2.col1 from t1, t2 where t1.col1 = t2.col1 group by t1.col1, t2.col1 having col1 = 2;
select t1.col1*10+t2.col1 from t1,t2 where t1.col1=t2.col1 group by t1.col1, t2.col1 having col1 = 2;
drop table t1, t2, t3;
create table t1 (s1 int);
insert into t1 values (1),(2),(3);
select count(*) from t1 group by s1 having s1 is null;
select s1*0 as s1 from t1 group by s1 having s1 <> 0;
select s1*0 from t1 group by s1 having s1 = 0;
select s1 from t1 group by 1 having 1 = 0;
select count(s1) from t1 group by s1 having count(1+1)=2;
select count(s1) from t1 group by s1 having s1*0=0;
select * from t1 a, t1 b group by a.s1 having s1 is null;
drop table t1;
set names latin1;
create table t1 (s1 char character set latin1 collate latin1_german1_ci);
insert ignore into t1 values ('ü'),('y');
set @previous_sql_mode_htnt542nh=@@sql_mode;
set sql_mode=(select replace(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select s1,count(s1) from t1 group by s1 collate latin1_swedish_ci having s1 = 'y';