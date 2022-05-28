SET NAMES latin1;
SET character_set_connection=utf16;
select hex('a'), hex('a ');
select 'a' = 'a', 'a' = 'a ', 'a ' = 'a';
select 'a\0' = 'a', 'a\0' < 'a', 'a\0' > 'a';
select 'a' = 'a\0', 'a' < 'a\0', 'a' > 'a\0';
select 'a\0' = 'a ', 'a\0' < 'a ', 'a\0' > 'a ';
select 'a ' = 'a\0', 'a ' < 'a\0', 'a ' > 'a\0';
select 'a  a' > 'a', 'a  \0' < 'a';
select binary 'a  a' > 'a', binary 'a  \0' > 'a', binary 'a\0' > 'a';
select hex(_utf16 0x44);
select hex(_utf16 0x3344);
select hex(_utf16 0x113344);
CREATE TABLE t1 (word VARCHAR(64), word2 CHAR(64)) CHARACTER SET utf16;
INSERT INTO t1 VALUES (_koi8r 0xF2, _koi8r 0xF2), (X'2004',X'2004');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DELETE FROM t1;
INSERT INTO t1 VALUES (X'042000200020',X'042000200020'), (X'200400200020', X'200400200020');
SELECT hex(word) FROM t1 ORDER BY word;
SELECT hex(word2) FROM t1 ORDER BY word2;
DROP TABLE t1;
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'0421'));
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'04210422'));
SELECT hex(LPAD(_utf16 X'0420',10,_utf16 X'042104220423'));
SELECT hex(LPAD(_utf16 X'0420042104220423042404250426042704280429042A042B',10,_utf16 X'042104220423'));
SELECT hex(LPAD(_utf16 X'D800DC00', 10, _utf16 X'0421'));
SELECT hex(LPAD(_utf16 X'0421', 10, _utf16 X'D800DC00'));
SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'0421'));
SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'04210422'));
SELECT hex(RPAD(_utf16 X'0420',10,_utf16 X'042104220423'));
SELECT hex(RPAD(_utf16 X'0420042104220423042404250426042704280429042A042B',10,_utf16 X'042104220423'));
SELECT hex(RPAD(_utf16 X'D800DC00', 10, _utf16 X'0421'));
SELECT hex(RPAD(_utf16 X'0421', 10, _utf16 X'D800DC00'));
CREATE TABLE t1 SELECT  LPAD(_utf16 X'0420',10,_utf16 X'0421') l, RPAD(_utf16 X'0420',10,_utf16 X'0421') r;
SHOW CREATE TABLE t1;
select hex(l), hex(r) from t1;
DROP TABLE t1;
create table t1 (f1 char(30));
insert into t1 values ("103000"), ("22720000"), ("3401200"), ("78000");
select lpad(f1, 12, "-o-/") from t1;
drop table t1;
SET NAMES latin1;
SET character_set_connection=utf16;
select @@collation_connection;
create table t1 as select repeat(' ',10) as a union select null;
alter table t1 add key(a);
show create table t1;
insert into t1 values ("a"),("abc"),("abcd"),("hello"),("test");
explain select * from t1 where a like 'abc%';
explain select * from t1 where a like concat('abc','%');
select * from t1 where a like "abc%";
select * from t1 where a like concat("abc","%");
select * from t1 where a like "ABC%";
select * from t1 where a like "test%";
select * from t1 where a like "te_t";
select * from t1 where a like "%a%";
select * from t1 where a like "%abcd%";
select * from t1 where a like "%abc\d%";
drop table t1;
select 'AA' like 'AA';
select 'AA' like 'A%A';
select 'AA' like 'A%%A';
select 'AA' like 'AA%';
select 'AA' like '%AA%';
select 'AA' like '%A';
select 'AA' like '%AA';
select 'AA' like 'A%A%';
select 'AA' like '_%_%';
select 'AA' like '%A%A';
select 'AAA'like 'A%A%A';
select 'AZ' like 'AZ';
select 'AZ' like 'A%Z';
select 'AZ' like 'A%%Z';
select 'AZ' like 'AZ%';
select 'AZ' like '%AZ%';
select 'AZ' like '%Z';
select 'AZ' like '%AZ';
select 'AZ' like 'A%Z%';
select 'AZ' like '_%_%';
select 'AZ' like '%A%Z';
select 'AZ' like 'A_';
select 'AZ' like '_Z';
select 'AMZ'like 'A%M%Z';
SET NAMES utf8;
SET character_set_connection=utf16;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf16);
INSERT INTO t1 VALUES ('фыва'),('Фыва'),('фЫва'),('фыВа'),('фывА'),('ФЫВА');
INSERT INTO t1 VALUES ('фывапролдж'),('Фывапролдж'),('фЫвапролдж'),('фыВапролдж');
INSERT INTO t1 VALUES ('фывАпролдж'),('фываПролдж'),('фывапРолдж'),('фывапрОлдж');
INSERT INTO t1 VALUES ('фывапроЛдж'),('фывапролДж'),('фывапролдЖ'),('ФЫВАПРОЛДЖ');
SELECT * FROM t1 WHERE a LIKE '%фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE '%фЫв%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' ORDER BY BINARY a;
SELECT * FROM t1 WHERE a LIKE 'фЫва%' COLLATE utf16_bin ORDER BY BINARY a;
DROP TABLE t1;
CREATE TABLE t1 (word varchar(64) NOT NULL, PRIMARY KEY (word)) CHARACTER SET utf16;
INSERT INTO t1 (word) VALUES ("cat");
SELECT * FROM t1 WHERE word LIKE "c%";
SELECT * FROM t1 WHERE word LIKE "ca_";
SELECT * FROM t1 WHERE word LIKE "cat";
SELECT * FROM t1 WHERE word LIKE _utf16 x'00630025';
SELECT * FROM t1 WHERE word LIKE _utf16 x'00630061005F';
DROP TABLE t1;
select insert(_utf16 0x006100620063,10,2,_utf16 0x006400650066);
select insert(_utf16 0x006100620063,1,2,_utf16 0x006400650066);
SELECT hex(cast(0xAA as char character set utf16));
SELECT hex(convert(0xAA using utf16));
CREATE TABLE t1 (a char(10) character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a varchar(10) character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a text character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);
SELECT HEX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a mediumtext character set utf16);
INSERT INTO t1 VALUES (0x1),(0x11),(0x111),(0x1111),(0x11111);