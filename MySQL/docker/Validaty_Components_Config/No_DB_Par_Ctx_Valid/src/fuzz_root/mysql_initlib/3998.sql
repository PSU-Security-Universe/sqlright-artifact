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
PREPARE stmt1 FROM ' EXPLAIN SELECT a FROM t1 ORDER BY b ';
EXECUTE stmt1;
SET @arg00=1 ;
PREPARE stmt1 FROM ' EXPLAIN SELECT a FROM t1 WHERE a > ? ORDER BY b ';
EXECUTE stmt1 USING @arg00;
DROP TABLE t1, t9;
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
select '------ explain select tests ------' as test_sequence ;
prepare stmt1 from ' explain select * from t9 ' ;
execute stmt1;
DROP TABLE t1, t9;
drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'InnoDB'  ;
create table t9  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, c16 time, c17 year, c18 tinyint, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext, c25 blob, c26 text, c27 mediumblob, c28 mediumtext, c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday'), primary key(c1) ) engine = 'InnoDB'  ;
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
select '------ explain select tests ------' as test_sequence ;
prepare stmt1 from ' explain select * from t9 ' ;
execute stmt1;
DROP TABLE t1, t9;
CREATE TABLE t1 ( a INT, b VARCHAR(30), PRIMARY KEY(a) ) ENGINE = 'HEAP'  ;
CREATE TABLE t9 ( c1  tinYINT, c2  SMALLINT, c3  MEDIUMINT, c4  INT, c5  INTEGER, c6  BIGINT, c7  FLOAT, c8  DOUBLE, c9  DOUBLE PRECISION, c10 REAL, c11 DECIMAL(7, 4), c12 NUMERIC(8, 4), c13 DATE, c14 DATETIME, c15 TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, c16 TIME, c17 YEAR, c18 TINYINT, c19 BOOL, c20 CHAR, c21 CHAR(10), c22 VARCHAR(30), c23 VARCHAR(100), c24 VARCHAR(100), c25 VARCHAR(100), c26 VARCHAR(100), c27 VARCHAR(100), c28 VARCHAR(100), c29 VARCHAR(100), c30 VARCHAR(100), c31 ENUM('one', 'two', 'three'), c32 SET('monday', 'tuesday', 'wednesday'), PRIMARY KEY(c1) ) ENGINE = 'HEAP'  ;
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
select '------ explain select tests ------' as test_sequence ;
prepare stmt1 from ' explain select * from t9 ' ;
execute stmt1;
DROP TABLE t1, t9;
DROP TABLE IF EXISTS t1, t1_1, t1_2, t9, t9_1, t9_2;
drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'MYISAM'  ;
create table t9  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, c16 time, c17 year, c18 tinyint, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext, c25 blob, c26 text, c27 mediumblob, c28 mediumtext, c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday'), primary key(c1) ) engine = 'MYISAM'  ;
RENAME TABLE t1 TO t1_1, t9 TO t9_1 ;
drop table if exists t1, t9 ;
create table t1 ( a int, b varchar(30), primary key(a) ) engine = 'MYISAM'  ;
create table t9  ( c1  tinyint, c2  smallint, c3  mediumint, c4  int, c5  integer, c6  bigint, c7  float, c8  double, c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4), c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, c16 time, c17 year, c18 tinyint, c19 bool, c20 char, c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext, c25 blob, c26 text, c27 mediumblob, c28 mediumtext, c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'), c32 set('monday', 'tuesday', 'wednesday'), primary key(c1) ) engine = 'MYISAM'  ;
RENAME TABLE t1 TO t1_2, t9 TO t9_2 ;
CREATE TABLE t1 ( a INT, b VARCHAR(30), PRIMARY KEY(a) ) ENGINE = MERGE UNION=(t1_1,t1_2) INSERT_METHOD=FIRST;
CREATE TABLE t9 ( c1  TINYINT, c2  SMALLINT, c3  MEDIUMINT, c4  INT, c5  INTEGER, c6  BIGINT, c7  FLOAT, c8  DOUBLE, c9  DOUBLE PRECISION, c10 REAL, c11 DECIMAL(7, 4), c12 NUMERIC(8, 4), c13 DATE, c14 DATETIME, c15 TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, c16 TIME, c17 YEAR, c18 TINYINT, c19 BOOL, c20 CHAR, c21 CHAR(10), c22 VARCHAR(30), c23 TINYBLOB, c24 TINYTEXT, c25 BLOB, c26 TEXT, c27 MEDIUMBLOB, c28 MEDIUMTEXT, c29 LONGBLOB, c30 LONGTEXT, c31 ENUM('one', 'two', 'three'), c32 SET('monday', 'tuesday', 'wednesday'), PRIMARY KEY(c1) )  ENGINE = MERGE UNION=(t9_1,t9_2) INSERT_METHOD=FIRST;
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
