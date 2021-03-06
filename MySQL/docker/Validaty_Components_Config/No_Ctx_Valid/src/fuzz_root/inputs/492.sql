CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
create table t1(a int not null, t char(8), index(a));
describe select * from (select * from t1 group by id) bar;
analyze table t1, t2;
use test;
update (select * from t1) as t1 set a = 5;
delete from (select * from t1);
INSERT INTO `t1` (N, M) VALUES (1, 0),(1, 0),(1, 0),(2, 0),(2, 0),(3, 0);
UPDATE `t1` AS P1 INNER JOIN (SELECT N FROM `t1` GROUP BY N HAVING Count(M) > 1) AS P2 ON P1.N = P2.N SET P1.M = 2;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
