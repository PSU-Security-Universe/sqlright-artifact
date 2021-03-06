create table t1 (s1 binary(3));
insert into t1 values (0x61), (0x6120), (0x612020);
select hex(s1) from t1;
drop table t1;
create table t1 (s1 binary(2), s2 varbinary(2));
insert into t1 values (0x4100,0x4100);
select length(concat('*',s1,'*',s2,'*')) from t1;
delete from t1;
insert into t1 values (0x4120,0x4120);
select length(concat('*',s1,'*',s2,'*')) from t1;
drop table t1;
create table t1 (s1 varbinary(20), s2 varbinary(20));
show create table t1;
insert into t1 values (0x41,0x4100),(0x41,0x4120),(0x4100,0x4120);
select hex(s1), hex(s2) from t1;
select count(*) from t1 where s1 < s2;
drop table t1;
create table t1 (s1 varbinary(2), s2 varchar(1));
insert into t1 values (0x41,'a'), (0x4100,'b'), (0x41,'c'), (0x4100,'d');
select hex(s1),s2 from t1 order by s1,s2;
drop table t1;
create table t1 (s1 binary(2) primary key);
insert into t1 values (0x01);
insert into t1 values (0x0120);
insert into t1 values (0x0100);
select hex(s1) from t1 order by s1;
select hex(s1) from t1 where s1=0x01;
select hex(s1) from t1 where s1=0x0120;
select hex(s1) from t1 where s1=0x0100;
select count(distinct s1) from t1;
alter table t1 drop primary key;
select hex(s1) from t1 where s1=0x01;
select hex(s1) from t1 where s1=0x0120;
select hex(s1) from t1 where s1=0x0100;
select count(distinct s1) from t1;
drop table t1;
create table t1 (s1 varbinary(2) primary key);
insert into t1 values (0x01);
insert into t1 values (0x0120);
insert into t1 values (0x0100);
select hex(s1) from t1 order by s1;
select hex(s1) from t1 where s1=0x01;
select hex(s1) from t1 where s1=0x0120;
select hex(s1) from t1 where s1=0x0100;
select count(distinct s1) from t1;
alter table t1 drop primary key;
select hex(s1) from t1 where s1=0x01;
select hex(s1) from t1 where s1=0x0120;
select hex(s1) from t1 where s1=0x0100;
select count(distinct s1) from t1;
drop table t1;
select hex(cast(0x10 as binary(2)));
create table t1 (b binary(2), vb varbinary(2));
insert into t1 values(0x4120, 0x4120);
insert ignore into t1 values(0x412020, 0x412020);
drop table t1;
create table t1 (c char(2), vc varchar(2));
insert into t1 values(0x4120, 0x4120);
insert into t1 values(0x412020, 0x412020);
drop table t1;
set @old_sql_mode= @@sql_mode, sql_mode= 'traditional';
create table t1 (b binary(2), vb varbinary(2));
insert into t1 values(0x4120, 0x4120);
insert into t1 values(0x412020, NULL);
insert into t1 values(NULL, 0x412020);
drop table t1;
set @@sql_mode= @old_sql_mode;
create table t1(f1 int, f2 binary(2) not null, f3 char(2) not null);
insert ignore into t1 set f1=1;
select hex(f2), hex(f3) from t1;
drop table t1;
select convert(9999999999999999999999999999999999999999999,unsigned);
select convert('9999999999999999999999999999999999999999999',unsigned);
select convert(0x9999999999999999999999999999999999999999999,unsigned);
create table t1 select convert(0x9999999999999999999999999999999999999999999,unsigned);
select 9999999999999999999999999999999999999999999 | 0;
select '9999999999999999999999999999999999999999999' | 0;
select 0x9999999999999999999999999999999999999999999 | 0;
select 9999999999999999999999999999999999999999999 + 0;
select '9999999999999999999999999999999999999999999' + 0;
select 0x9999999999999999999999999999999999999999999 + 0;
select 0x9999999999999999999999999999999999999999999888888888888888888888888888888888888888888888888888888888888888888888888877777777777777777777777777777777777777777777777777777777777776666666666666666666666666666666666666666 + 0;
create table t1 select 0x9999 + 0;
desc t1;
select * from t1;
drop table t1;
SELECT HEX(0xfffffffffffff+1);
SELECT HEX(0xfffffffffffff+2);
SELECT 0x20000000000000+0;
SELECT 0x20000000000000+1;
SELECT 0x20000000000000+2;
SELECT 0x20000000000000+3;
SELECT 0xfffffffffffff+2;
SELECT 0xfffffffffffff+1;
CREATE VIEW v1 AS SELECT x'7f9d04ae61b34468ac798ffcc984ab68'=x'7f9d04ae61b34468ac798ffcc984ab68' AS a, x'7f9d04ae61b34468ac798ffcc984ab68'=x'7f9d04ae61b34468ac798ffcc984ab60' AS b, x'7f9d04ae61b34468ac798ffcc984ab68'=x'0f9d04ae61b34468ac798ffcc984ab68' AS c, b'111111111111111111111111111111111111111111111111111111111111111111'= b'111111111111111111111111111111111111111111111111111111111111111111' AS d, b'111111111111111111111111111111111111111111111111111111111111111111'= b'111111111111111111111111111111111111111111111111111111111111111110' AS e, b'111111111111111111111111111111111111111111111111111111111111111111'= b'011111111111111111111111111111111111111111111111111111111111111111' AS f;
SELECT x'7f9d04ae61b34468ac798ffcc984ab68'=x'7f9d04ae61b34468ac798ffcc984ab68' AS a, x'7f9d04ae61b34468ac798ffcc984ab68'=x'7f9d04ae61b34468ac798ffcc984ab60' AS b, x'7f9d04ae61b34468ac798ffcc984ab68'=x'0f9d04ae61b34468ac798ffcc984ab68' AS c, b'111111111111111111111111111111111111111111111111111111111111111111'= b'111111111111111111111111111111111111111111111111111111111111111111' AS d, b'111111111111111111111111111111111111111111111111111111111111111111'= b'111111111111111111111111111111111111111111111111111111111111111110' AS e, b'111111111111111111111111111111111111111111111111111111111111111111'= b'011111111111111111111111111111111111111111111111111111111111111111' AS f;
SELECT * FROM v1;
SHOW CREATE VIEW v1;
DROP VIEW v1;
