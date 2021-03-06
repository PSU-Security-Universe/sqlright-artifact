SET SESSION DEFAULT_STORAGE_ENGINE = MEMORY;
drop table if exists t1,t2,t3,t4;
drop database if exists mysqltest;
create table t1 (id int unsigned not null auto_increment, code tinyint unsigned not null, name char(20) not null, primary key (id), key (code), unique (name)) engine=MyISAM;
insert into t1 (code, name) values (1, 'Tim'), (1, 'Monty'), (2, 'David'), (2, 'Erik'), (3, 'Sasha'), (3, 'Jeremy'), (4, 'Matt');
select id, code, name from t1 order by id;
update ignore t1 set id = 8, name = 'Sinisa' where id < 3;
select id, code, name from t1 order by id;
update ignore t1 set id = id + 10, name = 'Ralph' where id < 4;
select id, code, name from t1 order by id;
drop table t1;
CREATE TABLE t1 ( id int(11) NOT NULL auto_increment, parent_id int(11) DEFAULT '0' NOT NULL, level tinyint(4) DEFAULT '0' NOT NULL, PRIMARY KEY (id), KEY parent_id (parent_id), KEY level (level) ) engine=MyISAM;
INSERT INTO t1 VALUES (1,0,0),(3,1,1),(4,1,1),(8,2,2),(9,2,2),(17,3,2),(22,4,2),(24,4,2),(28,5,2),(29,5,2),(30,5,2),(31,6,2),(32,6,2),(33,6,2),(203,7,2),(202,7,2),(20,3,2),(157,0,0),(193,5,2),(40,7,2),(2,1,1),(15,2,2),(6,1,1),(34,6,2),(35,6,2),(16,3,2),(7,1,1),(36,7,2),(18,3,2),(26,5,2),(27,5,2),(183,4,2),(38,7,2),(25,5,2),(37,7,2),(21,4,2),(19,3,2),(5,1,1),(179,5,2);
update t1 set parent_id=parent_id+100;
select * from t1 where parent_id=102;
update t1 set id=id+1000;
update t1 set id=1024 where id=1009;
select * from t1;
update ignore t1 set id=id+1;
select * from t1;
update ignore t1 set id=1023 where id=1010;
select * from t1 where parent_id=102;
explain select level from t1 where level=1;
explain select level,id from t1 where level=1;
explain select level,id,parent_id from t1 where level=1;
select level,id from t1 where level=1;
select level,id,parent_id from t1 where level=1;
optimize table t1;
show keys from t1;
drop table t1;
CREATE TABLE t1 ( gesuchnr int(11) DEFAULT '0' NOT NULL, benutzer_id int(11) DEFAULT '0' NOT NULL, PRIMARY KEY (gesuchnr,benutzer_id) ) engine=MyISAM;
replace into t1 (gesuchnr,benutzer_id) values (2,1);
replace into t1 (gesuchnr,benutzer_id) values (1,1);
replace into t1 (gesuchnr,benutzer_id) values (1,1);
select * from t1;
drop table t1;
create table t1 (a int) engine=MyISAM;
insert into t1 values (1), (2);
optimize table t1;
delete from t1 where a = 1;
select * from t1;
check table t1;
drop table t1;
create table t1 (a int,b varchar(20)) engine=MyISAM;
insert into t1 values (1,""), (2,"testing");
delete from t1 where a = 1;
select * from t1;
create index skr on t1 (a);
insert into t1 values (3,""), (4,"testing");
analyze table t1;
show keys from t1;
drop table t1;
create table t1 (a int,b varchar(20),key(a)) engine=MyISAM;
insert into t1 values (1,""), (2,"testing");
select * from t1 where a = 1;
drop table t1;
CREATE TABLE t1 ( user_id int(10) DEFAULT '0' NOT NULL, name varchar(100), phone varchar(100), ref_email varchar(100) DEFAULT '' NOT NULL, detail varchar(200), PRIMARY KEY (user_id,ref_email) )engine=MyISAM;
INSERT INTO t1 VALUES (10292,'sanjeev','29153373','sansh777@hotmail.com','xxx'),(10292,'shirish','2333604','shirish@yahoo.com','ddsds'),(10292,'sonali','323232','sonali@bolly.com','filmstar');
select * from t1 where user_id=10292;
INSERT INTO t1 VALUES (10291,'sanjeev','29153373','sansh777@hotmail.com','xxx'),(10293,'shirish','2333604','shirish@yahoo.com','ddsds');
select * from t1 where user_id=10292;
select * from t1 where user_id>=10292;
select * from t1 where user_id>10292;
select * from t1 where user_id<10292;
drop table t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a int not null, b int not null,c int not null, key(a),primary key(a,b), unique(c),key(a),unique(b)) ENGINE = MyISAM;
SET sql_mode = default;
show index from t1;
drop table t1;
create table t1 (col1 int not null, col2 char(4) not null, primary key(col1)) ENGINE = MEMORY;
alter table t1 engine=MyISAM;
insert into t1 values ('1','1'),('5','2'),('2','3'),('3','4'),('4','4');
select * from t1;
update t1 set col2='7' where col1='4';
select * from t1;
alter table t1 add co3 int not null;
select * from t1;
update t1 set col2='9' where col1='2';
select * from t1;
drop table t1;
create table t1 (a int not null , b int, primary key (a)) engine = MyISAM;
create table t2 (a int not null , b int, primary key (a)) engine = MEMORY;
insert into t1 VALUES (1,3) , (2,3), (3,3);
select * from t1;
insert into t2 select * from t1;
select * from t2;
delete from t1 where b = 3;
select * from t1;
insert into t1 select * from t2;
select * from t1;
select * from t2;
drop table t1,t2;
CREATE TABLE t1 ( id int(11) NOT NULL auto_increment, ggid varchar(32) binary DEFAULT '' NOT NULL, email varchar(64) DEFAULT '' NOT NULL, passwd varchar(32) binary DEFAULT '' NOT NULL, PRIMARY KEY (id), UNIQUE ggid (ggid) ) ENGINE=MyISAM;
insert into t1 (ggid,passwd) values ('test1','xxx');
insert into t1 (ggid,passwd) values ('test2','yyy');
insert into t1 (ggid,passwd) values ('test2','this will fail');
insert into t1 (ggid,id) values ('this will fail',1);
select * from t1 where ggid='test1';
select * from t1 where passwd='xxx';
select * from t1 where id=2;
replace into t1 (ggid,id) values ('this will work',1);
replace into t1 (ggid,passwd) values ('test2','this will work');
update t1 set id=100,ggid='test2' where id=1;
select * from t1;
select * from t1 where id=1;
select * from t1 where id=999;
drop table t1;
CREATE TABLE t1 ( user_name varchar(12), password text, subscribed char(1), user_id int(11) DEFAULT '0' NOT NULL, quota bigint(20), weight double, access_date date, access_time time, approved datetime, dummy_primary_key int(11) NOT NULL auto_increment, PRIMARY KEY (dummy_primary_key) ) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('user_0','somepassword','N',0,0,0,'2000-09-07','23:06:59','2000-09-07 23:06:59',1);
INSERT INTO t1 VALUES ('user_1','somepassword','Y',1,1,1,'2000-09-07','23:06:59','2000-09-07 23:06:59',2);
INSERT INTO t1 VALUES ('user_2','somepassword','N',2,2,1.4142135623731,'2000-09-07','23:06:59','2000-09-07 23:06:59',3);
INSERT INTO t1 VALUES ('user_3','somepassword','Y',3,3,1.7320508075689,'2000-09-07','23:06:59','2000-09-07 23:06:59',4);
INSERT INTO t1 VALUES ('user_4','somepassword','N',4,4,2,'2000-09-07','23:06:59','2000-09-07 23:06:59',5);
select  user_name, password , subscribed, user_id, quota, weight, access_date, access_time, approved, dummy_primary_key from t1 order by user_name;
drop table t1;
CREATE TABLE t1 ( id int(11) NOT NULL auto_increment, parent_id int(11) DEFAULT '0' NOT NULL, level tinyint(4) DEFAULT '0' NOT NULL, KEY (id), KEY parent_id (parent_id), KEY level (level) ) engine=MyISAM;
INSERT INTO t1 VALUES (1,0,0),(3,1,1),(4,1,1),(8,2,2),(9,2,2),(17,3,2),(22,4,2),(24,4,2),(28,5,2),(29,5,2),(30,5,2),(31,6,2),(32,6,2),(33,6,2),(203,7,2),(202,7,2),(20,3,2),(157,0,0),(193,5,2),(40,7,2),(2,1,1),(15,2,2),(6,1,1),(34,6,2),(35,6,2),(16,3,2),(7,1,1),(36,7,2),(18,3,2),(26,5,2),(27,5,2),(183,4,2),(38,7,2),(25,5,2),(37,7,2),(21,4,2),(19,3,2),(5,1,1);
INSERT INTO t1 values (179,5,2);
update t1 set parent_id=parent_id+100;
select * from t1 where parent_id=102;
update t1 set id=id+1000;
