drop table if exists t1, t2;
drop function if exists f1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (ts timestamp);
set time_zone='+00:00';
select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
insert into t1 (ts) values ('2003-03-30 02:30:00');
set time_zone='+10:30';
select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
insert into t1 (ts) values ('2003-03-30 02:30:00');
set time_zone='-10:00';
select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
insert into t1 (ts) values ('2003-03-30 02:30:00');
select * from t1;
drop table t1;
select Name from mysql.time_zone_name where Name in  ('UTC','Universal','MET','Europe/Moscow','leap/Europe/Moscow');
create table t1 (i int, ts timestamp);
set time_zone='MET';
insert into t1 (i, ts) values (unix_timestamp('2003-03-01 00:00:00'),'2003-03-01 00:00:00');
insert into t1 (i, ts) values (unix_timestamp('2003-03-30 01:59:59'),'2003-03-30 01:59:59'), (unix_timestamp('2003-03-30 02:30:00'),'2003-03-30 02:30:00'), (unix_timestamp('2003-03-30 03:00:00'),'2003-03-30 03:00:00');
insert into t1 (i, ts) values (unix_timestamp(20030330015959),20030330015959), (unix_timestamp(20030330023000),20030330023000), (unix_timestamp(20030330030000),20030330030000);
insert into t1 (i, ts) values (unix_timestamp('2003-05-01 00:00:00'),'2003-05-01 00:00:00');
insert into t1 (i, ts) values (unix_timestamp('2003-10-26 01:00:00'),'2003-10-26 01:00:00'), (unix_timestamp('2003-10-26 02:00:00'),'2003-10-26 02:00:00'), (unix_timestamp('2003-10-26 02:59:59'),'2003-10-26 02:59:59'), (unix_timestamp('2003-10-26 04:00:00'),'2003-10-26 04:00:00'), (unix_timestamp('2003-10-26 02:59:59'),'2003-10-26 02:59:59');
set time_zone='UTC';
select * from t1;
truncate table t1;
set time_zone='Europe/Moscow';
insert into t1 (i, ts) values (unix_timestamp('2004-01-01 00:00:00'),'2004-01-01 00:00:00'), (unix_timestamp('2004-03-28 02:30:00'),'2004-03-28 02:30:00'), (unix_timestamp('2004-08-01 00:00:00'),'2003-08-01 00:00:00'), (unix_timestamp('2004-10-31 02:30:00'),'2004-10-31 02:30:00');
select * from t1;
truncate table t1;
set time_zone='leap/Europe/Moscow';
insert into t1 (i, ts) values (unix_timestamp('2004-01-01 00:00:00'),'2004-01-01 00:00:00'), (unix_timestamp('2004-03-28 02:30:00'),'2004-03-28 02:30:00'), (unix_timestamp('2004-08-01 00:00:00'),'2003-08-01 00:00:00'), (unix_timestamp('2004-10-31 02:30:00'),'2004-10-31 02:30:00');
select * from t1;
truncate table t1;
insert into t1 (i, ts) values (unix_timestamp('1981-07-01 03:59:59'),'1981-07-01 03:59:59'), (unix_timestamp('1981-07-01 04:00:00'),'1981-07-01 04:00:00');
select * from t1;
select from_unixtime(362793609);
drop table t1;
create table t1 (ts timestamp);
set time_zone='UTC';
insert into t1 values ('0000-00-00 00:00:00'),('1969-12-31 23:59:59'), ('1970-01-01 00:00:00'),('1970-01-01 00:00:01'), ('2038-01-19 03:14:07'),('2038-01-19 03:14:08');
select * from t1;
truncate table t1;
set time_zone='MET';
insert into t1 values ('0000-00-00 00:00:00'),('1970-01-01 00:30:00'), ('1970-01-01 01:00:00'),('1970-01-01 01:00:01'), ('2038-01-19 04:14:07'),('2038-01-19 04:14:08');
select * from t1;
truncate table t1;
set time_zone='+01:30';
insert into t1 values ('0000-00-00 00:00:00'),('1970-01-01 01:00:00'), ('1970-01-01 01:30:00'),('1970-01-01 01:30:01'), ('2038-01-19 04:44:07'),('2038-01-19 04:44:08');
select * from t1;
drop table t1;
show variables like 'time_zone';
set time_zone = default;
show variables like 'time_zone';
set time_zone= '0';
set time_zone= '0:0';
set time_zone= '-20:00';
set time_zone= '+20:00';
set time_zone= 'Some/Unknown/Time/Zone';
select convert_tz(now(),'UTC', 'Universal') = now();
select convert_tz(now(),'utc', 'UTC') = now();
select convert_tz('1917-11-07 12:00:00', 'MET', 'UTC');
select convert_tz('1970-01-01 01:00:00', 'MET', 'UTC');
select convert_tz('1970-01-01 01:00:01', 'MET', 'UTC');
select convert_tz('2003-03-01 00:00:00', 'MET', 'UTC');
select convert_tz('2003-03-30 01:59:59', 'MET', 'UTC');
select convert_tz('2003-03-30 02:30:00', 'MET', 'UTC');
select convert_tz('2003-03-30 03:00:00', 'MET', 'UTC');
select convert_tz('2003-05-01 00:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 01:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 02:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 02:59:59', 'MET', 'UTC');
select convert_tz('2003-10-26 04:00:00', 'MET', 'UTC');
select convert_tz('2038-01-19 04:14:07', 'MET', 'UTC');
select convert_tz('2038-01-19 04:14:08', 'MET', 'UTC');
select convert_tz('2103-01-01 04:00:00', 'MET', 'UTC');
create table t1 (tz varchar(3));
insert into t1 (tz) values ('MET'), ('UTC');
select tz, convert_tz('2003-12-31 00:00:00',tz,'UTC'), convert_tz('2003-12-31 00:00:00','UTC',tz) from t1 order by tz;
drop table t1;
select convert_tz('2003-12-31 04:00:00', NULL, 'UTC');
select convert_tz('2003-12-31 04:00:00', 'SomeNotExistingTimeZone', 'UTC');
select convert_tz('2003-12-31 04:00:00', 'MET', 'SomeNotExistingTimeZone');
select convert_tz('2003-12-31 04:00:00', 'MET', NULL);
select convert_tz( NULL, 'MET', 'UTC');
create table t1 (ts timestamp);
set timestamp=1000000000;
insert into t1 (ts) values (now());
select convert_tz(ts, @@time_zone, 'Japan') from t1;
drop table t1;
select convert_tz('2005-01-14 17:00:00', 'UTC', custTimeZone) from (select 'UTC' as custTimeZone) as tmp;
create table t1 select convert_tz(NULL, NULL, NULL);
select * from t1;
drop table t1;
SET @old_log_bin_trust_function_creators = @@global.log_bin_trust_function_creators;
SET GLOBAL log_bin_trust_function_creators = 1;
create table t1 (ldt datetime, udt datetime);
create function f1(i datetime) returns datetime return convert_tz(i, 'UTC', 'Europe/Moscow');
create trigger t1_bi before insert on t1 for each row set new.udt:= convert_tz(new.ldt, 'Europe/Moscow', 'UTC');
insert into t1 (ldt) values ('2006-04-19 16:30:00');
select * from t1;
select ldt, f1(udt) as ldt2 from t1;
drop table t1;
drop function f1;
SET @@global.log_bin_trust_function_creators= @old_log_bin_trust_function_creators;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (t TIMESTAMP);
INSERT INTO t1 VALUES (NULL), (NULL);
LOCK TABLES t1 WRITE;
SELECT CONVERT_TZ(NOW(), 'UTC', 'Europe/Moscow') IS NULL;
UPDATE t1 SET t = CONVERT_TZ(t, 'UTC', 'Europe/Moscow');
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1 (a SET('x') NOT NULL);
INSERT INTO t1 VALUES ('');
SELECT CONVERT_TZ(1, a, 1) FROM t1;
SELECT CONVERT_TZ(1, 1, a) FROM t1;
DROP TABLE t1;
SET time_zone='Europe/Moscow';
CREATE TABLE t1 (a TIMESTAMP, b VARCHAR(30));
INSERT INTO t1 VALUES ('2003-03-30 01:59:59', 'Before the gap'), ('2003-03-30 02:30:00', 'Inside the gap'), ('2003-03-30 03:00:00',  'After the gap');
SELECT a, UNIX_TIMESTAMP(a), b FROM t1;
