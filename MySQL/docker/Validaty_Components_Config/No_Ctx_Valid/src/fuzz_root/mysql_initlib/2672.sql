SET @previous_binlog_format__htnt542nh=@@GLOBAL.binlog_format;
SET @@GLOBAL.binlog_format=STATEMENT;
SET binlog_format=STATEMENT;
select @@session.transaction_isolation;
drop table if exists t0, t1, t2, t3, t4, t5;
drop view if exists v1, v2;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
drop function if exists f3;
drop function if exists f4;
drop function if exists f5;
drop function if exists f6;
drop function if exists f7;
drop function if exists f8;
drop function if exists f9;
drop function if exists f10;
drop function if exists f11;
drop function if exists f12;
drop function if exists f13;
drop function if exists f14;
drop function if exists f15;
create table t1 (i int primary key) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
create table t2 (j int primary key) engine=innodb;
insert into t2 values (1), (2), (3), (4), (5);
create table t3 (k int primary key) engine=innodb;
insert into t3 values (1), (2), (3);
create table t4 (l int primary key) engine=innodb;
insert into t4 values (1);
create table t5 (l int primary key) engine=innodb;
insert into t5 values (1);
create view v1 as select i from t1;
create view v2 as select j from t2 where j in (select i from t1);
create procedure p1(k int) insert into t2 values (k);
create function f1() returns int begin declare j int; select i from t1 where i = 1 into j; return j; end;
create function f2() returns int begin declare k int; select i from t1 where i = 1 into k; insert into t2 values (k + 5); return 0; end;
create function f6() returns int begin declare k int; select i from v1 where i = 1 into k; return k; end;
create function f7() returns int begin declare k int; select j from v2 where j = 1 into k; return k; end;
create function f8() returns int begin declare k int; select i from v1 where i = 1 into k; insert into t2 values (k+5); return k; end;
create function f9() returns int begin update v2 set j=j+10 where j=1; return 1; end;
create function f11() returns int begin declare k int; set k= f1(); insert into t2 values (k+5); return k; end;
create function f12(p int) returns int begin insert into t2 values (p); return p; end;
create function f13(p int) returns int begin return p; end;
create function f14() returns int begin declare k int; call p2(k); insert into t2 values (k+5); return k; end;
create function f15() returns int begin declare k int; call p2(k); return k; end;
create trigger t4_bi before insert on t4 for each row begin declare k int; select i from t1 where i=1 into k; set new.l= k+1; end;
create trigger t4_bd before delete on t4 for each row begin if !(select i from v1 where i=1) then signal sqlstate '45000'; end if; end;
create trigger t5_bu before update on t5 for each row begin declare j int; call p2(j); set new.l= j + 1; end;
begin;
select * from t1 for update;;
begin;
select * from t1;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
update t2, t1 set j= j - 1 where i = j;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
delete t2 from t1, t2 where i = j;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
describe t1;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
show create table t1;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
show keys from t1;;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
call p1((select i + 5 from t1 where i = 1));;
rollback;
rollback;
begin;
select * from t1 for update;;
begin;
create table t0 engine=innodb select * from t1;;
rollback;
rollback;
drop table t0;
begin;
select * from t1 for update;;
begin;
create table t0 engine=innodb select j from t2 where j in (select i from t1);;
rollback;
rollback;
