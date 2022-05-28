drop table if exists t1, t2, tm;
create table t1 (i int) engine = myisam;
create table t2 (i int) engine = myisam;
create table tm (i int) engine=merge union=(t1, t2);
insert into t1 values (1), (2);
insert into t2 values (3), (4);
flush tables tm with read lock;
select * from tm;
select * from t1;
select * from t2;
unlock tables;
flush tables tm, t1, t2 with read lock;
select * from tm;
select * from t1;
select * from t2;
unlock tables;
drop tables tm, t1, t2;