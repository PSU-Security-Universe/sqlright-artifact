SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
select database();
select charset(database());
select database() = "test";
select database() = _utf8"test";
select database() = _latin1"test";
select user() like "%@%";
select user() like _utf8"%@%";
select user() like _latin1"%@%";
select charset(user());
select version()>="3.23.29";
select version()>=_utf8"3.23.29";
select version()>=_latin1"3.23.29";
select charset(version());
explain select database(), user();
create table t1 (version char(60)) select database(), user(), version() as 'version';
show create table t1;
drop table t1;
select charset(charset(_utf8'a')), charset(collation(_utf8'a'));
select collation(charset(_utf8'a')), collation(collation(_utf8'a'));
create table t1 select charset(_utf8'a'), collation(_utf8'a');
show create table t1;
drop table t1;
select TRUE,FALSE,NULL;
SET sql_mode = default;
create table t1 (c1 char(5)) character set=latin1;
insert into t1 values('row 1');
insert into t1 values('row 2');
insert into t1 values('row 3');
select concat(user(), '--', c1) from t1;
select concat(database(), '--', c1) from t1;
drop table t1;
create table t1 (a char(10)) character set latin1;
select * from t1 where a=version();
select * from t1 where a=database();
select * from t1 where a=user();
insert into t1 values ('a');
select left(concat(a,version()),1) from t1;
drop table t1;
execute s;
