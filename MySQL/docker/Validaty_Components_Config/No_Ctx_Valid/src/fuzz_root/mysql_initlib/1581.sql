drop table if exists t1,t2,t3;
drop database if exists mysqltest;
drop view if exists v1;
create table t1(id1 int not null auto_increment primary key, t char(12));
create table t2(id2 int not null, t char(12));
create table t3(id3 int not null, t char(12), index(id3));
insert into t1(t) values ('100');
insert into t2(id2,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t3(id3,t) values (100,'5');
insert into t2(id2,t) values (7,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (7,'bbbbbbbbbbbbbbbbb');
insert into t1 values (6,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (6,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (6,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (6,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (6,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (6,'bbbbbbbbbbbbbbbbb');
insert into t1 values (5,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (5,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (5,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (5,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (5,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (5,'bbbbbbbbbbbbbbbbb');
insert into t1 values (4,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (4,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (4,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (4,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (4,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (4,'bbbbbbbbbbbbbbbbb');
insert into t1 values (3,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (3,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (3,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (3,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (3,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (3,'bbbbbbbbbbbbbbbbb');
insert into t1 values (2,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (2,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (2,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (2,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (2,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (2,'bbbbbbbbbbbbbbbbb');
insert into t1 values (1,'aaaaaaaaaaaaaaaaaaaa');
insert into t2(id2,t) values (1,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (1,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (1,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (1,'bbbbbbbbbbbbbbbbb');
insert into t2(id2,t) values (1,'bbbbbbbbbbbbbbbbb');
delete t1  from t1,t2 where t1.id1 = t2.id2 and t1.id1 > 500;
drop table t1,t2;
CREATE TABLE t1 ( id int(11) NOT NULL default '0', name varchar(10) default NULL, PRIMARY KEY  (id) );
INSERT INTO t1 VALUES (1,'aaa'),(2,'aaa'),(3,'aaa');
CREATE TABLE t2 ( id int(11) NOT NULL default '0', name varchar(10) default NULL, PRIMARY KEY  (id) );
INSERT INTO t2 VALUES (2,'bbb'),(3,'bbb'),(4,'bbb');
CREATE TABLE t3 ( id int(11) NOT NULL default '0', mydate datetime default NULL, PRIMARY KEY  (id) );
INSERT INTO t3 VALUES (1,'2002-02-04 00:00:00'),(3,'2002-05-12 00:00:00'),(5,'2002-05-12 00:00:00'),(6,'2002-06-22 00:00:00'),(7,'2002-07-22 00:00:00');
delete t1,t2,t3 from t1,t2,t3 where to_days(now())-to_days(t3.mydate)>=30 and t3.id=t1.id and t3.id=t2.id;
select * from t3;
DROP TABLE t1,t2,t3;
CREATE TABLE IF NOT EXISTS `t1` ( `id` int(11) NOT NULL auto_increment, `tst` text, `tst1` text, PRIMARY KEY  (`id`) );
CREATE TABLE IF NOT EXISTS `t2` ( `ID` int(11) NOT NULL auto_increment, `ParId` int(11) default NULL, `tst` text, `tst1` text, PRIMARY KEY  (`ID`), KEY `IX_ParId_t2` (`ParId`), FOREIGN KEY (`ParId`) REFERENCES `t1` (`id`) );
INSERT INTO t1(tst,tst1) VALUES("MySQL","MySQL AB"), ("MSSQL","Microsoft"), ("ORACLE","ORACLE");
INSERT INTO t2(ParId) VALUES(1), (2), (3);
select * from t2;
UPDATE t2, t1 SET t2.tst = t1.tst, t2.tst1 = t1.tst1 WHERE t2.ParId = t1.Id;
select * from t2;
drop table t2, t1 ;
create table t1 (n numeric(10));
create table t2 (n numeric(10));
insert into t2 values (1),(2),(4),(8),(16),(32);
select * from t2 left outer join t1  using (n);
delete  t1,t2 from t2 left outer join t1  using (n);
select * from t2 left outer join t1  using (n);
drop table t1,t2 ;
create table t1 (n int(10) not null primary key, d int(10));
create table t2 (n int(10) not null primary key, d int(10));
insert into t1 values(1,1);
insert into t2 values(1,10),(2,20);
LOCK TABLES t1 write, t2 read;
DELETE t1.*, t2.* FROM t1,t2 where t1.n=t2.n;
UPDATE t1,t2 SET t1.d=t2.d,t2.d=30 WHERE t1.n=t2.n;
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
unlock tables;
LOCK TABLES t1 write, t2 write;
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
select * from t1;
DELETE t1.*, t2.* FROM t1,t2 where t1.n=t2.n;
select * from t1;
select * from t2;
unlock tables;
drop table t1,t2;
set sql_safe_updates=1;
create table t1 (n int(10), d int(10));
create table t2 (n int(10), d int(10));
insert into t1 values(1,1);
insert into t2 values(1,10),(2,20);
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
set sql_safe_updates=0;
drop table t1,t2;
set timestamp=1038401397;
create table t1 (n int(10) not null primary key, d int(10), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
create table t2 (n int(10) not null primary key, d int(10), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1(n,d) values(1,1);
insert into t2(n,d) values(1,10),(2,20);
set timestamp=1038000000;
UPDATE t1,t2 SET t1.d=t2.d WHERE t1.n=t2.n;
select n,d,unix_timestamp(t) from t1;
select n,d,unix_timestamp(t) from t2;
UPDATE t1,t2 SET 1=2 WHERE t1.n=t2.n;
drop table t1,t2;
set timestamp=0;
set sql_safe_updates=0;
