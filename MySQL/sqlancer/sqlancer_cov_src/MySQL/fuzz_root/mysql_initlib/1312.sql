DROP TABLE IF EXISTS t1;
select 1;
select 2; select 3; select 4;
select 5; select 6; select 50, 'abc';;
select "abcd'";;
select "'abcd";;
select 5;
select 'finish';
flush status;
create table t1 (i int); insert into t1 values (1); select * from t1 where i = 1; insert into t1 values (2),(3),(4); select * from t1 where i = 2; select * from t1 where i = 3;
show status like 'Slow_queries';
drop table t1;