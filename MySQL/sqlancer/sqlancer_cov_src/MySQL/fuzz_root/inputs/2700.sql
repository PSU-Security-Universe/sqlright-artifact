drop table if exists t1,t2,t3;
CREATE TABLE t1 (S1 INT);
INSERT INTO t1 VALUES (1);
create table t1 (id int primary key);
insert into t1 values (75);
replace into t1 values (76);
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE t1, t2;
delete from t1 where Contractor_ID='999998';
