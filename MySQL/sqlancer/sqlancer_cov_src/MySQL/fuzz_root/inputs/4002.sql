drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'MYISAM'  ;
delete from t1 ;
insert into t1 values (1,'one');
commit ;
PREPARE stmt1 FROM ' EXPLAIN SELECT a FROM t1 ORDER BY b ';
EXECUTE stmt1;
SET @arg00=1 ;
DROP TABLE t1, t9;
prepare stmt1 from ' explain select * from t9 ' ;
execute stmt1;
RENAME TABLE t1 TO t1_1, t9 TO t9_1 ;
CREATE TABLE t1 ( a INT, b VARCHAR(30), PRIMARY KEY(a) ) ENGINE = MERGE UNION=(t1_1,t1_2) INSERT_METHOD=FIRST;
set @arg00='SELECT' ;
@arg00 a from t1 where a=1;
