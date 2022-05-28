drop table if exists t5, t6, t7, t8;
drop database if exists mysqltest ;
drop database if exists client_test_db;
drop database if exists testtets;
drop table if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop view if exists t1Aa,t2Aa,v1Aa,v2Aa;
select '------ basic tests ------' as test_sequence ;
drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'MYISAM'  ;
create table t9  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, c16 time, c17 year, c18 tinyint, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext, c25 blob, c26 text, c27 mediumblob, c28 mediumtext, c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday'), primary key(c1) ) engine = 'MYISAM'  ;
delete from t1 ;
insert into t1 values (1,'one');
insert into t1 values (2,'two');
insert into t1 values (3,'three');
insert into t1 values (4,'four');
commit ;
delete from t9 ;
insert into t9 set c1= 1, c2= 1, c3= 1, c4= 1, c5= 1, c6= 1, c7= 1, c8= 1, c9= 1, c10= 1, c11= 1, c12 = 1, c13= '2004-02-29', c14= '2004-02-29 11:11:11', c15= '2004-02-29 11:11:11', c16= '11:11:11', c17= '2004', c18= 1, c19=true, c20= 'a', c21= '123456789a',  c22= '123456789a123456789b123456789c', c23= 'tinyblob', c24= 'tinytext', c25= 'blob', c26= 'text', c27= 'mediumblob', c28= 'mediumtext', c29= 'longblob', c30= 'longtext', c31='one', c32= 'monday';
insert into t9 set c1= 9, c2= 9, c3= 9, c4= 9, c5= 9, c6= 9, c7= 9, c8= 9, c9= 9, c10= 9, c11= 9, c12 = 9, c13= '2004-02-29', c14= '2004-02-29 11:11:11', c15= '2004-02-29 11:11:11', c16= '11:11:11', c17= '2004', c18= 1, c19=false, c20= 'a', c21= '123456789a',  c22= '123456789a123456789b123456789c', c23= 'tinyblob', c24= 'tinytext', c25= 'blob', c26= 'text', c27= 'mediumblob', c28= 'mediumtext', c29= 'longblob', c30= 'longtext', c31='two', c32= 'tuesday';
commit ;
PREPARE stmt FROM ' select * from t1 where a = ? ' ;
SET @var= 2 ;
EXECUTE stmt USING @var ;
select * from t1 where a = @var ;
DEALLOCATE PREPARE stmt ;
prepare stmt1 from ' select 1 as my_col ' ;
prepare stmt1 from ' select ? as my_col ' ;
prepare_garbage stmt1 from ' select 1 ' ;
prepare stmt1 from_garbage ' select 1 ' ;
prepare stmt1 from ' select_garbage 1 ' ;
prepare from ' select 1 ' ;
prepare stmt1 ' select 1 ' ;
prepare ? from ' select ? as my_col ' ;
set @arg00='select 1 as my_col';
prepare stmt1 from @arg00;
set @arg00='';
prepare stmt1 from @arg00;
set @arg00=NULL;
prepare stmt1 from @arg01;
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
prepare stmt1 from ' select * from t1 where x <= 2 ' ;
prepare stmt1 from ' insert into t1(a,x) values(?,?) ' ;
prepare stmt1 from ' insert into t1(x,a) values(?,?) ' ;
drop table if exists not_exist ;
prepare stmt1 from ' select * from not_exist where a <= 2 ' ;
prepare stmt1 from ' insert into t1 values(? ' ;
prepare stmt1 from ' select a, b from t1                      where a=? and where ' ;
execute never_prepared ;
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
prepare stmt1 from ' select * from not_exist where a <= 2 ' ;
execute stmt1 ;
create table t5 ( a int primary key, b char(30), c int );
insert into t5( a, b, c) values( 1, 'original table', 1);
prepare stmt2 from ' select * from t5 ' ;
execute stmt2 ;
drop table t5 ;
execute stmt2 ;
create table t5 ( a int primary key, b char(30), c int );
insert into t5( a, b, c) values( 9, 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
create table t5 ( a int primary key, c int, b char(30) );
insert into t5( a, b, c) values( 9, 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
create table t5 ( a int primary key, b char(30), c int, d timestamp default '2008-02-23 09:23:45' );
insert into t5( a, b, c) values( 9, 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
create table t5 ( a int primary key, d timestamp default '2008-02-23 09:23:45', b char(30), c int );
insert into t5( a, b, c) values( 9, 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
create table t5 ( a timestamp default '2004-02-29 18:01:59', b char(30), c int );
insert into t5( b, c) values( 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
create table t5 ( f1 int primary key, f2 char(30), f3 int );
insert into t5( f1, f2, f3) values( 9, 'recreated table', 9);
execute stmt2 ;
drop table t5 ;
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
execute stmt1 ;
set @arg00=1 ;
set @arg01='two' ;
prepare stmt1 from ' select * from t1 where a <= ? ' ;
execute stmt1 using @arg00;
execute stmt1 ;
execute stmt1 using @arg00, @arg01;
execute stmt1 using @not_set;
deallocate prepare never_prepared ;
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
prepare stmt1 from ' select * from not_exist where a <= 2 ' ;
deallocate prepare stmt1;
create table t5 ( a int primary key, b char(10) );
prepare stmt2 from ' select a,b from t5 where a <= 2 ' ;
drop table t5 ;
deallocate prepare stmt2;
prepare stmt1 from ' select a from t1 where a <= 2 ' ;
prepare stmt2 from ' select b from t1 where a <= 2 ' ;
execute stmt2 ;
execute stmt1 ;
prepare stmt1 from ' select a from t1 where a <= 2 ' ;
prepare stmt2 from ' select a from t1 where a <= 2 ' ;
execute stmt2 ;
execute stmt1 ;
execute stmt2 ;
select '------ show and misc tests ------' as test_sequence ;
drop table if exists t2;
create table t2  ( a int primary key, b char(10) );
prepare stmt4 from ' show databases like ''mysql'' ';
execute stmt4;
prepare stmt4 from ' show tables from test like ''t2%'' ';
execute stmt4;
prepare stmt4 from ' show columns from t2 where field in (select ?) ';
SET @arg00="a";
execute stmt4 using @arg00;
SET @arg00="b";
