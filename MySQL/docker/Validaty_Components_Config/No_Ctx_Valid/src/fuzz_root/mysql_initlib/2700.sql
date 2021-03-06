drop table if exists t1,t2,t3;
CREATE TABLE t1 (S1 INT);
CREATE TABLE t2 (S1 INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t1 JOIN t2;
SELECT * FROM t1 INNER JOIN t2;
SELECT * from t1 JOIN t2 USING (S1);
SELECT * FROM t1 INNER JOIN t2 USING (S1);
SELECT * from t1 CROSS JOIN t2;
SELECT * from t1 LEFT JOIN t2 USING(S1);
SELECT * from t1 LEFT JOIN t2 ON(t2.S1=2);
SELECT * from t1 RIGHT JOIN t2 USING(S1);
SELECT * from t1 RIGHT JOIN t2 ON(t1.S1=1);
drop table t1,t2;
create table t1 (id int primary key);
create table t2 (id int);
insert into t1 values (75);
insert into t1 values (79);
insert into t1 values (78);
insert into t1 values (77);
replace into t1 values (76);
replace into t1 values (76);
insert into t1 values (104);
insert into t1 values (103);
insert into t1 values (102);
insert into t1 values (101);
insert into t1 values (105);
insert into t1 values (106);
insert into t1 values (107);
insert into t2 values (107),(75),(1000);
select t1.id, t2.id from t1, t2 where t2.id = t1.id;
select t1.id, count(t2.id) from t1,t2 where t2.id = t1.id group by t1.id;
select t1.id, count(t2.id) from t1,t2 where t2.id = t1.id group by t2.id;
select t1.id,t2.id from t2 left join t1 on t1.id>=74 and t1.id<=0 where t2.id=75 and t1.id is null;
explain select t1.id,t2.id from t2 left join t1 on t1.id>=74 and t1.id<=0 where t2.id=75 and t1.id is null;
explain select t1.id, t2.id from t1, t2 where t2.id = t1.id and t1.id <0 and t1.id > 0;
drop table t1,t2;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 ( id int(11) NOT NULL auto_increment, token varchar(100) DEFAULT '' NOT NULL, count int(11) DEFAULT '0' NOT NULL, qty int(11), phone char(1) DEFAULT '' NOT NULL, timestamp datetime DEFAULT '0000-00-00 00:00:00' NOT NULL, PRIMARY KEY (id), KEY token (token(15)), KEY timestamp (timestamp), UNIQUE token_2 (token(75),count,phone) );
SET sql_mode = default;
INSERT INTO t1 VALUES (21,'e45703b64de71482360de8fec94c3ade',3,7800,'n','1999-12-23 17:22:21');
INSERT INTO t1 VALUES (22,'e45703b64de71482360de8fec94c3ade',4,5000,'y','1999-12-23 17:22:21');
INSERT INTO t1 VALUES (18,'346d1cb63c89285b2351f0ca4de40eda',3,13200,'b','1999-12-23 11:58:04');
INSERT INTO t1 VALUES (17,'ca6ddeb689e1b48a04146b1b5b6f936a',4,15000,'b','1999-12-23 11:36:53');
INSERT INTO t1 VALUES (16,'ca6ddeb689e1b48a04146b1b5b6f936a',3,13200,'b','1999-12-23 11:36:53');
INSERT INTO t1 VALUES (26,'a71250b7ed780f6ef3185bfffe027983',5,1500,'b','1999-12-27 09:44:24');
INSERT INTO t1 VALUES (24,'4d75906f3c37ecff478a1eb56637aa09',3,5400,'y','1999-12-23 17:29:12');
INSERT INTO t1 VALUES (25,'4d75906f3c37ecff478a1eb56637aa09',4,6500,'y','1999-12-23 17:29:12');
INSERT INTO t1 VALUES (27,'a71250b7ed780f6ef3185bfffe027983',3,6200,'b','1999-12-27 09:44:24');
INSERT INTO t1 VALUES (28,'a71250b7ed780f6ef3185bfffe027983',3,5400,'y','1999-12-27 09:44:36');
INSERT INTO t1 VALUES (29,'a71250b7ed780f6ef3185bfffe027983',4,17700,'b','1999-12-27 09:45:05');
CREATE TABLE t2 ( id int(11) NOT NULL auto_increment, category int(11) DEFAULT '0' NOT NULL, county int(11) DEFAULT '0' NOT NULL, state int(11) DEFAULT '0' NOT NULL, phones int(11) DEFAULT '0' NOT NULL, nophones int(11) DEFAULT '0' NOT NULL, PRIMARY KEY (id), KEY category (category,county,state) );
INSERT INTO t2 VALUES (3,2,11,12,5400,7800);
INSERT INTO t2 VALUES (4,2,25,12,6500,11200);
INSERT INTO t2 VALUES (5,1,37,6,10000,12000);
select a.id, b.category as catid, b.state as stateid, b.county as countyid from t1 a, t2 b ignore index (primary) where (a.token ='a71250b7ed780f6ef3185bfffe027983') and (a.count = b.id);
select a.id, b.category as catid, b.state as stateid, b.county as countyid from t1 a, t2 b where (a.token = 'a71250b7ed780f6ef3185bfffe027983') and (a.count = b.id) order by a.id;
drop table t1, t2;
create table t1 (a int primary key);
insert into t1 values(1),(2);
drop table t1;
CREATE TABLE t1 ( a int(11) NOT NULL, b int(11) NOT NULL, PRIMARY KEY  (a,b) ) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(2,3);
CREATE TABLE t2 ( a int(11) default NULL ) ENGINE=MyISAM;
INSERT INTO t2 VALUES (2),(3);
SELECT t1.a,t2.a,b FROM t1,t2 WHERE t1.a=t2.a AND (t1.a=1 OR t1.a=2) AND b>=1 AND b<=3;
DROP TABLE t1, t2;
CREATE TABLE t1 (d DATE NOT NULL);
CREATE TABLE t2 (d DATE NOT NULL);
INSERT INTO t1 (d) VALUES ('2001-08-01'),('1000-01-01');
SELECT * FROM t1 LEFT JOIN t2 USING (d) WHERE t2.d IS NULL;
SELECT * FROM t1 LEFT JOIN t2 USING (d) WHERE d IS NULL;
SELECT * from t1 WHERE t1.d IS NULL;
SELECT * FROM t1 WHERE 1/0 IS NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 ( Document_ID varchar(50) NOT NULL default '', Contractor_ID varchar(6) NOT NULL default '', Language_ID char(3) NOT NULL default '', Expiration_Date datetime default NULL, Publishing_Date datetime default NULL, Title text, Column_ID varchar(50) NOT NULL default '', PRIMARY KEY  (Language_ID,Document_ID,Contractor_ID) );
INSERT INTO t1 VALUES ('xep80','1','ger','2001-12-31 20:00:00','2001-11-12 10:58:00','Kartenbestellung - jetzt auch online','anle'),('','999998','',NULL,NULL,NULL,'');
CREATE TABLE t2 ( Contractor_ID char(6) NOT NULL default '', Language_ID char(3) NOT NULL default '', Document_ID char(50) NOT NULL default '', CanRead char(1) default NULL, Customer_ID int(11) NOT NULL default '0', PRIMARY KEY  (Contractor_ID,Language_ID,Document_ID,Customer_ID) );
INSERT INTO t2 VALUES ('5','ger','xep80','1',999999),('1','ger','xep80','1',999999);
CREATE TABLE t3 ( Language_ID char(3) NOT NULL default '', Column_ID char(50) NOT NULL default '', Contractor_ID char(6) NOT NULL default '', CanRead char(1) default NULL, Active char(1) default NULL, PRIMARY KEY  (Language_ID,Column_ID,Contractor_ID) );
delete from t1 where Contractor_ID='999998';
insert into t1 (Contractor_ID) Values ('999998');
SELECT DISTINCT COUNT(t1.Title) FROM t1, t2, t3 WHERE  t1.Document_ID='xep80' AND t1.Contractor_ID='1' AND  t1.Language_ID='ger' AND '2001-12-21 23:14:24' >=  Publishing_Date AND '2001-12-21 23:14:24' <= Expiration_Date AND  t1.Document_ID = t2.Document_ID AND  t1.Language_ID = t2.Language_ID AND  t1.Contractor_ID = t2.Contractor_ID AND (  t2.Customer_ID = '4'  OR  t2.Customer_ID = '999999'  OR  t2.Customer_ID = '1' )AND t2.CanRead  = '1'  AND t1.Column_ID=t3.Column_ID AND  t1.Language_ID=t3.Language_ID AND (  t3.Contractor_ID = '4'  OR  t3.Contractor_ID = '999999'  OR  t3.Contractor_ID = '1') AND  t3.CanRead='1' AND t3.Active='1';
SELECT DISTINCT COUNT(t1.Title) FROM t1, t2, t3 WHERE  t1.Document_ID='xep80' AND t1.Contractor_ID='1' AND  t1.Language_ID='ger' AND '2001-12-21 23:14:24' >=  Publishing_Date AND '2001-12-21 23:14:24' <= Expiration_Date AND  t1.Document_ID = t2.Document_ID AND  t1.Language_ID = t2.Language_ID AND  t1.Contractor_ID = t2.Contractor_ID AND (  t2.Customer_ID = '4'  OR  t2.Customer_ID = '999999'  OR  t2.Customer_ID = '1' )AND t2.CanRead  = '1'  AND t1.Column_ID=t3.Column_ID AND  t1.Language_ID=t3.Language_ID AND (  t3.Contractor_ID = '4'  OR  t3.Contractor_ID = '999999'  OR  t3.Contractor_ID = '1') AND  t3.CanRead='1' AND t3.Active='1';
drop table t1,t2,t3;
CREATE TABLE t1 ( t1_id int(11) default NULL, t2_id int(11) default NULL, type enum('Cost','Percent') default NULL, cost_unit enum('Cost','Unit') default NULL, min_value double default NULL, max_value double default NULL, t3_id int(11) default NULL, item_id int(11) default NULL ) ENGINE=MyISAM;
INSERT INTO t1 VALUES (12,5,'Percent','Cost',-1,0,-1,-1),(14,4,'Percent','Cost',-1,0,-1,-1),(18,5,'Percent','Cost',-1,0,-1,-1),(19,4,'Percent','Cost',-1,0,-1,-1),(20,5,'Percent','Cost',100,-1,22,291),(21,5,'Percent','Cost',100,-1,18,291),(22,1,'Percent','Cost',100,-1,6,291),(23,1,'Percent','Cost',100,-1,21,291),(24,1,'Percent','Cost',100,-1,9,291),(25,1,'Percent','Cost',100,-1,4,291),(26,1,'Percent','Cost',100,-1,20,291),(27,4,'Percent','Cost',100,-1,7,202),(28,1,'Percent','Cost',50,-1,-1,137),(29,2,'Percent','Cost',100,-1,4,354),(30,2,'Percent','Cost',100,-1,9,137),(93,2,'Cost','Cost',-1,10000000,-1,-1);
CREATE TABLE t2 ( id int(10) unsigned NOT NULL auto_increment, name varchar(255) default NULL, PRIMARY KEY  (id) ) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,'s1'),(2,'s2'),(3,'s3'),(4,'s4'),(5,'s5');
select t1.*, t2.*  from t1, t2 where t2.id=t1.t2_id limit 2;
drop table t1,t2;
CREATE TABLE t1 ( siteid varchar(25) NOT NULL default '', emp_id varchar(30) NOT NULL default '', rate_code varchar(10) default NULL, UNIQUE KEY site_emp (siteid,emp_id), KEY siteid (siteid) ) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('rivercats','psmith','cust'), ('rivercats','KWalker','cust');
CREATE TABLE t2 ( siteid varchar(25) NOT NULL default '', rate_code varchar(10) NOT NULL default '', base_rate float NOT NULL default '0', PRIMARY KEY  (siteid,rate_code), FULLTEXT KEY rate_code (rate_code) ) ENGINE=MyISAM;
INSERT INTO t2 VALUES ('rivercats','cust',20);
SELECT emp.rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE emp.emp_id = 'psmith' AND lr.siteid = 'rivercats';
SELECT emp.rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE lr.siteid = 'rivercats' AND emp.emp_id = 'psmith';
SELECT rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE emp.emp_id = 'psmith' AND siteid = 'rivercats';
SELECT rate_code, lr.base_rate FROM t1 AS emp LEFT JOIN t2 AS lr USING (siteid, rate_code) WHERE siteid = 'rivercats' AND emp.emp_id = 'psmith';
drop table t1,t2;
CREATE TABLE t1 (ID INTEGER NOT NULL PRIMARY KEY, Value1 VARCHAR(255));
CREATE TABLE t2 (ID INTEGER NOT NULL PRIMARY KEY, Value2 VARCHAR(255));
INSERT INTO t1 VALUES (1, 'A');
INSERT INTO t2 VALUES (1, 'B');
SELECT * FROM t1 NATURAL JOIN t2 WHERE 1 AND (Value1 = 'A' AND Value2 <> 'B');
SELECT * FROM t1 NATURAL JOIN t2 WHERE 1 AND Value1 = 'A' AND Value2 <> 'B';
SELECT * FROM t1 NATURAL JOIN t2 WHERE (Value1 = 'A' AND Value2 <> 'B') AND 1;
drop table t1,t2;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
CREATE TABLE t3 (c int);
SELECT * FROM t1 NATURAL JOIN t2 NATURAL JOIN t3;
DROP TABLE t1, t2, t3;
create table t1 (i int);
create table t2 (i int);
create table t3 (i int);
insert into t1 values(1),(2);
insert into t2 values(2),(3);
insert into t3 values (2),(4);
select * from t1 natural left join t2;
select * from t1 left join t2 on (t1.i=t2.i);
