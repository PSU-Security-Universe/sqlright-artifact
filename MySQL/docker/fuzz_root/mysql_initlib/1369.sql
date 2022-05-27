set optimizer_switch='index_condition_pushdown=on,mrr=on,mrr_cost_based=on';
set optimizer_switch='semijoin=off';
set optimizer_switch='materialization=off';
set @save_storage_engine= @@default_storage_engine;
set default_storage_engine=InnoDB;
create table t1(a int) charset utf8mb4;
show create table t1;
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2(a int);
insert into t2 select A.a + 10*(B.a + 10*C.a) from t1 A, t1 B, t1 C;
create table t3 ( a char(8) not null, b char(8) not null, filler char(200), key(a) );
insert into t3 select @a:=concat('c-', 1000+ A.a, '=w'), @a, 'filler' from t2 A;
insert into t3 select concat('c-', 1000+A.a, '=w'), concat('c-', 2000+A.a, '=w'),  'filler-1' from t2 A;
insert into t3 select concat('c-', 1000+A.a, '=w'), concat('c-', 3000+A.a, '=w'),  'filler-2' from t2 A;
select a,filler from t3 where a >= 'c-9011=w';
select a,filler from t3 where a >= 'c-1011=w' and a <= 'c-1015=w';
select a,filler from t3 where (a>='c-1011=w' and a <= 'c-1013=w') or (a>='c-1014=w' and a <= 'c-1015=w');
insert into t3 values ('c-1013=z', 'c-1013=z', 'err');
insert into t3 values ('a-1014=w', 'a-1014=w', 'err');
select a,filler from t3 where (a>='c-1011=w' and a <= 'c-1013=w') or (a>='c-1014=w' and a <= 'c-1015=w');
delete from t3 where b in ('c-1013=z', 'a-1014=w');
select a,filler from t3 where a='c-1011=w' or a='c-1012=w' or a='c-1013=w' or a='c-1014=w' or a='c-1015=w';
insert into t3 values ('c-1013=w', 'del-me', 'inserted');
select a,filler from t3 where a='c-1011=w' or a='c-1012=w' or a='c-1013=w' or a='c-1014=w' or a='c-1015=w';
delete from t3 where b='del-me';
alter table t3 add primary key(b);
select b,filler from t3 where (b>='c-1011=w' and b<= 'c-1018=w') or  b IN ('c-1019=w', 'c-1020=w', 'c-1021=w',  'c-1022=w', 'c-1023=w', 'c-1024=w');
select b,filler from t3 where (b>='c-1011=w' and b<= 'c-1020=w') or  b IN ('c-1021=w', 'c-1022=w', 'c-1023=w');
select b,filler from t3 where (b>='c-1011=w' and b<= 'c-1018=w') or  b IN ('c-1019=w', 'c-1020=w') or  (b>='c-1021=w' and b<= 'c-1023=w');
create table t4 (a varchar(10), b int, c char(10), filler char(200), key idx1 (a, b, c)) charset utf8mb4;
insert into t4 (filler) select concat('NULL-', 15-a) from t2 order by a limit 15;
insert into t4 (a,b,c,filler)  select 'b-1',NULL,'c-1', concat('NULL-', 15-a) from t2 order by a limit 15;
insert into t4 (a,b,c,filler)  select 'b-1',NULL,'c-222', concat('NULL-', 15-a) from t2 order by a limit 15;
insert into t4 (a,b,c,filler)  select 'bb-1',NULL,'cc-2', concat('NULL-', 15-a) from t2 order by a limit 15;
insert into t4 (a,b,c,filler)  select 'zz-1',NULL,'cc-2', 'filler-data' from t2 order by a limit 500;
ANALYZE TABLE t4;
explain  select * from t4 where a IS NULL and b IS NULL and (c IS NULL or c='no-such-row1'                                                       or c='no-such-row2');
select * from t4 where a IS NULL and b IS NULL and (c IS NULL or c='no-such-row1'                                                     or c='no-such-row2');
explain  select * from t4 where (a ='b-1' or a='bb-1') and b IS NULL and (c='c-1' or c='cc-2');
select * from t4 where (a ='b-1' or a='bb-1') and b IS NULL and (c='c-1' or c='cc-2');
select * from t4 ignore index(idx1) where (a ='b-1' or a='bb-1') and b IS NULL and (c='c-1' or c='cc-2');
drop table t1, t2, t3, t4;
create table t1 (a int, b int not null,unique key (a,b),index(b));
insert ignore into t1 values (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(null,7),(9,9),(8,8),(7,7),(null,9),(null,9),(6,6);
create table t2 like t1;
insert into t2 select * from t1;
alter table t1 modify b blob not null, add c int not null, drop key a, add unique key (a,b(20),c), drop key b, add key (b(10));
select * from t1 where a is null;
select * from t1 where (a is null or a > 0 and a < 3) and b > 7 limit 3;
select * from t1 where a is null and b=9 or a is null and b=7 limit 3;
drop table t1, t2;
CREATE TABLE t1 ( ID int(10) unsigned NOT NULL AUTO_INCREMENT, col1 int(10) unsigned DEFAULT NULL, key1 int(10) unsigned NOT NULL DEFAULT '0', key2 int(10) unsigned DEFAULT NULL, text1 text, text2 text, col2 smallint(6) DEFAULT '100', col3 enum('headers','bodyandsubject') NOT NULL DEFAULT 'bodyandsubject', col4 tinyint(3) unsigned NOT NULL DEFAULT '0', PRIMARY KEY (ID), KEY (key1), KEY (key2) ) AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
INSERT INTO t1 VALUES (1,NULL,1130,NULL,'Hello',NULL,100,'bodyandsubject',0), (2,NULL,1130,NULL,'bye',NULL,100,'bodyandsubject',0), (3,NULL,1130,NULL,'red',NULL,100,'bodyandsubject',0), (4,NULL,1130,NULL,'yellow',NULL,100,'bodyandsubject',0), (5,NULL,1130,NULL,'blue',NULL,100,'bodyandsubject',0);
select * FROM t1 WHERE key1=1130 AND col1 IS NULL ORDER BY text1;
drop table t1;
CREATE TABLE t1 ( pk int(11) NOT NULL AUTO_INCREMENT, PRIMARY KEY (pk) );
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 ( pk int(11) NOT NULL AUTO_INCREMENT, int_key int(11) DEFAULT NULL, PRIMARY KEY (pk), KEY int_key (int_key) );
INSERT INTO t2 VALUES (1,1),(2,6),(3,0);
ANALYZE TABLE t1;
ANALYZE TABLE t2;
EXPLAIN SELECT MIN(t1.pk) FROM t1 WHERE EXISTS ( SELECT t2.pk FROM t2 WHERE t2.int_key IS NULL GROUP BY t2.pk );
DROP TABLE t1, t2;
create table t0 (a int);
insert into t0 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t1 (a int, b char(20), filler char(200), key(a,b(10)));
insert into t1 select A.a + 10*(B.a + 10*C.a), 'bbb','filler' from t0 A, t0 B, t0 C;
update t1 set b=repeat(char(65+a), 20) where a < 25;
ANALYZE TABLE t1;
explain select * from t1 where a < 10 and b = repeat(char(65+a), 20);
select * from t1 where a < 10 and b = repeat(char(65+a), 20);
drop table t0,t1;
create table t0 (a int);
insert into t0 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t1 (a int, b int, key(a));
insert into t1 select A.a + 10 *(B.a + 10*C.a), A.a + 10 *(B.a + 10*C.a) from t0 A, t0 B, t0 C;
ANALYZE TABLE t1;
explain select * from t1 where a < 20  order by a;
drop table t0, t1;
set @read_rnd_buffer_size_save= @@read_rnd_buffer_size;
set read_rnd_buffer_size=64;
create table t1(a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2(a char(8), b char(8), c char(8), filler char(100), key k1(a,b,c) ) charset utf8mb4;
insert into t2 select  concat('a-', 1000 + A.a, '-a'), concat('b-', 1000 + B.a, '-b'), concat('c-', 1000 + C.a, '-c'), 'filler' from t1 A, t1 B, t1 C;
EXPLAIN select count(length(a) + length(filler)) from t2 force index (k1) where a>='a-1000-a' and a <'a-1001-a';
select count(length(a) + length(filler)) from t2 force index (k1) where a>='a-1000-a' and a <'a-1001-a';
drop table t2;
create table t2 (a char(100), b char(100), c char(100), d int,  filler char(10), key(d), primary key (a,b,c)) charset latin1;
insert into t2 select A.a, B.a, B.a, A.a, 'filler' from t1 A, t1 B;
ANALYZE TABLE t2;
explain select * from t2 force index (d) where d < 10;
drop table t2;
drop table t1;
set @@read_rnd_buffer_size= @read_rnd_buffer_size_save;
create table t1 (f1 int not null, f2 int not null,f3 int not null, f4 char(1), primary key (f1,f2), key ix(f3));
insert into t1(f1,f2,f3,f4) values (55,55,55,'A');
insert into t1(f1,f2,f3,f4) values (54,54,54,'A');
insert into t1(f1,f2,f3,f4) values (53,53,53,'A');
insert into t1(f1,f2,f3,f4) values (52,52,52,'A');
insert into t1(f1,f2,f3,f4) values (51,51,51,'A');
insert into t1(f1,f2,f3,f4) values (50,50,50,'A');
insert into t1(f1,f2,f3,f4) values (49,49,49,'A');
insert into t1(f1,f2,f3,f4) values (48,48,48,'A');
insert into t1(f1,f2,f3,f4) values (47,47,47,'A');
insert into t1(f1,f2,f3,f4) values (46,46,46,'A');
insert into t1(f1,f2,f3,f4) values (45,45,45,'A');
insert into t1(f1,f2,f3,f4) values (44,44,44,'A');
insert into t1(f1,f2,f3,f4) values (43,43,43,'A');
insert into t1(f1,f2,f3,f4) values (42,42,42,'A');
insert into t1(f1,f2,f3,f4) values (41,41,41,'A');
insert into t1(f1,f2,f3,f4) values (40,40,40,'A');
insert into t1(f1,f2,f3,f4) values (39,39,39,'A');
insert into t1(f1,f2,f3,f4) values (38,38,38,'A');
insert into t1(f1,f2,f3,f4) values (37,37,37,'A');
insert into t1(f1,f2,f3,f4) values (36,36,36,'A');
insert into t1(f1,f2,f3,f4) values (35,35,35,'A');
insert into t1(f1,f2,f3,f4) values (34,34,34,'A');
insert into t1(f1,f2,f3,f4) values (33,33,33,'A');
insert into t1(f1,f2,f3,f4) values (32,32,32,'A');
insert into t1(f1,f2,f3,f4) values (31,31,31,'A');
insert into t1(f1,f2,f3,f4) values (30,30,30,'A');