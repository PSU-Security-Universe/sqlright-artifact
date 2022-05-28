drop table if exists t1,t2;
create table t1 (a int not null auto_increment, b int not null, primary key(a));
insert into t1 (b) values (2),(3),(5),(5),(5),(6),(7),(9);
select SQL_CALC_FOUND_ROWS * from t1;
select found_rows();
select SQL_CALC_FOUND_ROWS * from t1 limit 1;
select found_rows();
select SQL_BUFFER_RESULT SQL_CALC_FOUND_ROWS * from t1 limit 1;
select found_rows();
select SQL_CALC_FOUND_ROWS * from t1 order by b desc limit 1;
select found_rows();
select SQL_CALC_FOUND_ROWS distinct b from t1 limit 1;
select found_rows();
select SQL_CALC_FOUND_ROWS b,count(*) as c from t1 group by b order by c desc limit 1;
select found_rows();
select SQL_CALC_FOUND_ROWS * from t1 left join t1 as t2 on (t1.b=t2.a) limit 2,1;
select found_rows();
ANALYZE TABLE t1;
EXPLAIN FORMAT=tree select SQL_CALC_FOUND_ROWS * from t1 limit 10 offset 100;
select SQL_CALC_FOUND_ROWS * from t1 limit 10 offset 100;
select found_rows();
drop table t1;
create table t1 (a int not null primary key);
insert into t1 values (1),(2),(3),(4),(5);
select sql_calc_found_rows a from t1 where a in (1,2,3) order by a desc limit 0,2;
select FOUND_ROWS();
select sql_calc_found_rows a from t1 where a in (1,2,3) order by a+2 desc limit 0,2;
select FOUND_ROWS();
drop table t1;
CREATE TABLE t1 ( `id` smallint(5) unsigned NOT NULL auto_increment, `kid` smallint(5) unsigned NOT NULL default '0', PRIMARY KEY (`id`), KEY `kid` (`kid`) ) charset utf8mb4;
CREATE TABLE t2 ( id smallint(5) unsigned NOT NULL auto_increment, name varchar(50) NOT NULL default '', email varchar(50) NOT NULL default '', PRIMARY KEY  (id), UNIQUE KEY e_n (email,name) ) charset utf8mb4;
INSERT INTO t2 VALUES (1,'name1','email1');
INSERT INTO t2 VALUES (2,'name2','email2');
INSERT INTO t2 VALUES (3,'name3','email3');
INSERT INTO t2 VALUES (4,'name4','email4');
INSERT INTO t2 VALUES (5,'name5','email5');
INSERT INTO t2 VALUES (6,'name6','email6');
INSERT INTO t2 VALUES (7,'name7','email7');
INSERT INTO t2 VALUES (8,'name8','email8');
INSERT INTO t2 VALUES (9,'name9','email9');
INSERT INTO t2 VALUES (10,'name10','email10');
INSERT INTO t2 VALUES (11,'name11','email11');
INSERT INTO t2 VALUES (12,'name12','email12');
INSERT INTO t2 VALUES (13,'name13','email13');
INSERT INTO t2 VALUES (14,'name14','email14');
INSERT INTO t2 VALUES (15,'name15','email15');
INSERT INTO t2 VALUES (16,'name16','email16');
INSERT INTO t2 VALUES (17,'name17','email17');
INSERT INTO t2 VALUES (18,'name18','email18');
INSERT INTO t2 VALUES (19,'name19','email19');
INSERT INTO t2 VALUES (20,'name20','email20');
INSERT INTO t2 VALUES (21,'name21','email21');
INSERT INTO t2 VALUES (22,'name22','email22');
INSERT INTO t2 VALUES (23,'name23','email23');
INSERT INTO t2 VALUES (24,'name24','email24');
INSERT INTO t2 VALUES (25,'name25','email25');
INSERT INTO t2 VALUES (26,'name26','email26');
INSERT INTO t2 VALUES (27,'name27','email27');
INSERT INTO t2 VALUES (28,'name28','email28');
INSERT INTO t2 VALUES (29,'name29','email29');
INSERT INTO t2 VALUES (30,'name30','email30');
INSERT INTO t2 VALUES (31,'name31','email31');
INSERT INTO t2 VALUES (32,'name32','email32');
INSERT INTO t2 VALUES (33,'name33','email33');
INSERT INTO t2 VALUES (34,'name34','email34');
INSERT INTO t2 VALUES (35,'name35','email35');
INSERT INTO t2 VALUES (36,'name36','email36');
INSERT INTO t2 VALUES (37,'name37','email37');
INSERT INTO t2 VALUES (38,'name38','email38');
INSERT INTO t2 VALUES (39,'name39','email39');
INSERT INTO t2 VALUES (40,'name40','email40');
INSERT INTO t2 VALUES (41,'name41','email41');
INSERT INTO t2 VALUES (42,'name42','email42');
INSERT INTO t2 VALUES (43,'name43','email43');
INSERT INTO t2 VALUES (44,'name44','email44');
INSERT INTO t2 VALUES (45,'name45','email45');
INSERT INTO t2 VALUES (46,'name46','email46');
INSERT INTO t2 VALUES (47,'name47','email47');
INSERT INTO t2 VALUES (48,'name48','email48');
INSERT INTO t2 VALUES (49,'name49','email49');
INSERT INTO t2 VALUES (50,'name50','email50');
INSERT INTO t2 VALUES (51,'name51','email51');
INSERT INTO t2 VALUES (52,'name52','email52');
INSERT INTO t2 VALUES (53,'name53','email53');
INSERT INTO t2 VALUES (54,'name54','email54');
INSERT INTO t2 VALUES (55,'name55','email55');
INSERT INTO t2 VALUES (56,'name56','email56');
INSERT INTO t2 VALUES (57,'name57','email57');
INSERT INTO t2 VALUES (58,'name58','email58');
INSERT INTO t2 VALUES (59,'name59','email59');
INSERT INTO t2 VALUES (60,'name60','email60');
INSERT INTO t2 VALUES (61,'name61','email61');
INSERT INTO t2 VALUES (62,'name62','email62');
INSERT INTO t2 VALUES (63,'name63','email63');
INSERT INTO t2 VALUES (64,'name64','email64');
INSERT INTO t2 VALUES (65,'name65','email65');
INSERT INTO t2 VALUES (66,'name66','email66');
INSERT INTO t2 VALUES (67,'name67','email67');
INSERT INTO t2 VALUES (68,'name68','email68');
INSERT INTO t2 VALUES (69,'name69','email69');
INSERT INTO t2 VALUES (70,'name70','email70');
INSERT INTO t2 VALUES (71,'name71','email71');
INSERT INTO t2 VALUES (72,'name72','email72');
INSERT INTO t2 VALUES (73,'name73','email73');
INSERT INTO t2 VALUES (74,'name74','email74');
INSERT INTO t2 VALUES (75,'name75','email75');
INSERT INTO t2 VALUES (76,'name76','email76');
INSERT INTO t2 VALUES (77,'name77','email77');
INSERT INTO t2 VALUES (78,'name78','email78');
INSERT INTO t2 VALUES (79,'name79','email79');
INSERT INTO t2 VALUES (80,'name80','email80');
INSERT INTO t2 VALUES (81,'name81','email81');
INSERT INTO t2 VALUES (82,'name82','email82');
INSERT INTO t2 VALUES (83,'name83','email83');
INSERT INTO t2 VALUES (84,'name84','email84');
INSERT INTO t2 VALUES (85,'name85','email85');
INSERT INTO t2 VALUES (86,'name86','email86');
INSERT INTO t2 VALUES (87,'name87','email87');
INSERT INTO t2 VALUES (88,'name88','email88');
INSERT INTO t2 VALUES (89,'name89','email89');
INSERT INTO t2 VALUES (90,'name90','email90');
INSERT INTO t2 VALUES (91,'name91','email91');