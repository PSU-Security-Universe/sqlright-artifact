use test;
drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'HEAP'  ;
drop table if exists t9;
create table t9  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, c16 time, c17 year, c18 tinyint, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 varchar(100), c24 varchar(100), c25 varchar(100), c26 varchar(100), c27 varchar(100), c28 varchar(100), c29 varchar(100), c30 varchar(100), c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday'), primary key(c1) ) engine = 'HEAP'  ;
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
select '------ simple select tests ------' as test_sequence ;
prepare stmt1 from ' select * from t9 order by c1 ' ;
execute stmt1;
set @arg00='SELECT' ;
@arg00 a from t1 where a=1;
prepare stmt1 from ' ? a from t1 where a=1 ';
set @arg00=1 ;
select @arg00, b from t1 where a=1 ;
prepare stmt1 from ' select ?, b from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00='lion' ;
select @arg00, b from t1 where a=1 ;
prepare stmt1 from ' select ?, b from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00=NULL ;
select @arg00, b from t1 where a=1 ;
prepare stmt1 from ' select ?, b from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00=1 ;
select b, a - @arg00 from t1 where a=1 ;
prepare stmt1 from ' select b, a - ? from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00=null ;
select @arg00 as my_col ;
prepare stmt1 from ' select ? as my_col';
execute stmt1 using @arg00 ;
select @arg00 + 1 as my_col ;
prepare stmt1 from ' select ? + 1 as my_col';
execute stmt1 using @arg00 ;
select 1 + @arg00 as my_col ;
prepare stmt1 from ' select 1 + ? as my_col';
execute stmt1 using @arg00 ;
set @arg00='MySQL' ;
select substr(@arg00,1,2) from t1 where a=1 ;
prepare stmt1 from ' select substr(?,1,2) from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00=3 ;
select substr('MySQL',@arg00,5) from t1 where a=1 ;
prepare stmt1 from ' select substr(''MySQL'',?,5) from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
select substr('MySQL',1,@arg00) from t1 where a=1 ;
prepare stmt1 from ' select substr(''MySQL'',1,?) from t1 where a=1 ' ;
execute stmt1 using @arg00 ;
set @arg00='MySQL' ;
select a , concat(@arg00,b) from t1 order by a;
prepare stmt1 from ' select a , concat(?,b) from t1 order by a ' ;
execute stmt1 using @arg00;
select a , concat(b,@arg00) from t1 order by a ;
prepare stmt1 from ' select a , concat(b,?) from t1 order by a ' ;
execute stmt1 using @arg00;
set @arg00='MySQL' ;
select group_concat(@arg00,b order by a) from t1  group by 'a' ;
prepare stmt1 from ' select group_concat(?,b order by a) from t1 group by ''a'' ' ;
execute stmt1 using @arg00;
select group_concat(b,@arg00 order by a) from t1  group by 'a' ;
prepare stmt1 from ' select group_concat(b,? order by a) from t1 group by ''a'' ' ;
execute stmt1 using @arg00;
set @arg00='first' ;
set @arg01='second' ;
set @arg02=NULL;
select @arg00, @arg01 from t1 where a=1 ;
prepare stmt1 from ' select ?, ? from t1 where a=1 ' ;
execute stmt1 using @arg00, @arg01 ;
execute stmt1 using @arg02, @arg01 ;
execute stmt1 using @arg00, @arg02 ;
execute stmt1 using @arg02, @arg02 ;
drop table if exists t5 ;
create table t5 (id1 int(11) not null default '0', value2 varchar(100), value1 varchar(100)) ;
insert into t5 values (1,'hh','hh'),(2,'hh','hh'), (1,'ii','ii'),(2,'ii','ii') ;
prepare stmt1 from ' select id1,value1 from t5 where id1=? or value1=? order by id1,value1 ' ;
set @arg00=1 ;
set @arg01='hh' ;
execute stmt1 using @arg00, @arg01 ;
drop table t5 ;
drop table if exists t5 ;
create table t5(session_id  char(9) not null) ;
insert into t5 values ('abc') ;
prepare stmt1 from ' select * from t5 where ?=''1111'' and session_id = ''abc'' ' ;
set @arg00='abc' ;
execute stmt1 using @arg00 ;
set @arg00='1111' ;
execute stmt1 using @arg00 ;
set @arg00='abc' ;
execute stmt1 using @arg00 ;
drop table t5 ;
set @arg00='FROM' ;
prepare stmt1 from ' select a ? t1 where a=1 ' ;
set @arg00='t1' ;
select a from @arg00 where a=1 ;
prepare stmt1 from ' select a from ? where a=1 ' ;
set @arg00='WHERE' ;
prepare stmt1 from ' select a from t1 ? a=1 ' ;
set @arg00=1 ;
select a FROM t1 where a=@arg00 ;
prepare stmt1 from ' select a FROM t1 where a=? ' ;
execute stmt1 using @arg00 ;
set @arg00=1000 ;
execute stmt1 using @arg00 ;
set @arg00=NULL ;
select a FROM t1 where a=@arg00 ;
prepare stmt1 from ' select a FROM t1 where a=? ' ;
execute stmt1 using @arg00 ;
set @arg00=4 ;
select a FROM t1 where a=sqrt(@arg00) ;
prepare stmt1 from ' select a FROM t1 where a=sqrt(?) ' ;
