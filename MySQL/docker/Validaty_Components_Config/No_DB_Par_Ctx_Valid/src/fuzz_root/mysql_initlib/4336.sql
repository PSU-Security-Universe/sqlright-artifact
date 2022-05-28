use test;
drop table if exists t1,t2,t3,t4;
drop view if exists v1;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
create table t1 ( id   char(16) not null default '', data int not null ) engine=myisam;
create table t2 ( s   char(16), i   int, d   double ) engine=myisam;
drop procedure if exists foo42;
create procedure foo42() insert into test.t1 values ("foo", 42);
call foo42();
select * from t1;
delete from t1;
drop procedure foo42;
drop procedure if exists bar;
create procedure bar(x char(16), y int) insert into test.t1 values (x, y);
call bar("bar", 666);
select * from t1;
delete from t1;
drop procedure if exists `empty`;
create procedure `empty`() begin end;
call `empty`();
drop procedure `empty`;
drop procedure if exists scope;
create procedure scope(a int, b float) begin declare b int; declare c float; begin declare c int; end; end;
drop procedure scope;
drop procedure if exists two;
create procedure two(x1 char(16), x2 char(16), y int) begin insert into test.t1 values (x1, y); insert into test.t1 values (x2, y); end;
call two("one", "two", 3);
select * from t1;
delete from t1;
drop procedure two;
drop procedure if exists locset;
create procedure locset(x char(16), y int) begin declare z1, z2 int; set z1 = y; set z2 = z1+2; insert into test.t1 values (x, z2); end;
call locset("locset", 19);
select * from t1;
delete from t1;
drop procedure locset;
drop procedure if exists setcontext;
create procedure setcontext() begin declare data int default 2; insert into t1 (id, data) values ("foo", 1); replace t1 set data = data, id = "bar"; update t1 set id = "kaka", data = 3 where t1.data = data; end;
call setcontext();
select * from t1 order by data;
delete from t1;
drop procedure setcontext;
create table t3 ( d date, i int, f double, s varchar(32) );
drop procedure if exists nullset;
create procedure nullset() begin declare ld date; declare li int; declare lf double; declare ls varchar(32); set ld = null, li = null, lf = null, ls = null; insert into t3 values (ld, li, lf, ls); insert into t3 (i, f, s) values ((ld is null), 1,    "ld is null"), ((li is null), 1,    "li is null"), ((li = 0),     null, "li = 0"), ((lf is null), 1,    "lf is null"), ((lf = 0),     null, "lf = 0"), ((ls is null), 1,    "ls is null"); end;
call nullset();
select * from t3;
drop table t3;
drop procedure nullset;
drop procedure if exists mixset;
create procedure mixset(x char(16), y int) begin declare z int; set @z = y, z = 666; insert into test.t1 values (x, z); end;
call mixset("mixset", 19);
show variables like 'max_join_size';
select id,data,@z from t1;
delete from t1;
drop procedure mixset;
drop procedure if exists zip;
create procedure zip(x char(16), y int) begin declare z int; call zap(y, z); call bar(x, z); end;
drop procedure if exists zap;
create procedure zap(x int, out y int) begin declare z int; set z = x+1, y = z; end;
call zip("zip", 99);
select * from t1;
delete from t1;
drop procedure zip;
drop procedure bar;
call zap(7, @zap);
select @zap;
drop procedure zap;
drop procedure if exists c1;
create procedure c1(x int) call c2("c", x);
drop procedure if exists c2;
create procedure c2(s char(16), x int) call c3(x, s);
drop procedure if exists c3;
create procedure c3(x int, s char(16)) call c4("level", x, s);
drop procedure if exists c4;
create procedure c4(l char(8), x int, s char(16)) insert into t1 values (concat(l,s), x);
call c1(42);
select * from t1;
delete from t1;
drop procedure c1;
drop procedure c2;
drop procedure c3;
drop procedure c4;
drop procedure if exists iotest;
create procedure iotest(x1 char(16), x2 char(16), y int) begin call inc2(x2, y); insert into test.t1 values (x1, y); end;
drop procedure if exists inc2;
create procedure inc2(x char(16), y int) begin call inc(y); insert into test.t1 values (x, y); end;
drop procedure if exists inc;
create procedure inc(inout io int) set io = io + 1;
call iotest("io1", "io2", 1);
select * from t1 order by data desc;
delete from t1;
drop procedure iotest;
drop procedure inc2;
drop procedure if exists incr;
create procedure incr(inout x int) call inc(x);
select @zap;
call incr(@zap);
select @zap;
drop procedure inc;
drop procedure incr;
drop procedure if exists cbv1;
create procedure cbv1() begin declare y int default 3; call cbv2(y+1, y); insert into test.t1 values ("cbv1", y); end;
drop procedure if exists cbv2;
create procedure cbv2(y1 int, inout y2 int) begin set y2 = 4711; insert into test.t1 values ("cbv2", y1); end;
call cbv1();
select * from t1 order by data;
delete from t1;
drop procedure cbv1;
drop procedure cbv2;
insert into t2 values ("a", 1, 1.1), ("b", 2, 1.2), ("c", 3, 1.3);
drop procedure if exists sub1;
create procedure sub1(id char(16), x int) insert into test.t1 values (id, x);
drop procedure if exists sub2;
create procedure sub2(id char(16)) begin declare x int; set x = (select sum(t.i) from test.t2 t); insert into test.t1 values (id, x); end;
drop procedure if exists sub3;
create function sub3(i int) returns int deterministic return i+1;
call sub1("sub1a", (select 7));
call sub1("sub1b", (select max(i) from t2));