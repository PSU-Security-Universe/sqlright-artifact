drop table if exists t1,t2;
drop database if exists mysqltest;
create temporary table t1(n int not null primary key);
create table t2(n int);
insert into t2 values(3);
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
flush tables;
replace into t1 select n from t2;
