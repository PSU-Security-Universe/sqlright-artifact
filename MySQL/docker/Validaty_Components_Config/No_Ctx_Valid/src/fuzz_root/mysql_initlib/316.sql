set @start_table_open_cache=@@global.table_open_cache;
set @start_table_definition_cache=@@global.table_definition_cache;
set global table_open_cache=256;
set global table_definition_cache=400;
drop procedure if exists p_create;
create procedure p_create() begin declare i int default 1; set @lock_table_stmt="lock table "; set @drop_table_stmt="drop table "; while i < @@global.table_definition_cache + 1 do set @table_name=concat("t_", i); set @opt_comma=if(i=1, "", ", "); set @lock_table_stmt=concat(@lock_table_stmt, @opt_comma, @table_name, " read"); set @drop_table_stmt=concat(@drop_table_stmt, @opt_comma, @table_name); set @create_table_stmt=concat("create table if not exists ", @table_name, " (a int)"); prepare stmt from @create_table_stmt; execute stmt; deallocate prepare stmt; set i= i+1; end while; end;
call p_create();
drop procedure p_create;
drop table if exists t1, t1_mrg, t1_copy;
create table t1 (a int, key(a)) engine=myisam;
create table t1_mrg (a int) union (t1) engine=merge;
insert into  t1 (a) values (1), (2), (3);
flush table t1;
insert into  t1 (a) values (4), (5), (6);
flush table t1;
check table t1;
select * from t1_mrg;
drop table t1, t1_mrg;
unlock tables;
prepare stmt from @drop_table_stmt;
execute stmt;
deallocate prepare stmt;
set @@global.table_definition_cache=@start_table_definition_cache;
set @@global.table_open_cache=@start_table_open_cache;
create table t1 (a int, key(a)) engine=myisam;
create table t2 (a int);
insert into t2 values (1);
insert into  t1 (a) values (1);
flush table t1;
insert into  t1 (a) values (4);
flush table t1;
check table t1;
set autocommit = 0;
select * from t2;
select * from t1;
ALTER TABLE t2 ADD val INT;
ROLLBACK;
SET autocommit = 1;
drop table t1, t2;
