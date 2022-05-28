SET SQL_WARNINGS=1;
CREATE TABLE t1 ( ID CHAR(32) NOT NULL, name CHAR(32) NOT NULL, value CHAR(255), INDEX indexIDname (ID(8),name(8)) ) ;
INSERT INTO t1 VALUES ('keyword','indexdir','/export/home/local/www/database/indexes/keyword');
INSERT INTO t1 VALUES ('keyword','urlprefix','text/ /text');
INSERT INTO t1 VALUES ('keyword','urlmap','/text/ /');
INSERT INTO t1 VALUES ('keyword','attr','personal employee company');
INSERT INTO t1 VALUES ('emailgids','indexdir','/export/home/local/www/database/indexes/emailgids');
INSERT INTO t1 VALUES ('emailgids','urlprefix','text/ /text');
INSERT INTO t1 VALUES ('emailgids','urlmap','/text/ /');
INSERT INTO t1 VALUES ('emailgids','attr','personal employee company');
SELECT value FROM t1 WHERE ID='emailgids' AND name='attr';
drop table t1;
CREATE TABLE t1 ( price int(5) DEFAULT '0' NOT NULL, area varchar(40) DEFAULT '' NOT NULL, type varchar(40) DEFAULT '' NOT NULL, transityes enum('Y','N') DEFAULT 'Y' NOT NULL, shopsyes enum('Y','N') DEFAULT 'Y' NOT NULL, schoolsyes enum('Y','N') DEFAULT 'Y' NOT NULL, petsyes enum('Y','N') DEFAULT 'Y' NOT NULL, KEY price (price,area,type,transityes,shopsyes,schoolsyes,petsyes) );
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','N','N','N','N');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','N','N','N','N');
INSERT IGNORE INTO t1 VALUES (900,'Vancouver','Shared/Roomate','','','','');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','Y','Y','Y','Y');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','Y','Y','Y','Y');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','Y','Y','Y','Y');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','Y','Y','Y','Y');
INSERT INTO t1 VALUES (900,'Vancouver','Shared/Roomate','Y','Y','Y','Y');
SELECT * FROM t1 WHERE area='Vancouver' and transityes='y' and schoolsyes='y' and ( ((type='1 Bedroom' or type='Studio/Bach') and (price<=500)) or ((type='2 Bedroom') and (price<=550)) or ((type='Shared/Roomate') and (price<=300)) or ((type='Room and Board') and (price<=500)) ) and price <= 400;
drop table t1;
CREATE TABLE t1 (program enum('signup','unique','sliding') not null,  type enum('basic','sliding','signup'),  sites set('mt'),  PRIMARY KEY (program));
ALTER TABLE t1 modify program enum('signup','unique','sliding');
drop table t1;
CREATE TABLE t1 ( name varchar(50) DEFAULT '' NOT NULL, author varchar(50) DEFAULT '' NOT NULL, category decimal(10,0) DEFAULT '0' NOT NULL, email varchar(50), password varchar(50), proxy varchar(50), bitmap varchar(20), msg varchar(255), urlscol varchar(127), urlhttp varchar(127), timeout decimal(10,0), nbcnx decimal(10,0), creation decimal(10,0), livinguntil decimal(10,0), lang decimal(10,0), type decimal(10,0), subcat decimal(10,0), subtype decimal(10,0), reg char(1), scs varchar(255), capacity decimal(10,0), userISP varchar(50), CCident varchar(50) DEFAULT '' NOT NULL, PRIMARY KEY (name,author,category) );
INSERT INTO t1 VALUES ('patnom','patauteur',0,'p.favre@cryo-networks.fr',NULL,NULL,'#p2sndnq6ae5g1u6t','essai salut','scol://195.242.78.119:patauteur.patnom',NULL,NULL,NULL,950036174,-882087474,NULL,3,0,3,'1','Pub/patnom/futur_divers.scs',NULL,'pat','CC1');
INSERT INTO t1 VALUES ('LeNomDeMonSite','Marc',0,'m.barilley@cryo-networks.fr',NULL,NULL,NULL,NULL,'scol://195.242.78.119:Marc.LeNomDeMonSite',NULL,NULL,NULL,950560434,-881563214,NULL,3,0,3,'1','Pub/LeNomDeMonSite/domus_hibere.scs',NULL,'Marq','CC1');
select * from t1 where name='patnom' and author='patauteur' and category=0;
drop table t1;
create table t1 ( name_id int not null auto_increment, name blob, INDEX name_idx (name(5)), primary key (name_id) );
INSERT t1 VALUES(NULL,'/');
INSERT t1 VALUES(NULL,'[T,U]_axpby');
SELECT * FROM t1 WHERE name='[T,U]_axpy';
SELECT * FROM t1 WHERE name='[T,U]_axpby';
create table t2 ( name_id int not null auto_increment, name char(255) binary, INDEX name_idx (name(5)), primary key (name_id) );
INSERT t2 select * from t1;
SELECT * FROM t2 WHERE name='[T,U]_axpy';
SELECT * FROM t2 WHERE name='[T,U]_axpby';
CREATE TABLE t3 SELECT * FROM t2 WHERE name='[T,U]_axpby';
SELECT * FROM t2 WHERE name='[T,U]_axpby';
drop table t1,t2,t3;
create table t1 ( SEQNO                         numeric(12 ) not null, MOTYPEID                 numeric(12 ) not null, MOINSTANCEID     numeric(12 ) not null, ATTRID                       numeric(12 ) not null, VALUE                         varchar(120) not null, primary key (SEQNO, MOTYPEID, MOINSTANCEID, ATTRID, VALUE ) );
INSERT INTO t1 VALUES (1, 1, 1, 1, 'a');
INSERT INTO t1 VALUES (1, 1, 1, 1, 'b');
INSERT INTO t1 VALUES (1, 1, 1, 1, 'a');
drop table t1;
create table t1 (a int not null unique, b int unique, c int, d int not null primary key, key(c), e int not null unique);
analyze table t1;
show keys from t1;
drop table t1;
create table t1 (i int, a char(200), b text, unique (a), unique (b(300))) charset utf8 row_format=dynamic engine=innodb;
insert ignore t1 values (1, repeat('a',210), repeat('b', 310));
insert ignore t1 values (2, repeat(0xD0B1,215), repeat(0xD0B1, 310));
select i, length(a), length(b), char_length(a), char_length(b) from t1;
select i from t1 where a=repeat(_utf8 'a',200);
select i from t1 where a=repeat(_utf8 0xD0B1,200);
select i from t1 where b=repeat(_utf8 'b',310);
drop table t1;
CREATE TABLE t1 (numeropost mediumint(8) unsigned NOT NULL default '0', numreponse int(10) unsigned NOT NULL auto_increment, PRIMARY KEY (numeropost,numreponse), UNIQUE KEY numreponse (numreponse));
INSERT INTO t1 (numeropost,numreponse) VALUES ('1','1'),('1','2'),('2','3'),('2','4');
SELECT numeropost FROM t1 WHERE numreponse='1';
EXPLAIN SELECT numeropost FROM t1 WHERE numreponse='1';
FLUSH TABLES;
SELECT numeropost FROM t1 WHERE numreponse='1';
drop table t1;
create table t1 (c char(10), index (c(0)));
create table t1 (c char(10), index (c,c));
create table t1 (c1 char(10), c2 char(10), index (c1,c2,c1));
create table t1 (c1 char(10), c2 char(10), index (c1,c1,c2));
create table t1 (c1 char(10), c2 char(10), index (c2,c1,c1));
create table t1 (c1 char(10), c2 char(10));
alter table t1 add key (c1,c1);
alter table t1 add key (c2,c1,c1);
alter table t1 add key (c1,c2,c1);
alter table t1 add key (c1,c1,c2);
drop table t1;
create table t1 ( i1 INT NOT NULL, i2 INT NOT NULL, UNIQUE i1idx (i1), UNIQUE i2idx (i2)) charset utf8mb4;
desc t1;
show create table t1;
drop table t1;
create table t1 (a varchar(10), b varchar(10), key(a(10),b(10))) charset utf8mb4;
show create table t1;
alter table t1 modify b varchar(20);
show create table t1;
alter table t1 modify a varchar(20);
show create table t1;
drop table t1;
create table t1 (a int not null primary key, b varchar(20) not null unique);
desc t1;
drop table t1;
create table t1 (a int not null primary key, b int not null unique);
desc t1;
drop table t1;
create table t1 (a int not null primary key, b varchar(20) not null, unique (b(10)));
desc t1;
drop table t1;
create table t1 (a int not null primary key, b varchar(20) not null, c varchar(20) not null, unique(b(10),c(10)));
desc t1;
drop table t1;
create table t1 ( c1 int, c2 char(12), c3 varchar(123), c4 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, index (c1), index i1 (c1), index i2 (c2), index i3 (c3), unique i4 (c4), index i5 (c1, c2, c3, c4), primary key (c2, c3), index (c2, c4)) charset utf8mb4;
show create table t1;
alter table t1 drop index c1;
alter table t1 add index (c1);
alter table t1 add index (c1);
alter table t1 drop index i3;
alter table t1 add index i3 (c3);
alter table t1 drop index i2, drop index i4;
alter table t1 add index i2 (c2), add index i4 (c4);
alter table t1 drop index i2, drop index i4, add index i6 (c2, c4);
alter table t1 add index i2 (c2), add index i4 (c4), drop index i6;
alter table t1 drop index i2, drop index i4, add unique i4 (c4);
alter table t1 add index i2 (c2), drop index i4, add index i4 (c4);
alter table t1 drop index c2, add index (c2(4),c3(7));
alter table t1 drop index c2, add index (c2(4),c3(7));
alter table t1 add primary key (c1, c2), drop primary key;
alter table t1 drop primary key;
alter table t1 add primary key (c1, c2), drop primary key;
show create table t1;
insert into t1 values(1, 'a', 'a', NOW()), (1, 'b', 'b', NOW());
alter table t1 drop index i3, drop index i2, drop index i1;