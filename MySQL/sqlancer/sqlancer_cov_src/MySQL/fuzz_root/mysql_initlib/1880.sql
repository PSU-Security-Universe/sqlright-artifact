drop table if exists t1;
set names cp932;
set character_set_database = cp932;
RESET MASTER;
CREATE TABLE t1(f1 blob);
PREPARE stmt1 FROM 'INSERT INTO t1 VALUES(?)';
SET @var1= x'8300';
EXECUTE stmt1 USING @var1;
SELECT HEX(f1) FROM t1;
DROP table t1;
