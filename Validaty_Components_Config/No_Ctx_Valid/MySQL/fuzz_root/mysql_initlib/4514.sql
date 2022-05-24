set optimizer_switch='batched_key_access=on,block_nested_loop=off,mrr_cost_based=off';
set optimizer_switch='semijoin=off';
set optimizer_switch='materialization=off';
set optimizer_switch='index_condition_pushdown=off';
set optimizer_switch='mrr=off';
SET GLOBAL innodb_stats_persistent=0;
create table t0 (a int);
insert into t0 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9), (10),(12),(14),(16),(18);
create table t1 ( a int,  b int ) engine=innodb;
insert into t1 values (1,1),(1,1),(2,2);
create table t2 ( a int, b int, key(b) ) engine=innodb;
insert into t2 select a, a/2 from t0;
ANALYZE TABLE t1,t2;
select * from t1;
select * from t2;
explain select * from t2 where b in (select a from t1);
select * from t2 where b in (select a from t1);
truncate table t0;
insert into t0 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t3 ( a int,  b int, key(b), pk1 char(200), pk2 char(200), pk3 char(200), primary key(pk1, pk2, pk3) ) engine=innodb;
insert into t3 select a,a, a,a,a from t0;
explain select * from t3 where b in (select a from t1);
select * from t3 where b in (select a from t1);
set @save_max_heap_table_size= @@max_heap_table_size;
set max_heap_table_size=16384;
set @save_join_buffer_size = @@join_buffer_size;
set join_buffer_size= 8192;
drop table t3;
create table t3 ( a int,  b int, key(b), pk1 char(200), pk2 char(200), primary key(pk1, pk2) ) engine=innodb;
insert into t3 select  A.a + 10*B.a, A.a + 10*B.a, A.a + 10*B.a, A.a + 10*B.a  from t0 A, t0 B where B.a <5;
explain select * from t3 where b in (select a from t0);
select * from t3 where b in (select a.a+b.a from t0 a, t0 b where b.a<5);
set join_buffer_size= @save_join_buffer_size;
set max_heap_table_size= @save_max_heap_table_size;
explain select * from t1 where a in (select b from t2);
select * from t1;
select * from t1 where a in (select b from t2);
drop table t0, t1, t2, t3;
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2 (a char(200), b char(200), c char(200), primary key (a,b,c)) engine=innodb;
insert into t2 select concat(a, repeat('X',198)),repeat('B',200),repeat('B',200) from t1;
insert into t2 select concat(a, repeat('Y',198)),repeat('B',200),repeat('B',200) from t1;
alter table t2 add filler1 int;
insert into t1 select A.a + 10*(B.a + 10*C.a) from t1 A, t1 B, t1 C;
set @save_join_buffer_size=@@join_buffer_size;
set join_buffer_size=1;
select * from t2 where filler1 in ( select a from t1);
set join_buffer_size=default;
drop table t1, t2;
create table t1 (c6 timestamp,key (c6)) engine=innodb;
create table t2 (c2 double) engine=innodb;
explain select 1 from t2 where c2 = any (select log10(null) from t1 where c6 <null)  ;
drop table t1, t2;
create table t3 ( c1 year) charset latin1 engine=innodb;
insert into t3 values (2135),(2142);
create table t2 (c1 tinytext,c2 text,c6 timestamp) charset latin1 engine=innodb;
explain select 1 from t2 where  c2 in (select 1 from t3, t2) and c1 in (select convert(c6,char(1)) from t2);
drop table t2, t3;
CREATE TABLE t1 ( i INT ) ENGINE=InnoDB;
INSERT INTO t1 VALUES (2),(4);
CREATE TABLE t2 ( i INT, vc VARCHAR(1) ) ENGINE=InnoDB;
INSERT INTO t2 VALUES (8,NULL);
SELECT i FROM t1 WHERE i IN (SELECT innr.i FROM t2 LEFT JOIN t2 innr ON innr.vc) AND i = 2;
DROP TABLE t1, t2;
SET GLOBAL innodb_stats_persistent=default;
set optimizer_switch=default;
set optimizer_switch=default;
