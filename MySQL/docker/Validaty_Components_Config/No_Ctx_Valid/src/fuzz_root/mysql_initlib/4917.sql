create table t1(a int);
insert into t1 values(1),(2);
with qn(a) as (select 1 from t1 limit 2) select * from qn where qn.a=(select * from qn qn1 limit 1) union select 2;
drop table t1;
CREATE OR REPLACE VIEW view_c AS SELECT * FROM c;
EXPLAIN WITH cte AS ( SELECT alias1 . col_time_key AS field1 FROM  cc AS alias1  LEFT OUTER JOIN view_c AS alias2 ON  alias1 . col_varchar_key =  alias2 . col_blob_key WHERE  alias2 . col_varchar_key >= 'n' ORDER BY field1 LIMIT 1000 OFFSET 9) DELETE  FROM outr1.*, outr2.* USING c AS outr1 RIGHT OUTER JOIN c AS outr2 ON ( outr1 . col_blob_key = outr2 . col_blob ) RIGHT JOIN cte AS outrcte ON outr2 . col_blob = outrcte.field1 WHERE outr1 . col_blob_key <> ( SELECT DISTINCT innr1 . col_blob AS y FROM bb AS innr1 LEFT JOIN cte AS innrcte ON innr1.pk <> innrcte.field1 );
DROP VIEW view_c;
DROP TABLE bb,cc,c;
DROP TABLE d,dd;
CREATE OR REPLACE VIEW view_d AS SELECT * FROM d;
CREATE OR REPLACE VIEW view_dd AS SELECT * FROM dd;
EXPLAIN WITH cte AS ( SELECT alias1 . col_date AS field1 , alias1 . col_blob AS field2 , alias1 . pk AS field3 , alias1 . pk AS field4 FROM  dd AS alias1  LEFT  JOIN d AS alias2 ON  alias1 . col_varchar_key =  alias2 . col_varchar_key WHERE  alias2 . pk != 0 OR  alias2 . col_varchar_key >= 'v' ORDER BY field4 ) DELETE /*+ NO_MERGE(outrcte) */  outr2.* FROM d AS outr1 JOIN d AS outr2 ON ( outr1 . col_datetime_key = outr2 . col_date ) JOIN cte AS outrcte ON outr1 . pk = outrcte.field1 WHERE outr1 . col_int_key = ( SELECT  innr1 . col_int AS y FROM dd AS innr1 INNER JOIN cte AS innrcte ON innr1.col_int_key = innrcte.field1 WHERE innr1 . col_blob_key = 'h' ORDER BY innr1 . col_varchar );
DROP TABLE d,dd;
DROP VIEW view_d,view_dd;
create table t1 (i int);
with cte as (select * from t1) (select * from cte);
with cte as (select * from t1) (select * from cte) ORDER BY i;
with cte as (select * from t1) (select * from cte) LIMIT 1;
with cte as (select * from t1) (select * from cte UNION select * from cte);
with cte as (select * from t1) (select * from cte UNION select * from cte) ORDER BY i;
with cte as (select * from t1) (select * from cte UNION select * from cte) LIMIT 1;
drop table t1;
CREATE TABLE b ( col_time_key time, col_int_key int, col_varchar_key varchar (1), col_date date, col_blob blob, col_datetime_key datetime, col_date_key date, col_time time, col_varchar varchar (1), col_blob_key blob, col_datetime datetime, pk integer auto_increment, col_int int, /*Indices*/ key (col_time_key ), key (col_int_key ), key (col_varchar_key ), key (col_datetime_key ), key (col_date_key ), key (col_blob_key  (255)), primary key (pk)) ENGINE=innodb;
CREATE VIEW view_b AS SELECT * FROM b;
CREATE TABLE d ( col_blob blob, col_date_key date, col_varchar_key varchar (1), col_int int, pk integer auto_increment, col_int_key int, col_time time, col_varchar varchar (1), col_date date, col_datetime datetime, col_blob_key blob, col_datetime_key datetime, col_time_key time, /*Indices*/ key (col_date_key ), key (col_varchar_key ), primary key (pk), key (col_int_key ), key (col_blob_key  (255)), key (col_datetime_key ), key (col_time_key )) ENGINE=innodb;
CREATE VIEW view_d AS SELECT * FROM d;
CREATE TABLE cc ( col_date date, col_int_key int, col_date_key date, col_blob blob, col_varchar_key varchar (1), col_blob_key blob, col_datetime_key datetime, pk integer auto_increment, col_datetime datetime, col_varchar varchar (1), col_int int, col_time time, col_time_key time, /*Indices*/ key (col_int_key ), key (col_date_key ), key (col_varchar_key ), key (col_blob_key  (255)), key (col_datetime_key ), primary key (pk), key (col_time_key )) ENGINE=innodb;
ANALYZE TABLE b,cc,d;
DROP TABLE b,cc,d;
DROP VIEW view_d,view_b;
CREATE TABLE a ( col_int int, col_date date, col_time time, col_time_key time, col_date_key date, col_blob blob, col_varchar varchar (1), col_datetime datetime, col_int_key int, pk integer auto_increment, col_blob_key blob, col_datetime_key datetime, col_varchar_key varchar (1), key (col_time_key ), key (col_date_key ), key (col_int_key ), primary key (pk), key (col_blob_key  (255)), key (col_datetime_key ), key (col_varchar_key )) ENGINE=innodb;
CREATE TABLE c ( col_int_key int, col_datetime datetime, col_time_key time, pk integer auto_increment, col_varchar_key varchar (1), col_date_key date, col_blob_key blob, col_int int, col_varchar varchar (1), col_time time, col_datetime_key datetime, col_date date, col_blob blob, key (col_int_key ), key (col_time_key ), primary key (pk), key (col_varchar_key ), key (col_date_key ), key (col_blob_key  (255)), key (col_datetime_key )) ENGINE=innodb;
CREATE TABLE d ( col_time_key time, col_time time, col_blob blob, col_datetime_key datetime, col_varchar varchar (1), col_int_key int, col_int int, col_date_key date, col_date date, col_blob_key blob, col_datetime datetime, pk integer auto_increment, col_varchar_key varchar (1), key (col_time_key ), key (col_datetime_key ), key (col_int_key ), key (col_date_key ), key (col_blob_key  (255)), primary key (pk), key (col_varchar_key )) ENGINE=innodb;
ANALYZE TABLE c,d,a;
DROP TABLE c,d,a;
SET @@SESSION.sql_mode='';
ANALYZE TABLE a,d,bb,cc,dd;
DROP TABLE a,d,bb,cc,dd;
SET @@SESSION.sql_mode=DEFAULT;
CREATE OR REPLACE VIEW view_c AS SELECT * FROM c;
CREATE OR REPLACE VIEW view_bb AS SELECT * FROM bb;
DROP VIEW view_c, view_bb;
DROP TABLE aa,b,bb,c,e;
CREATE TABLE E ( col_varchar_key varchar (1), col_datetime_key datetime, col_varchar varchar (1), col_int_key int, col_time time, col_time_key time, col_date_key date, col_datetime datetime, col_int int, col_blob blob, col_date date, col_blob_key blob, pk integer auto_increment, /*Indices*/ key (col_varchar_key ), key (col_datetime_key ), key (col_int_key ), key (col_time_key ), key (col_date_key ), key (col_blob_key  (255)), primary key (pk)) ENGINE=innodb;
WITH cte AS ( SELECT alias2 . col_time_key AS field1 FROM  E AS alias1  LEFT OUTER JOIN E AS alias2 ON  alias1 . col_varchar_key =  alias2 . col_blob_key WHERE  alias2 . col_varchar_key  LIKE ( 'u' ) ORDER BY field1 DESC LIMIT 1000) UPDATE E AS OUTR1 JOIN E AS OUTR2 ON ( OUTR1 . col_int = OUTR2 . col_int ) LEFT OUTER JOIN cte AS OUTRcte JOIN cte AS OUTRcte1 ON OUTR1 . col_int = OUTRcte.field1 ON OUTR2 . col_varchar = OUTRcte1.field1 SET OUTR1.col_varchar_key = 0 WHERE OUTRcte . field1  IN ( SELECT  INNR1 . col_varchar AS y FROM E AS INNR1 WHERE OUTRcte1 . field1 <> 3 );
DROP TABLE E;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2),(3),(4),(5),(6);
CREATE TABLE t2 (a INT);
INSERT INTO t2 WITH cte AS (SELECT RAND() AS a FROM t1) SELECT SUM(c.a) FROM cte c UNION ALL SELECT SUM(c2.a) FROM cte c2;
SELECT * FROM t2 tmp1, t2 tmp2 WHERE tmp1.a<>tmp2.a;
DELETE FROM t2;
INSERT INTO t2 WITH cte AS (SELECT * FROM t1 WHERE a>3*RAND()) SELECT SUM(c.a) FROM cte c UNION ALL SELECT SUM(c2.a) FROM cte c2;
SELECT * FROM t2 tmp1, t2 tmp2 WHERE tmp1.a<>tmp2.a;
DROP TABLE t1,t2;
create table t1(a int);
insert into t1 values(2),(3);
with t1 as (select * from t1 where a=3) delete from t1;
with t1 as (select * from t1 where a=3) delete t1.* from t1, t1 as t2;
with t1 as (select * from t1 where a=3) update t1 set a=2;
with t1 as (select * from t1 where a=3) update t1, t1 as t2 set t1.a=2;
with t1 as (select 36 as col from t1 where a=3) select * from t1;
insert into t1 with t1 as (select 36 as col from t1) select * from t1;
select * from t1;
create table t1 with t1 as (select 72 as col from t1) select * from t1;
create table t2 with t1 as (select 72 as col from t1) select * from t1;
select * from t1;
select * from t2;
drop table t1,t2;
