drop table if exists t1,t2,t3;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (bandID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY, payoutID SMALLINT UNSIGNED NOT NULL);
insert into t1 (bandID,payoutID) VALUES (1,6),(2,6),(3,4),(4,9),(5,10),(6,1),(7,12),(8,12);
create table t2 (payoutID SMALLINT UNSIGNED NOT NULL PRIMARY KEY);
insert into t2 (payoutID) SELECT DISTINCT payoutID FROM t1;
insert into t2 (payoutID) SELECT payoutID+10 FROM t1;
insert ignore into t2 (payoutID) SELECT payoutID+10 FROM t1;
select * from t2;
drop table t1,t2;
create table t1 (a int not null);
create table t2 (a int not null);
insert into t1 values (1);
insert into t1 values (a+2);
insert into t1 values (a+3);
insert into t1 values (4),(a+5);
insert into t1 select * from t1;
select * from t1;
insert into t1 select * from t1 as t2;
select * from t1;
insert into t2 select * from t1 as t2;
select * from t1;
insert into t1 select t2.a from t1,t2;
select * from t1;
insert into t1 select * from t1,t1;
drop table t1,t2;
create table t1 (a int not null primary key, b char(10));
create table t2 (a int not null, b char(10));
insert into t1 values (1,"t1:1"),(3,"t1:3");
insert into t2 values (2,"t2:2"), (3,"t2:3");
insert into t1 select * from t2;
select * from t1;
replace into t1 select * from t2;
select * from t1;
drop table t1,t2;
INSERT INTO t1 VALUES (39,42,'Access-Granted','46','491721000045',2130706433,17690,NULL,NULL,'Localnet','491721000045','49172200000',754974766,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2003-07-18 00:11:21',NULL,NULL,20030718001121);
INSERT INTO t2 SELECT USID, ServerID, State, SessionID, User, NASAddr, NASPort, NASPortType, ConnectSpeed, CarrierType, CallingStationID, CalledStationID, AssignedAddr, SessionTime, PacketsIn, OctetsIn, PacketsOut, OctetsOut, TerminateCause, UnauthTime, AccessRequestTime, AcctStartTime, AcctLastTime, LastModification from t1 LIMIT 1;
drop table t1,t2;
create table t1 (f1 int);
create table t2 (ff1 int unique, ff2 int default 1);
insert into t1 values (1),(1),(2);
insert into t2(ff1) select f1 from t1 on duplicate key update ff2=ff2+1;
select * from t2;
drop table t1, t2;
create table t1 (a int unique);
create table t2 (a int, b int);
create table t3 (c int, d int);
insert into t1 values (1),(2);
insert into t2 values (1,2);
insert into t3 values (1,6),(3,7);
select * from t1;
insert into t1 select a from t2 on duplicate key update a= t1.a + t2.b;
select * from t1;
insert into t1 select a+1 from t2 on duplicate key update t1.a= t1.a + t2.b+1;
select * from t1;
insert into t1 select t3.c from t3 on duplicate key update a= a + t3.d;
select * from t1;
insert into t1 select t2.a from t2 group by t2.a on duplicate key update a= a + 10;
insert into t1 select t2.a from t2 on duplicate key update a= a + t2.b;
insert into t1 select t2.a from t2 on duplicate key update t2.a= a + t2.b;
insert into t1 select t2.a from t2 group by t2.a on duplicate key update a= t1.a + t2.b;
drop table t1,t2,t3;
create table t1(f1 varchar(5) key);
insert into t1(f1) select if(max(f1) is null, '2000',max(f1)+1) from t1;
insert into t1(f1) select if(max(f1) is null, '2000',max(f1)+1) from t1;
insert into t1(f1) select if(max(f1) is null, '2000',max(f1)+1) from t1;
select * from t1;
drop table t1;
create table t1(x int, y int);
create table t2(x int, z int);
insert into t1(x,y) select x,z from t2 on duplicate key update x=values(x);
insert into t1(x,y) select x,z from t2 on duplicate key update x=values(z);
insert into t1(x,y) select x,z from t2 on duplicate key update x=values(t2.x);
drop table t1,t2;
CREATE TABLE t1 (a int PRIMARY KEY);
INSERT INTO t1 values (1), (2);
flush status;
INSERT INTO t1 SELECT a + 2 FROM t1 LIMIT 1;
show status like 'Handler_read%';
DROP TABLE t1;
CREATE TABLE t1 ( f1 int(10) unsigned NOT NULL auto_increment PRIMARY KEY, f2 varchar(100) NOT NULL default '' );
CREATE TABLE t2 ( f1 varchar(10) NOT NULL default '', f2 char(3) NOT NULL default '', PRIMARY KEY  (`f1`), KEY `k1` (`f2`, `f1`) );
INSERT INTO t1 values(NULL, '');
INSERT INTO `t2` VALUES ('486878','WDT'),('486910','WDT');
SELECT COUNT(*) FROM t1;
SELECT min(t2.f1) FROM t1, t2 where t2.f2 = 'SIR' GROUP BY t1.f1;
INSERT INTO t1 (f2) SELECT min(t2.f1) FROM t1, t2 where t2.f2 = 'SIR' GROUP BY t1.f1;
SELECT COUNT(*) FROM t1;
SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (x int, y int);
CREATE TABLE t2 (z int, y int);
CREATE TABLE t3 (a int, b int);
INSERT INTO t3 (SELECT x, y FROM t1 JOIN t2 USING (y) WHERE z = 1);
DROP TABLE IF EXISTS t1,t2,t3;
CREATE DATABASE bug21774_1;
CREATE DATABASE bug21774_2;
CREATE TABLE bug21774_1.t1(id VARCHAR(10) NOT NULL,label VARCHAR(255));
CREATE TABLE bug21774_2.t1(id VARCHAR(10) NOT NULL,label VARCHAR(255));
CREATE TABLE bug21774_1.t2(id VARCHAR(10) NOT NULL,label VARCHAR(255));
INSERT INTO bug21774_2.t1 SELECT t1.* FROM bug21774_1.t1;
use bug21774_1;
INSERT INTO bug21774_2.t1 SELECT t1.* FROM t1;
DROP DATABASE bug21774_1;
DROP DATABASE bug21774_2;
USE test;
create table t1(f1 int primary key, f2 int);
insert into t1 values (1,1);
insert into t1 values (1,1) on duplicate key update f2=1;
insert into t1 values (1,1) on duplicate key update f2=2;
select * from t1;
drop table t1;
CREATE TABLE t1 (f1 INT, f2 INT );
CREATE TABLE t2  (f1 INT PRIMARY KEY, f2 INT);
INSERT INTO t1 VALUES (1,1),(2,2),(10,10);
INSERT INTO t2 (f1, f2) SELECT f1, f2 FROM t1;
INSERT INTO t2 (f1, f2) SELECT f1, f1 FROM t2 src WHERE f1 < 2 ON DUPLICATE KEY UPDATE f1 = 100 + src.f1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 ( a INT KEY, b INT );
INSERT INTO t1 VALUES ( 0, 1 );
INSERT INTO t1 ( b ) SELECT MAX( b ) FROM t1 WHERE b = 2;
