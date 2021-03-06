drop table if exists t1,t2;
set names utf8mb4;
select left(_utf8mb4 0xD0B0D0B1D0B2,1);
select right(_utf8mb4 0xD0B0D0B2D0B2,1);
select locate('he','hello');
select locate('he','hello',2);
select locate('lo','hello',2);
select locate('HE','hello');
select locate('HE','hello',2);
select locate('LO','hello',2);
select locate('HE','hello' collate utf8mb4_bin);
select locate('HE','hello' collate utf8mb4_bin,2);
select locate('LO','hello' collate utf8mb4_bin,2);
select locate(_utf8mb4 0xD0B1, _utf8mb4 0xD0B0D0B1D0B2);
select locate(_utf8mb4 0xD091, _utf8mb4 0xD0B0D0B1D0B2);
select locate(_utf8mb4 0xD0B1, _utf8mb4 0xD0B0D091D0B2);
select locate(_utf8mb4 0xD091, _utf8mb4 0xD0B0D0B1D0B2 collate utf8mb4_bin);
select locate(_utf8mb4 0xD0B1, _utf8mb4 0xD0B0D091D0B2 collate utf8mb4_bin);
select length(_utf8mb4 0xD0B1), bit_length(_utf8mb4 0xD0B1), char_length(_utf8mb4 0xD0B1);
select 'a' like 'a';
select 'A' like 'a';
select 'A' like 'a' collate utf8mb4_bin;
select _utf8mb4 0xD0B0D0B1D0B2 like concat(_utf8mb4'%',_utf8mb4 0xD0B1,_utf8mb4 '%');
select convert(_latin1'G�nter Andr�' using utf8mb4) like CONVERT(_latin1'G�NTER%' USING utf8mb4);
select CONVERT(_koi8r'����' USING utf8mb4) LIKE CONVERT(_koi8r'����' USING utf8mb4);
select CONVERT(_koi8r'����' USING utf8mb4) LIKE CONVERT(_koi8r'����' USING utf8mb4);
SELECT 'a' = 'a ';
SELECT 'a\0' < 'a';
SELECT 'a\0' < 'a ';
SELECT 'a\t' < 'a';
SELECT 'a\t' < 'a ';
SELECT 'a' = 'a ' collate utf8mb4_bin;
SELECT 'a\0' < 'a' collate utf8mb4_bin;
SELECT 'a\0' < 'a ' collate utf8mb4_bin;
SELECT 'a\t' < 'a' collate utf8mb4_bin;
SELECT 'a\t' < 'a ' collate utf8mb4_bin;
CREATE TABLE t1 (a char(10) character set utf8mb4 not null) ENGINE InnoDB;
INSERT INTO t1 VALUES ('a'),('a\0'),('a\t'),('a ');
SELECT hex(a),STRCMP(a,'a'), STRCMP(a,'a ') FROM t1;
DROP TABLE t1;
select insert('txs',2,1,'hi'),insert('is ',4,0,'a'),insert('txxxxt',2,4,'es');
select char_length(left(@a:='тест',5)), length(@a), @a;
create table t1 ENGINE InnoDB select date_format("2004-01-19 10:10:10", "%Y-%m-%d");
show create table t1;
select * from t1;
drop table t1;
set names utf8mb4;
set LC_TIME_NAMES='fr_FR';
create table t1 (s1 char(20) character set latin1) engine InnoDB;
insert into t1 values (date_format('2004-02-02','%M'));
select hex(s1) from t1;
drop table t1;
create table t1 (s1 char(20) character set koi8r) engine InnoDB;
set LC_TIME_NAMES='ru_RU';
insert into t1 values (date_format('2004-02-02','%M'));
insert into t1 values (date_format('2004-02-02','%b'));
insert into t1 values (date_format('2004-02-02','%W'));
insert into t1 values (date_format('2004-02-02','%a'));
select hex(s1), s1 from t1;
drop table t1;
set LC_TIME_NAMES='en_US';
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
set names koi8r;
create table t1 (s1 char(1) character set utf8mb4) engine InnoDB;
insert into t1 values (_koi8r'��');
select s1,hex(s1),char_length(s1),octet_length(s1) from t1;
drop table t1;
create table t1 (s1 tinytext character set utf8mb4) engine InnoDB;
insert into t1 select repeat('a',300);
insert into t1 select repeat('�',300);
insert into t1 select repeat('a�',300);
insert into t1 select repeat('�a',300);
insert into t1 select repeat('��',300);
select hex(s1) from t1;
select length(s1),char_length(s1) from t1;
drop table t1;
create table t1 (s1 text character set utf8mb4) engine InnoDB;
insert into t1 select repeat('a',66000);
insert into t1 select repeat('�',66000);
insert into t1 select repeat('a�',66000);
insert into t1 select repeat('�a',66000);
insert into t1 select repeat('��',66000);
select length(s1),char_length(s1) from t1;
drop table t1;
SET sql_mode = default;
create table t1 (s1 char(10) character set utf8mb4) engine InnoDB;
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;
create table t1 (s1 varchar(10) character set utf8mb4) engine InnoDB;
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;
create table t1 (s1 text character set utf8mb4) engine InnoDB;
insert ignore into t1 values (0x41FF);
select hex(s1) from t1;
drop table t1;
create table t1 (a text character set utf8mb4, primary key(a(371))) engine InnoDB ROW_FORMAT=COMPACT;
CREATE TABLE t1 ( a varchar(10) ) CHARACTER SET utf8mb4 ENGINE InnoDB;
INSERT INTO t1 VALUES ( 'test' );
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = b.a;
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = 'test' and b.a = 'test';
SELECT a.a, b.a FROM t1 a, t1 b WHERE a.a = b.a and a.a = 'test';
DROP TABLE t1;
create table t1 (a char(255) character set utf8mb4) engine InnoDB;
insert into t1 values('b'),('b');
select * from t1 where a = 'b';
select * from t1 where a = 'b' and a = 'b';
select * from t1 where a = 'b' and a != 'b';
drop table t1;
set collation_connection=utf8mb4_general_ci;
drop table if exists t1;
create table t1 as select repeat(' ', 64) as s1, repeat(' ',64) as s2 union select null, null;
show create table t1;
delete from t1;
insert into t1 values('aaa','aaa');
insert into t1 values('aaa|qqq','qqq');
insert into t1 values('gheis','^[^a-dXYZ]+$');
insert into t1 values('aab','^aa?b');
insert into t1 values('Baaan','^Ba*n');
insert into t1 values('aaa','qqq|aaa');
