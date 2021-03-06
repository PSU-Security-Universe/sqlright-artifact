CREATE TABLE t1 (  `id` int(11) NOT NULL default '0', `id2` int(11) NOT NULL default '0', `id3` int(11) NOT NULL default '0', `dummy1` char(30) default NULL, PRIMARY KEY  (`id`,`id2`), KEY `index_id3` (`id3`)) ENGINE=MyISAM;
insert into t1 (id,id2) values (1,1),(1,2),(1,3);
LOCK TABLE t1 WRITE;
select dummy1,count(distinct id) from t1 group by dummy1;
update t1 set id=-1 where id=1;
LOCK TABLE t1 READ;
update t1 set id=1 where id=1;
create table t2 SELECT * from t1;
create temporary table t2 SELECT * from t1;
drop table if exists t2;
unlock tables;
create table t2 SELECT * from t1;
LOCK TABLE t1 WRITE,t2 write;
insert into t2 SELECT * from t1;
update t1 set id=1 where id=-1;
drop table t1,t2;
CREATE TABLE t1 ( index1 smallint(6) default NULL, nr smallint(6) default NULL, KEY index1(index1) ) ENGINE=MyISAM;
CREATE TABLE t2 ( nr smallint(6) default NULL, name varchar(20) default NULL ) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,'item1');
INSERT INTO t2 VALUES (2,'item2');
lock tables t1 write, t2 read;
insert into t1 select 1,nr from t2 where name='item1';
insert into t1 select 2,nr from t2 where name='item2';
unlock tables;
check table t1;
lock tables t1 write;
check table t2;
insert into t1 select index1,nr from t1;
unlock tables;
lock tables t1 write, t1 as t1_alias read;
insert into t1 select index1,nr from t1 as t1_alias;
drop table t1,t2;
unlock tables;
drop table t1,t2;
create table t1 (a int) engine=myisam;
create table t2 (a int) engine=myisam;
lock table t1 write, t2 write;
repair table t1 use_frm;
repair table t1 use_frm;
select * from t1;
select * from t2;
repair table t2 use_frm;
repair table t2 use_frm;
select * from t1;
unlock tables;
drop table t1, t2;
CREATE TABLE t1(a INT) ENGINE = MYISAM;
CREATE TABLE m1(a INT) engine=merge union(t1);
LOCK TABLES m1 WRITE;
ALTER TABLE m1 COMMENT 'test';
FLUSH TABLE m1;
UNLOCK TABLES;
DROP TABLE m1, t1;
