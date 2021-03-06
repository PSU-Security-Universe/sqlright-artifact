drop table if exists t1,t2,t3,t4,t5,t6;
drop database if exists mysqltest;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
INSERT into t1 (b) values ('1');
SHOW WARNINGS;
SELECT * from t1;
SHOW CREATE TABLE t2;
INSERT into t2 (b) values ('1');
SHOW WARNINGS;
SELECT * from t2;
drop table t1;
drop table t2;
create table bug20691 (i int, d datetime NOT NULL, dn datetime not null default '0000-00-00 00:00:00');
insert into bug20691 values (1, DEFAULT, DEFAULT), (1, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (1, DEFAULT, DEFAULT);
insert into bug20691 (i) values (2);
desc bug20691;
insert into bug20691 values (3, DEFAULT, DEFAULT), (3, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (3, DEFAULT, DEFAULT);
insert into bug20691 (i) values (4);
insert into bug20691 values (5, DEFAULT, DEFAULT), (5, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (5, DEFAULT, DEFAULT);
SET sql_mode = 'ALLOW_INVALID_DATES';
insert into bug20691 values (6, DEFAULT, DEFAULT), (6, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (6, DEFAULT, DEFAULT);
SET sql_mode = default;
insert into bug20691 values (7, DEFAULT, DEFAULT), (7, '1975-07-10 07:10:03', '1978-01-13 14:08:51'), (7, DEFAULT, DEFAULT);
select * from bug20691 order by i asc;
drop table bug20691;
SET sql_mode = '';
create table bug20691 ( a set('one', 'two', 'three') not null, b enum('small', 'medium', 'large', 'enormous', 'ellisonego') not null, c time not null, d date not null, e int not null, f long not null, g blob not null, h datetime not null, i decimal not null, x int);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 1);
insert into bug20691 (x) values (2);
insert into bug20691 values (2, 3, 5, '0007-01-01', 11, 13, 17, '0019-01-01 00:00:00', 23, 3);
insert into bug20691 values (DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, 4);
select * from bug20691 order by x asc;
drop table bug20691;
create table t1 (id int not null);
insert into t1 values(default);
create view v1 (c) as select id from t1;
insert into t1 values(default);
drop view v1;
drop table t1;
create table t1 (a int unique);
create table t2 (b int default 10);
insert into t1 (a) values (1);
insert into t2 (b) values (1);
insert into t1 (a) select b from t2 on duplicate key update a=default;
select * from t1;
insert into t1 (a) values (1);
insert into t1 (a) select b from t2 on duplicate key update a=default(b);
select * from t1;
drop table t1, t2;
SET sql_mode = default;
CREATE TABLE ts(ts TIMESTAMP DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE dt(dt DATETIME DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE ints(a INT DEFAULT TIMESTAMP'2019-10-01 01:02:03');
CREATE TABLE t(t TIME DEFAULT TIME'01:02:03');
CREATE TABLE d(d DATE DEFAULT DATE'2019-10-01');
