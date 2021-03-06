set optimizer_trace_max_mem_size=10000000,@@session.optimizer_trace="enabled=on";
create table t1(a int, b int);
insert into t1 (a) values(1),(2);
create table t2 select * from t1;
analyze table t1,t2;
set optimizer_switch='derived_merge=on';
explain select * from t1 where (select count(*) from (select * from (select * from t1 t2 where 2=(select 2 from (select t1.a) dt1))dt3)dt4);
select * from t1 where (select count(*) from (select * from (select * from t1 t2 where 2=(select 2 from (select t1.a) dt1))dt3)dt4);
explain select * from t1 where (select count(*) from (select * from (select * from t1 t2 where 2=(select 2 from (select 42) dt1))dt3)dt4);
select * from t1 where (select count(*) from (select * from (select * from t1 t2 where 2=(select 2 from (select 42) dt1))dt3)dt4);
explain select (select dt.a from (select t1.a as a, t2.a as b from t2) dt where dt.b=t1.a) as subq from t1;
select (select dt.a from (select t1.a as a, t2.a as b from t2) dt where dt.b=t1.a) as subq from t1;
explain select (select dt.b from (select t2.a as b from t2 where t1.a=t2.a) dt) as subq from t1;
select (select dt.b from (select t2.a as b from t2 where t1.a=t2.a) dt) as subq from t1;
explain select (select dt.b from (select sum(t2.a) as b from t2 group by t1.a) dt) as subq from t1;
select (select dt.b from (select sum(t2.a) as b from t2 group by t1.a) dt) as subq from t1;
explain select (select dt.b from (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-1) dt) as subq from t1;
select (select dt.b from (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-1) dt) as subq from t1;
explain select (select dt.b from (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-2) dt) as subq from t1;
select (select dt.b from (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-2) dt) as subq from t1;
explain select (select dt.b from (select t2.a as b from t2 order by if(t1.a=1,t2.a,-t2.a) limit 1) dt) as subq from t1;
select (select dt.b from (select t2.a as b from t2 order by if(t1.a=1,t2.a,-t2.a) limit 1) dt) as subq from t1;
explain select (select dt.b from (select t2.a, sum(t1.a*10+t2.a) over (order by if(t1.a=1,t2.a,-t2.a)) as b from t2) dt where dt.a=1) as subq from t1;
select (select dt.b from (select t2.a, sum(t1.a*10+t2.a) over (order by if(t1.a=1,t2.a,-t2.a)) as b from t2) dt where dt.a=1) as subq from t1;
explain select (with dt as (select t1.a as a, t2.a as b from t2) select dt2.a from dt dt1, dt dt2 where dt1.b=t1.a and dt2.b=dt1.b) as subq from t1;
select (with dt as (select t1.a as a, t2.a as b from t2) select dt2.a from dt dt1, dt dt2 where dt1.b=t1.a and dt2.b=dt1.b) as subq from t1;
select (with recursive dt as (select t1.a as a union select a+1 from dt where a<10) select dt1.a from dt dt1 where dt1.a=t1.a ) as subq from t1;
select (with recursive dt as (select t1.a as a union select a+1 from dt where a<10) select concat(count(*), ' - ', avg(dt.a)) from dt ) as subq from t1;
select (with recursive dt as (select t1.a as a union all select a+1 from dt where a<10) select concat(count(*), ' - ', avg(dt.a)) from dt ) as subq from t1;
select (with dt as (select t1.a as a, t2.a as b from t2) select dt2.a from dt dt1, dt dt2 where dt1.b=t1.a and dt2.b=dt1.b) as subq from t1;
explain select (with dt as (select t1.a as a from t2 limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
explain format=tree select (with dt as (select t1.a as a from t2 limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
select (with dt as (select t1.a as a from t2 limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
explain select (with dt as (select t2.a as a from t2 having t1.a=t2.a limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
select (with dt as (select t2.a as a from t2 having t1.a=t2.a limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
select (select * from (select t1.a) cte) from t1;
select (with cte as (select t1.a) select * from cte) from t1;
with cte as (select t1.a) select (select * from cte) from t1;
explain select * from t1 where a not in (select dt.f+1 from (select t2.a as f from t2) dt);
select * from t1 where a not in (select dt.f+1 from (select t2.a as f from t2) dt);
explain select * from t1 where a not in (select dt.f+1 from (select 0*t1.a+t2.a as f from t2) dt);
select * from t1 where a not in (select dt.f+1 from (select 0*t1.a+t2.a as f from t2) dt);
create table t11 (a int);
insert into t11 with recursive cte as (select 1 as a union all select a+1 from cte where a<124) select * from cte;
alter table t11 add index(a);
create table t12 like t11;
analyze table t11,t12;
explain select /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, DUPSWEEDOUT) */ * from t11 where a in (select /*+ QB_NAME(subq1) NO_MERGE(dt) */ * from (select t12.a from t12) dt);
explain select /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, DUPSWEEDOUT) */ * from t11 where a in (select /*+ QB_NAME(subq1) NO_MERGE(dt) */ * from (select t12.a+0*t11.a from t12) dt);
DROP TABLE t11,t12;
explain select dt.a from t1, lateral (select t1.a from t2) dt;
explain select dt.a from t1 right join lateral (select t1.a from t2) dt on 1;
explain select dt.a from lateral (select t1.a from t2) dt left join t1 on 1;
explain SELECT * FROM t1 LEFT JOIN lateral (select t1.a) as dt ON t1.a=dt.a RIGHT JOIN lateral (select dt.a) as dt1 ON dt.a=dt1.a;
explain SELECT * FROM t1 JOIN lateral (select t1.a) as dt ON t1.a=dt.a JOIN lateral (select dt.a) as dt1 ON dt.a=dt1.a;
select t1.a, dt.a from t1, lateral (select t1.a+t2.a as a from t2) dt;
select t1.a, dt.a from t1, lateral (select t2.a as a from t2 having t1.a) dt;
create view v1 as select t1.a as f1, dt.a as f2 from t1, lateral (select t1.a+t2.a as a from t2) dt;
show create view v1;
select * from v1;
drop view v1;
SELECT COUNT(*) FROM t1 GROUP BY t1.a  HAVING t1.a IN (SELECT t3.a FROM t1 AS t3 WHERE t3.b IN (SELECT b FROM t2, lateral (select t1.a) dt));
create view v1 as select a, b from t1;
select vq1.b,dt.b from v1 vq1, lateral (select vq1.b) dt;
select b from v1 vq1, lateral (select count(*) from v1 vq2 having vq1.b = 3) dt;
drop view v1;
SELECT /*+ SET_VAR(optimizer_switch = 'materialization=off,semijoin=off') */ * FROM t1 AS ta, lateral (select 1 WHERE ta.a IN (SELECT b FROM t2 AS tb                WHERE tb.b >= SOME(SELECT SUM(tc.a) as sg FROM t1 as tc                                   GROUP BY tc.b                                   HAVING ta.a=tc.b))) dt;
select (select dt.a from   (select 1 as a, t2.a as b from t2 having t1.a) dt where dt.b=t1.a) as subq from t1;
select (select dt.a from   (select 1 as a, 3 as b from t2 having t1.a) dt where dt.b=t1.a) as subq from t1;
select (select f from (select max(t1.a) as f) as dt) as g from t1;
select (select f from lateral (select max(t1.a) as f) as dt) as g from t1;
select t1.a, f from t1, lateral (select max(t1.a) as f) as dt;
select * from t1, lateral (with qn as (select t1.a) select (select max(a) from qn)) as dt;
select (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) from t1;
explain select a from t1 where a in (select a from (select t1.a) dt);
select a from t1 where a in (select a from (select t1.a) dt);
create table t3 as with recursive cte as (select 1 as a union select a+1 from cte where a<20) select * from cte;
analyze table t3;
explain select min(a),max(a) from t3 where a in (select /*+ no_merge() */ a from (select t3.a from t1) dt);
select min(a),max(a) from t3 where a in (select /*+ no_merge() */ a from (select t3.a from t1) dt);
drop table t3;
explain format=tree select * from t1, lateral (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) dt3;
explain select * from t1, lateral (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) dt3;
select * from t1, lateral (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) dt3;
explain select * from t1 as t0, lateral (select dt3.* from t1, lateral (select * from (select * from (select t0.a from t2) as dt limit 1) dt2) dt3) dt4;
select * from t1 as t0, lateral (select dt3.* from t1, lateral (select * from (select * from (select t0.a from t2) as dt limit 1) dt2) dt3) dt4;
explain select /*+ no_merge() */ * from t1 as t0, lateral (select dt3.* from t1, lateral (select * from (select * from (select t0.a from t2) as dt limit 1) dt2) dt3) dt4;
select /*+ no_merge() */ * from t1 as t0, lateral (select dt3.* from t1, lateral (select * from (select * from (select t0.a from t2) as dt limit 1) dt2) dt3) dt4;
explain select * from t1, lateral (select * from (select 42) t1, (select t1.a) dt2) dt3;
select * from t1, lateral (select * from (select 42) t1, (select t1.a) dt2) dt3;
explain select a from t1 where a in (select /*+ no_semijoin() */ a from (select t1.a) dt);
select a from t1 where a in (select /*+ no_semijoin() */ a from (select t1.a) dt);
select a from t1 where a in (with cte as (select t1.a) select /*+ no_semijoin() */ a from cte);
explain select straight_join * from t1, t2, lateral (select t1.a) as dt;
flush status;
select straight_join * from t1, t2, lateral (select t1.a) as dt;
show status like "handler_write";
explain select straight_join * from t1, lateral (select t1.a) as dt, t2;
flush status;
select straight_join * from t1, lateral (select t1.a) as dt, t2;
show status like "handler_write";
explain select straight_join * from t2, t1, lateral (select t1.a) as dt;
flush status;
select straight_join * from t2, t1, lateral (select t1.a) as dt;
show status like "handler_write";
explain select * from t1, t2, lateral (select t1.a) as dt;
flush status;
select * from t1, t2, lateral (select t1.a) as dt;
show status like "handler_write";
explain select * from t1, lateral (select t1.a) as dt, t2;
flush status;
select * from t1, lateral (select t1.a) as dt, t2;
show status like "handler_write";
explain select * from t2, t1, lateral (select t1.a) as dt;
flush status;
select * from t2, t1, lateral (select t1.a) as dt;
show status like "handler_write";
explain select * from t1, lateral (select t1.a from t2 as t3, t2 as t4) as dt, t2;
select trace from information_schema.optimizer_trace;
create table t3(a int) engine=innodb;
insert into t3 values(3);
analyze table t3;
