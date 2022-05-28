drop temporary table if exists t1, t2, t3;
drop table if exists t1, t2, t3;
drop procedure if exists p_verify_reprepare_count;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists v1, v2;
create procedure p_verify_reprepare_count(expected int) begin declare old_reprepare_count int default @reprepare_count; select variable_value from performance_schema.session_status where variable_name='com_stmt_reprepare'   into @reprepare_count; if old_reprepare_count + expected <> @reprepare_count then select concat("Expected: ", expected, ", actual: ", @reprepare_count - old_reprepare_count) as "ERROR"; else select '' as "SUCCESS"; end if; end;
set @reprepare_count= 0;
flush status;
prepare stmt from "select * from t1";
create table t1 (a int);
prepare stmt from "select * from t1";
execute stmt;
call p_verify_reprepare_count(0);
execute stmt;
call p_verify_reprepare_count(0);
drop table t1;
execute stmt;
call p_verify_reprepare_count(0);
execute stmt;
call p_verify_reprepare_count(0);
deallocate prepare stmt;
create table t1 (a int);
prepare stmt from "select * from t1";
execute stmt;
call p_verify_reprepare_count(0);
execute stmt;
call p_verify_reprepare_count(0);
rename table t1 to t2;
execute stmt;
call p_verify_reprepare_count(0);
execute stmt;
call p_verify_reprepare_count(0);
deallocate prepare stmt;
drop table t2;
create table t1 (a int);
prepare stmt from "select a from t1";
execute stmt;
call p_verify_reprepare_count(0);
execute stmt;
call p_verify_reprepare_count(0);
alter table t1 add column (b int);
execute stmt;
call p_verify_reprepare_count(1);
execute stmt;
call p_verify_reprepare_count(0);
drop table t1;
deallocate prepare stmt;
create table t1 (a int);
prepare stmt from "insert into t1 (a) value (?)";
set @val=1;
execute stmt using @val;
call p_verify_reprepare_count(0);
create trigger t1_bi before insert on t1 for each row set @message= new.a;
set @val=2;
execute stmt using @val;
call p_verify_reprepare_count(1);
select @message;
set @val=3;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
prepare stmt from "insert into t1 (a) value (?)";
set @val=4;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
create trigger t1_bd before delete on t1 for each row set @message= old.a;
set @val=5;
execute stmt using @val;
call p_verify_reprepare_count(1);
select @message;
set @val=6;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
prepare stmt from "insert into t1 (a) value (?)";
set @val=7;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
drop trigger t1_bi;
create trigger t1_bi before insert on t1 for each row set @message= concat("new trigger: ", new.a);
set @val=8;
execute stmt using @val;
call p_verify_reprepare_count(1);
select @message;
set @val=9;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
prepare stmt from "insert into t1 (a) value (?)";
set @val=10;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
drop trigger t1_bd;
set @val=11;
execute stmt using @val;
call p_verify_reprepare_count(1);
select @message;
drop trigger t1_bi;
set @val=12;
execute stmt using @val;
call p_verify_reprepare_count(1);
select @message;
set @val=13;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
prepare stmt from "insert into t1 (a) value (?)";
set @val=14;
execute stmt using @val;
call p_verify_reprepare_count(0);
select @message;
select * from t1 order by a;
drop table t1;
deallocate prepare stmt;
create table t1 (a int);
create trigger t1_ai after insert on t1 for each row call p1(new.a);
create procedure p1(a int) begin end;
prepare stmt from "insert into t1 (a) values (?)";