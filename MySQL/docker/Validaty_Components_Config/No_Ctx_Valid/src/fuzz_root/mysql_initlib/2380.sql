drop table if exists t1;
select floor(5.5),floor(-5.5);
explain select floor(5.5),floor(-5.5);
select ceiling(5.5),ceiling(-5.5);
explain select ceiling(5.5),ceiling(-5.5);
select truncate(52.64,1),truncate(52.64,2),truncate(52.64,-1),truncate(52.64,-2), truncate(-52.64,1),truncate(-52.64,-1);
explain select truncate(52.64,1),truncate(52.64,2),truncate(52.64,-1),truncate(52.64,-2), truncate(-52.64,1),truncate(-52.64,-1);
select round(5.5),round(-5.5);
explain select round(5.5),round(-5.5);
select round(5.64,1),round(5.64,2),round(5.64,-1),round(5.64,-2);
select abs(-10), sign(-5), sign(5), sign(0);
explain select abs(-10), sign(-5), sign(5), sign(0);
select log(exp(10)),exp(log(sqrt(10))*2),log(-1),log(NULL),log(1,1),log(3,9),log(-1,2),log(NULL,2);
explain select log(exp(10)),exp(log(sqrt(10))*2),log(-1),log(NULL),log(1,1),log(3,9),log(-1,2),log(NULL,2);
select ln(exp(10)),exp(ln(sqrt(10))*2),ln(-1),ln(0),ln(NULL);
explain select ln(exp(10)),exp(ln(sqrt(10))*2),ln(-1),ln(0),ln(NULL);
select log2(8),log2(15),log2(-2),log2(0),log2(NULL);
explain select log2(8),log2(15),log2(-2),log2(0),log2(NULL);
select log10(100),log10(18),log10(-4),log10(0),log10(NULL);
explain select log10(100),log10(18),log10(-4),log10(0),log10(NULL);
select pow(10,log10(10)),power(2,4);
explain select pow(10,log10(10)),power(2,4);
set @@rand_seed1=10000000,@@rand_seed2=1000000;
select rand(999999),rand();
explain select rand(999999),rand();
select pi(),format(sin(pi()/2),6),format(cos(pi()/2),6),format(abs(tan(pi())),6),format(cot(1),6),format(asin(1),6),format(acos(0),6),format(atan(1),6);
explain select pi(),format(sin(pi()/2),6),format(cos(pi()/2),6),format(abs(tan(pi())),6),format(cot(1),6),format(asin(1),6),format(acos(0),6),format(atan(1),6);
select degrees(pi()),radians(360);
select format(atan(-2, 2), 6);
select format(atan(pi(), 0), 6);
select format(atan2(-2, 2), 6);
select format(atan2(pi(), 0), 6);
SELECT ACOS(1.0);
SELECT ASIN(1.0);
SELECT ACOS(0.2*5.0);
SELECT ACOS(0.5*2.0);
SELECT ASIN(0.8+0.2);
SELECT ASIN(1.2-0.2);
select format(4.55, 1), format(4.551, 1);
explain select degrees(pi()),radians(360);
select rand(rand);
create table t1 (col1 int, col2 decimal(60,30));
insert into t1 values(1,1234567890.12345);
select format(col2,7) from t1;
select format(col2,8) from t1;
insert into t1 values(7,1234567890123456.12345);
select format(col2,6) from t1 where col1=7;
drop table t1;
select ceil(0.09);
select ceil(0.000000000000000009);
create table t1 select round(1, 6);
show create table t1;
select * from t1;
drop table t1;
select abs(-2) * -2;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(1),(1),(2);
SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(a) * 1000 AS UNSIGNED)  FROM t1;
SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(a) * 1000 AS UNSIGNED)  FROM t1 WHERE a = 1;
INSERT INTO t1 VALUES (3);
SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(a) * 1000 AS UNSIGNED)  FROM t1;
SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(a) * 1000 AS UNSIGNED)  FROM t1 WHERE a = 1;
PREPARE stmt FROM  "SELECT CAST(RAND(2) * 1000 AS UNSIGNED), CAST(RAND(?) * 1000 AS UNSIGNED)     FROM t1 WHERE a = 1";
set @var=2;
EXECUTE stmt USING @var;
DROP TABLE t1;
SET timestamp=UNIX_TIMESTAMP('2001-01-01 00:00:00');
create table t1 (a varchar(90), ts datetime not null, index (a)) engine=innodb default charset=utf8;
insert into t1 values ('http://www.foo.com/', now());
select a from t1 where a='http://www.foo.com/' order by abs(timediff(ts, 0));
drop table t1;
SET timestamp=DEFAULT;
set sql_mode='traditional';
select ln(-1);
select log10(-1);
select log2(-1);
select log(2,-1);
select log(-2,1);
set sql_mode='';
select round(111,-10);
select round(-5000111000111000155,-1);
select round(15000111000111000155,-1);
select truncate(-5000111000111000155,-1);
select truncate(15000111000111000155,-1);
set names utf8;
create table t1 (f1 varchar(32) not null, f2 smallint(5) unsigned not null, f3 int(10) unsigned not null default '0') default charset=utf8;
insert into t1 values ('zombie',0,0),('gold',1,10000),('silver',2,10000);
create table t2 (f1 int(10) unsigned not null, f2 int(10) unsigned not null, f3 smallint(5) unsigned not null) default charset=utf8;
insert into t2 values (16777216,16787215,1),(33554432,33564431,2);
select format(t2.f2-t2.f1+1,0) from t1,t2 where t1.f2 = t2.f3 order by t1.f1;
drop table t1, t2;
set names default;
select cast(-2 as unsigned), 18446744073709551614, -2;
select abs(cast(-2 as unsigned)), abs(18446744073709551614), abs(-2);
select ceiling(cast(-2 as unsigned)), ceiling(18446744073709551614), ceiling(-2);
select floor(cast(-2 as unsigned)), floor(18446744073709551614), floor(-2);
select format(cast(-2 as unsigned), 2), format(18446744073709551614, 2), format(-2, 2);
select sqrt(cast(-2 as unsigned)), sqrt(18446744073709551614), sqrt(-2);
select round(cast(-2 as unsigned), 1), round(18446744073709551614, 1), round(-2, 1);
select round(4, cast(-2 as unsigned)), round(4, 18446744073709551614), round(4, -2);
select truncate(cast(-2 as unsigned), 1), truncate(18446744073709551614, 1), truncate(-2, 1);
select truncate(4, cast(-2 as unsigned)), truncate(4, 18446744073709551614), truncate(4, -2);
select round(10000000000000000000, -19), truncate(10000000000000000000, -19);
select round(1e0, -309), truncate(1e0, -309);
select round(1e1,308), truncate(1e1, 308);
select round(1e1, 2147483648), truncate(1e1, 2147483648);
select round(1.1e1, 4294967295), truncate(1.1e1, 4294967295);
select round(1.12e1, 4294967296), truncate(1.12e1, 4294967296);
select round(1.5, 2147483640), truncate(1.5, 2147483640);
select round(1.5, -2147483649), round(1.5, 2147483648);
select truncate(1.5, -2147483649), truncate(1.5, 2147483648);
select round(1.5, -4294967296), round(1.5, 4294967296);
select truncate(1.5, -4294967296), truncate(1.5, 4294967296);
select round(1.5, -9223372036854775808), round(1.5, 9223372036854775808);
select truncate(1.5, -9223372036854775808), truncate(1.5, 9223372036854775808);
select round(1.5, 18446744073709551615), truncate(1.5, 18446744073709551615);
select round(18446744073709551614, -1), truncate(18446744073709551614, -1);
select round(4, -4294967200), truncate(4, -4294967200);
select mod(cast(-2 as unsigned), 3), mod(18446744073709551614, 3), mod(-2, 3);
select mod(5, cast(-2 as unsigned)), mod(5, 18446744073709551614), mod(5, -2);
select pow(cast(-2 as unsigned), 5), pow(18446744073709551614, 5), pow(-2, 5);
CREATE TABLE t1 (a timestamp, b varchar(20), c bit(1));
