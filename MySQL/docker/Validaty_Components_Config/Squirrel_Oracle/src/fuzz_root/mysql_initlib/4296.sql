create table t3 ( x int );
insert into t3 values (2), (3);
create procedure bad_into(out param int) select x from t3 into param;
call bad_into(@x);
drop procedure bad_into;
drop table t3;
create procedure proc1() set @x = 42;
create function func1() returns int return 42;
create procedure foo() create procedure bar() set @x=3;
create procedure foo() create function bar() returns double return 2.3;
create procedure proc1() set @x = 42;
create function func1() returns int return 42;
drop procedure proc1;
drop function func1;
alter procedure foo;
alter function foo;
drop procedure foo;
drop function foo;
call foo();
drop procedure if exists foo;
show create procedure foo;
show create function foo;
create procedure foo() foo: loop foo: loop set @x=2; end loop foo; end loop foo;
create procedure foo() foo: loop set @x=2; end loop bar;
create procedure foo() return 42;
create procedure p(x int) set @x = x;
create function f(x int) returns int return x+42;
call p();
call p(1, 2);
select f();
select f(1, 2);
drop procedure p;
drop function f;
create procedure p(val int, out res int) begin declare x int default 0; declare continue handler for foo set x = 1; insert into test.t1 values (val); if (x) then set res = 0; else set res = 1; end if; end;
create procedure p(val int, out res int) begin declare x int default 0; declare foo condition for 1146; declare continue handler for bar set x = 1; insert into test.t1 values (val); if (x) then set res = 0; else set res = 1; end if; end;
create function f(val int) returns int begin declare x int; set x = val+3; end;
create function f(val int) returns int begin declare x int; set x = val+3; if x < 4 then return x; end if; end;
select f(10);
drop function f;
create procedure p() begin declare x int; declare c cursor for select * into x from test.t limit 1; open c; close c; end;
create procedure p() begin declare c cursor for select * from test.t; open cc; close c; end;
create table t1 (val int);
create procedure p() begin declare c cursor for select * from test.t1; open c; open c; close c; end;
call p();
drop procedure p;
create procedure p() begin declare c cursor for select * from test.t1; open c; close c; close c; end;
call p();
drop procedure p;
alter procedure bar3 sql security invoker;
drop table t1;
create table t1 (val int, x float);
insert into t1 values (42, 3.1), (19, 1.2);
create procedure p() begin declare x int; declare c cursor for select * from t1; open c; fetch c into x, y; close c; end;
create procedure p() begin declare x int; declare c cursor for select * from t1; open c; fetch c into x; close c; end;
call p();
drop procedure p;
create procedure p() begin declare x int; declare y float; declare z int; declare c cursor for select * from t1; open c; fetch c into x, y, z; close c; end;
call p();
drop procedure p;
create procedure p(in x int, x char(10)) begin end;
create procedure p() begin declare c cursor for select * from t1; declare c cursor for select field from t1; end;
create procedure u() use sptmp;
create procedure p() begin declare c cursor for select * from t1; declare x int; end;
create procedure p() begin declare x int; declare continue handler for sqlstate '42S99' set x = 1; declare foo condition for sqlstate '42S99'; end;
create procedure p() begin declare x int; declare continue handler for sqlstate '42S99' set x = 1; declare c cursor for select * from t1; end;
create procedure p(in x int, inout y int, out z int) begin set y = x+y; set z = x+y; end;
set @tmp_x = 42;
set @tmp_y = 3;
set @tmp_z = 0;
call p(@tmp_x, @tmp_y, @tmp_z);
select @tmp_x, @tmp_y, @tmp_z;
call p(42, 43, @tmp_z);
call p(42, @tmp_y, 43);
drop procedure p;
create procedure p() begin end;
lock table t1 read;
call p();
unlock tables;
drop procedure p;
select val, f1(val) from t1;
select val, f1(val) from t1 as tab;
select * from t1;
update t1 set val= f1(val);
select * from t1;
select f1(17);
select * from t1;
delete from t1 where val= 17;
drop function f1;
call bug1965();
drop procedure bug1965;
select 1 into a;
create table t3 (column_1_0 int);
create procedure bug1653() update t3 set column_1 = 0;
call bug1653();
drop table t3;
create table t3 (column_1 int);
call bug1653();
drop procedure bug1653;
drop table t3;
create procedure bug2259() begin declare v1 int; declare c1 cursor for select s1 from t1; fetch c1 into v1; end;
call bug2259();
drop procedure bug2259;
create procedure bug2272() begin declare v int; update t1 set v = 42; end;
insert into t1 values (666, 51.3);
call bug2272();
truncate table t1;
drop procedure bug2272;
create procedure bug2329_1() begin declare v int; insert into t1 (v) values (5); end;
create procedure bug2329_2() begin declare v int; replace t1 set v = 5; end;
call bug2329_1();
