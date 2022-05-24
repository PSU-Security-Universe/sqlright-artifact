drop table if exists t1,t2,t3,t4,t5,t6;
CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
CREATE TABLE t2 (a int not null, b char (10) not null);
insert into t2 values (3,'c'),(4,'d'),(5,'f'),(6,'e');
analyze table t1;
analyze table t2;
select a,b from t1 union distinct select a,b from t2;
select a,b from t1 union all select a,b from t2;
select a,b from t1 union all select a,b from t2 order by b;
select a,b from t1 union all select a,b from t2 union select 7,'g';
select 0,'#' union select a,b from t1 union all select a,b from t2 union select 7,'gg';
select a,b from t1 union select a,b from t1;
select 't1',b,count(*) from t1 group by b UNION select 't2',b,count(*) from t2 group by b;
(select a,b from t1 limit 2)  union all (select a,b from t2 order by a) limit 4;
(select a,b from t1 limit 2)  union all (select a,b from t2 order by a limit 1);
(select a,b from t1 limit 2)  union all (select a,b from t2 order by a limit 1) order by b desc;
(select a,b from t1 limit 2)  union all (select a,b from t2 order by a limit 1) order by t1.b;
explain (select a,b from t1 limit 2)  union all (select a,b from t2 order by a limit 1) order by b desc;
select count(*) from ( (select                      a,b from t1 limit 2)  union all (select a,b from t2 order by a)) q;
(select sql_calc_found_rows  a,b from t1 limit 2)  union all (select a,b from t2 order by a) limit 2;
select found_rows();
select count(*) from ( select                      a,b from t1  union all select a,b from t2) q;
select sql_calc_found_rows  a,b from t1  union all select a,b from t2 limit 2;
select found_rows();
explain  select * from t1 where a in (select a from t1 union select a from t1 order by (select a)) union select * from t1 order by (select a);
explain select a,b from t1 union all select a,b from t2;
explain select xx from t1 union select 1;
explain select a,b from t1 union select 1;
explain select 1 union select a,b from t1 union select 1;
explain select a,b from t1 union select 1 limit 0;
select a,b from t1 into outfile 'skr' union select a,b from t2;
select a,b from t1 order by a union select a,b from t2;
insert into t3 select a from t1 order by a union select a from t2;
create table t3 select a,b from t1 union select a from t2;
select a,b from t1 union select a from t2;
select * from t1 union select a from t2;
select a from t1 union select * from t2;
select * from t1 union select SQL_BUFFER_RESULT * from t2;
create table t3 select a,b from t1 union all select a,b from t2;
insert into t3 select a,b from t1 union all select a,b from t2;
replace into t3 select a,b as c from t1 union all select a,b from t2;
drop table t1,t2,t3;
select * union select 1;
select 1 as a,(select a union select a);
(select 1) union (select 2) order by 0;
SELECT @a:=1 UNION SELECT @a:=@a+1;
(SELECT 1) UNION (SELECT 2) ORDER BY (SELECT a);
(SELECT 1,3) UNION (SELECT 2,1) ORDER BY (SELECT 2);
create table t1 (a int);
create table t2 (a int);
insert into t1 values (1),(2),(3),(4),(5);
insert into t2 values (11),(12),(13),(14),(15);
(select * from t1 limit 2) union (select * from t2 limit 3) limit 4;
(select * from t1 limit 2) union (select * from t2 limit 3);
(select * from t1 limit 2) union (select * from t2 limit 20,3);
set SQL_SELECT_LIMIT=2;
(select * from t1 limit 1) union (select * from t2 limit 3);
set SQL_SELECT_LIMIT=DEFAULT;
drop table t1,t2;
CREATE TABLE t1 ( cid smallint(5) unsigned NOT NULL default '0', cv varchar(250) NOT NULL default '', PRIMARY KEY  (cid), UNIQUE KEY cv (cv) ) ;
INSERT INTO t1 VALUES (8,'dummy');
CREATE TABLE t2 ( cid bigint(20) unsigned NOT NULL auto_increment, cap varchar(255) NOT NULL default '', PRIMARY KEY  (cid), KEY cap (cap) ) ;
CREATE TABLE t3 ( gid bigint(20) unsigned NOT NULL auto_increment, gn varchar(255) NOT NULL default '', must tinyint(4) default NULL, PRIMARY KEY  (gid), KEY gn (gn) ) ;
INSERT INTO t3 VALUES (1,'V1',NULL);
CREATE TABLE t4 ( uid bigint(20) unsigned NOT NULL default '0', gid bigint(20) unsigned default NULL, rid bigint(20) unsigned default NULL, cid bigint(20) unsigned default NULL, UNIQUE KEY m (uid,gid,rid,cid), KEY uid (uid), KEY rid (rid), KEY cid (cid), KEY container (gid,rid,cid) ) ;
INSERT INTO t4 VALUES (1,1,NULL,NULL);
CREATE TABLE t5 ( rid bigint(20) unsigned NOT NULL auto_increment, rl varchar(255) NOT NULL default '', PRIMARY KEY  (rid), KEY rl (rl) ) ;
CREATE TABLE t6 ( uid bigint(20) unsigned NOT NULL auto_increment, un varchar(250) NOT NULL default '', uc smallint(5) unsigned NOT NULL default '0', PRIMARY KEY  (uid), UNIQUE KEY nc (un,uc), KEY un (un) ) ;
INSERT INTO t6 VALUES (1,'test',8);
SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test";
SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t3.must IS NOT NULL AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test";
(SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t3.must IS NOT NULL AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test") UNION (SELECT t4.uid, t5.rl, t3.gn as g1, t4.cid, t4.gid as gg FROM t3, t6, t1, t4 left join t5 on t5.rid = t4.rid left join t2 on t2.cid = t4.cid WHERE t3.gid=t4.gid AND t6.uid = t4.uid AND t6.uc  = t1.cid AND t1.cv = "dummy" AND t6.un = "test");
drop table t1,t2,t3,t4,t5,t6;
CREATE TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(1,'a'),(2,'b'),(3,'c'),(3,'c');
CREATE TABLE t2 (a int not null, b char (10) not null);
insert into t2 values (3,'c'),(4,'d'),(5,'f'),(6,'e');
create table t3 select a,b from t1 union select a,b from t2;
create table t4 (select a,b from t1) union (select a,b from t2) limit 2;
insert into  t4 select a,b from t1 union select a,b from t2;
insert into  t3 (select a,b from t1) union (select a,b from t2) limit 2;
select * from t3;
select * from t4;
drop table t1,t2,t3,t4;
create table t1 (a int);
insert into t1 values (1),(2),(3);
create table t2 (a int);
insert into t2 values (3),(4),(5);
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1) UNION all (SELECT * FROM t2)) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1) UNION all (SELECT * FROM t2) LIMIT 1;
select found_rows();
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2)) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2) LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2)) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 1) UNION all (SELECT * FROM t2);
select found_rows();
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1) UNION all (SELECT * FROM t2 LIMIT 1)) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1) UNION all (SELECT * FROM t2 LIMIT 1);
select found_rows();
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1 LIMIT 1) UNION SELECT * FROM t2) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 1) UNION SELECT * FROM t2 LIMIT 1;
select found_rows();
SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 1 UNION all SELECT * FROM t2 LIMIT 2;
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1 LIMIT 1) UNION all SELECT * FROM t2) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 1) UNION all SELECT * FROM t2 LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM ( SELECT                     * FROM t1 UNION all SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION all SELECT * FROM t2 LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM ( SELECT                     * FROM t1 UNION SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 2;
select found_rows();
SELECT COUNT(*) FROM ( SELECT                     * FROM t1 UNION SELECT * FROM t2) q;
SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 100;
select found_rows();
SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 100 UNION SELECT * FROM t2;
SELECT COUNT(*) FROM ( (SELECT                     * FROM t1 LIMIT 100) UNION SELECT * FROM t2) q;
(SELECT SQL_CALC_FOUND_ROWS * FROM t1 LIMIT 100) UNION SELECT * FROM t2;
select found_rows();
