SET @old_log_output=@@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
drop table if exists t1,t2,t3,t4;
drop database if exists client_test_db;
create table t1 ( a int primary key, b char(10) );
insert into t1 values (1,'one');
insert into t1 values (2,'two');
insert into t1 values (3,'three');
insert into t1 values (4,'four');
set @a=2;
prepare stmt1 from 'select * from t1 where a <= ?';
execute stmt1 using @a;
set @a=3;
execute stmt1 using @a;
deallocate prepare no_such_statement;
execute stmt1;
prepare stmt2 from 'prepare nested_stmt from "select 1"';
prepare stmt2 from 'execute stmt1';
prepare stmt2 from 'deallocate prepare z';
prepare stmt3 from 'insert into t1 values (?,?)';
set @arg1=5, @arg2='five';
execute stmt3 using @arg1, @arg2;
select * from t1 where a>3;
prepare stmt4 from 'update t1 set a=? where b=?';
set @arg1=55, @arg2='five';
execute stmt4 using @arg1, @arg2;
select * from t1 where a>3;
prepare stmt4 from 'create table t2 (a int)';
execute stmt4;
prepare stmt4 from 'drop table t2';
execute stmt4;
execute stmt4;
prepare stmt5 from 'select ? + a from t1';
set @a=1;
execute stmt5 using @a;
execute stmt5 using @no_such_var;
set @nullvar=1;
set @nullvar=NULL;
execute stmt5 using @nullvar;
set @nullvar2=NULL;
execute stmt5 using @nullvar2;
prepare stmt6 from 'select 1; select2';
prepare stmt6 from 'insert into t1 values (5,"five"); select2';
explain prepare stmt6 from 'insert into t1 values (5,"five"); select2';
create table t2 ( a int );
insert into t2 values (0);
set @arg00=NULL ;
prepare stmt1 from 'select 1 FROM t2 where a=?' ;
execute stmt1 using @arg00 ;
prepare stmt1 from @nosuchvar;
set @ivar= 1234;
prepare stmt1 from @ivar;
set @fvar= 123.4567;
prepare stmt1 from @fvar;
drop table t1,t2;
deallocate prepare stmt3;
deallocate prepare stmt4;
deallocate prepare stmt5;
PREPARE stmt1 FROM "select _utf8 'A' collate utf8_bin = ?";
set @var='A';
EXECUTE stmt1 USING @var;
DEALLOCATE PREPARE stmt1;
create table t1 (id int);
prepare stmt1 from "select FOUND_ROWS()";
select SQL_CALC_FOUND_ROWS * from t1;
execute stmt1;
insert into t1 values (1);
select SQL_CALC_FOUND_ROWS * from t1;
execute stmt1;
execute stmt1;
deallocate prepare stmt1;
drop table t1;
create table t1  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp, c16 time, c17 year, c18 bit, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext, c25 blob, c26 text, c27 mediumblob, c28 mediumtext, c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday') ) engine = MYISAM ;
create table t2 like t1;
set @stmt= ' explain SELECT (SELECT SUM(c1 + c12 + 0.0) FROM t2 where (t1.c2 - 0e-3) = t2.c2 GROUP BY t1.c15 LIMIT 1) as scalar_s, exists (select 1.0e+0 from t2 where t2.c3 * 9.0000000000 = t1.c4) as exists_s, c5 * 4 in (select c6 + 0.3e+1 from t2) as in_s, (c7 - 4, c8 - 4) in (select c9 + 4.0, c10 + 40e-1 from t2) as in_row_s FROM t1, (select c25 x, c32 y from t2) tt WHERE x * 1 = c25 ' ;
prepare stmt1 from @stmt ;
execute stmt1 ;
execute stmt1 ;
explain SELECT (SELECT SUM(c1 + c12 + 0.0) FROM t2 where (t1.c2 - 0e-3) = t2.c2 GROUP BY t1.c15 LIMIT 1) as scalar_s, exists (select 1.0e+0 from t2 where t2.c3 * 9.0000000000 = t1.c4) as exists_s, c5 * 4 in (select c6 + 0.3e+1 from t2) as in_s, (c7 - 4, c8 - 4) in (select c9 + 4.0, c10 + 40e-1 from t2) as in_row_s FROM t1, (select c25 x, c32 y from t2) tt WHERE x * 1 = c25;
deallocate prepare stmt1;
drop tables t1,t2;
set @arg00=1;
prepare stmt1 from ' create table t1 (m int) as select 1 as m ' ;
execute stmt1 ;
select m from t1;
drop table t1;
prepare stmt1 from ' create table t1 (m int) as select ? as m ' ;
execute stmt1 using @arg00;
select m from t1;
deallocate prepare stmt1;
drop table t1;
create table t1 (id int(10) unsigned NOT NULL default '0', name varchar(64) NOT NULL default '', PRIMARY KEY  (id), UNIQUE KEY `name` (`name`));
insert into t1 values (1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7');
prepare stmt1 from 'select name from t1 where id=? or id=?';
set @id1=1,@id2=6;
execute stmt1 using @id1, @id2;
select name from t1 where id=1 or id=6;
deallocate prepare stmt1;
drop table t1;
create table t1 ( a int primary key, b varchar(30)) engine = MYISAM ;
analyze table t1;
prepare stmt1 from ' show table status from test like ''t1%'' ';
execute stmt1;
show table status from test like 't1%' ;
drop table t1;
create table t1(a varchar(2), b varchar(3));
prepare stmt1 from "select a, b from t1 where (not (a='aa' and b < 'zzz'))";
execute stmt1;
execute stmt1;
deallocate prepare stmt1;
drop table t1;
prepare stmt1 from "select 1 into @var";
execute stmt1;
execute stmt1;
prepare stmt1 from "create table t1 select 1 as i";
execute stmt1;
drop table t1;
execute stmt1;
prepare stmt1 from "insert into t1 select i from t1";
execute stmt1;
