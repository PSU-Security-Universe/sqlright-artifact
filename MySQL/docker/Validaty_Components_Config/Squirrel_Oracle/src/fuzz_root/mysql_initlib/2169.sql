drop database if exists events_test;
create database events_test;
use events_test;
create event e_26 on schedule at '2037-01-01 00:00:00' disable do set @a = 5;
select  event_definition, definer, convert_tz(execute_at, 'UTC', 'SYSTEM'), on_completion from information_schema.events;
drop event e_26;
create event e_26 on schedule at NULL disable do set @a = 5;
create event e_26 on schedule at 'definitely not a datetime' disable do set @a = 5;
set names utf8;
create event задачка on schedule every 123 minute starts now() ends now() + interval 1 month do select 1;
drop event задачка;
set global event_scheduler=off;
select definer, event_name from information_schema.events;
select get_lock("test_lock1", 20);
create event закачка on schedule every 10 hour do select get_lock("test_lock1", 20);
select definer, event_name from information_schema.events;
select /*1*/ user, host, db, command, state, info from information_schema.processlist where (user='event_scheduler') order by info;
select release_lock("test_lock1");
drop event закачка;
select count(*) from information_schema.events;
set global event_scheduler=on;
select get_lock("test_lock2", 20);
create event закачка on schedule every 10 hour do select get_lock("test_lock2", 20);
select /*2*/ user, host, db, command, state, info from information_schema.processlist where (info like "select get_lock%" OR user='event_scheduler') order by info;
select release_lock("test_lock2");
drop event закачка;
select get_lock("test_lock2_1", 20);
create event закачка21 on schedule every 10 hour do select get_lock("test_lock2_1", 20);
select /*3*/ user, host, db, command, state, info from information_schema.processlist where (info like "select get_lock%" OR user='event_scheduler') order by info;
set global event_scheduler=off;
select /*4*/ user, host, db, command, state, info from information_schema.processlist where (info like "select get_lock%" OR user='event_scheduler') order by info;
select release_lock("test_lock2_1");
drop event закачка21;
set global event_scheduler = ON;
create table t_16 (s1 int);
create trigger t_16_bi before insert on t_16 for each row create event  e_16 on schedule every 1 second do set @a=5;
drop table t_16;
create event white_space on schedule every 10 hour disable do select 1;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event white_space on schedule every 10 hour disable do select 2;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event white_space on schedule every 10 hour disable do	select 3;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event e1 on schedule every 1 year do set @a = 5;
create table t1 (s1 int);
create trigger t1_ai after insert on t1 for each row show create event e1;
drop table t1;
drop event e1;
SHOW EVENTS FROM aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
SHOW EVENTS FROM ``;
SHOW EVENTS FROM `events\\test`;
create table t1 (a int);
create event e1 on schedule every 10 hour do select 1;
lock table t1 read;
show create event e1;
select event_name from information_schema.events;
create event e2 on schedule every 10 hour do select 1;
alter event e2 disable;
alter event e2 rename to e3;
drop event e2;
drop event e1;
unlock tables;
drop event e1;
select event_name from information_schema.events;
create event e1 on schedule every 10 hour do select 1;
create trigger trg before insert on t1 for each row begin show create event e1; end;
create function f1() returns int begin select event_name from information_schema.events; return 1; end;
insert into t1 (a) values (1);
drop procedure p1;
insert into t1 (a) values (1);
select * from tmp;
drop temporary table tmp;
drop procedure p1;
insert into t1 (a) values (1);
drop procedure p1;
insert into t1 (a) values (1);
drop table t1;
drop event e1;
set names utf8;
create event имя_события_в_кодировке_утф8_длиной_больше_чем_48 on schedule every 2 year do select 1;
select EVENT_NAME from information_schema.events where event_schema='test';
drop event имя_события_в_кодировке_утф8_длиной_больше_чем_48;
create event очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66 on schedule every 2 year do select 1;
create event event_35981 on schedule every 6 month on completion preserve disable do select 1;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'PRESERVE';
alter   event event_35981 enable;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'PRESERVE';
alter   event event_35981 on completion not preserve;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'NOT PRESERVE';
alter   event event_35981 disable;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'NOT PRESERVE';
alter   event event_35981 on completion preserve;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'PRESERVE';
drop event event_35981;
create event event_35981 on schedule every 6 month disable do select 1;
select  count(*) from information_schema.events where   event_schema = database() and event_name = 'event_35981' and on_completion = 'NOT PRESERVE';
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp on completion not preserve do select 1;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'   ends '1999-01-02 00:00:00';
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp on completion not preserve do select 1;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'   ends '1999-01-02 00:00:00' on completion preserve;
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp on completion preserve do select 1;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'   ends '1999-01-02 00:00:00';
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'   ends '1999-01-02 00:00:00' on completion not preserve;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'   ends '1999-01-02 00:00:00' on completion preserve;
drop event event_35981;