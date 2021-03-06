use mysql;
SET @old_log_output = @@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
truncate table general_log;
select * from general_log;
truncate table slow_log;
select * from slow_log;
alter table mysql.general_log engine=myisam;
alter table mysql.slow_log engine=myisam;
drop table mysql.general_log;
drop table mysql.slow_log;
set global general_log='OFF';
alter table mysql.slow_log engine=myisam;
set global slow_query_log='OFF';
show create table mysql.general_log;
show create table mysql.slow_log;
alter table mysql.general_log engine=myisam;
alter table mysql.slow_log engine=myisam;
show create table mysql.general_log;
show create table mysql.slow_log;
set global general_log='ON';
set global slow_query_log='ON';
select * from mysql.general_log;
flush logs;
lock tables mysql.general_log WRITE;
lock tables mysql.slow_log WRITE;
lock tables mysql.general_log READ;
lock tables mysql.slow_log READ;
set global general_log='OFF';
set global slow_query_log='OFF';
set @save_storage_engine= @@session.default_storage_engine;
set default_storage_engine= MEMORY;
alter table mysql.slow_log engine=NonExistentEngine;
alter table mysql.slow_log engine=memory;
set default_storage_engine= @save_storage_engine;
drop table mysql.slow_log;
drop table mysql.general_log;
drop table mysql.general_log;
drop table mysql.slow_log;
CREATE TABLE `general_log` ( `event_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), `user_host` mediumtext NOT NULL, `thread_id` bigint(21) unsigned NOT NULL, `server_id` int(10) unsigned NOT NULL, `command_type` varchar(64) NOT NULL, `argument` mediumblob NOT NULL ) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log';
CREATE TABLE `slow_log` ( `start_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6), `user_host` mediumtext NOT NULL, `query_time` time(6) NOT NULL, `lock_time` time(6) NOT NULL, `rows_sent` int(11) NOT NULL, `rows_examined` int(11) NOT NULL, `db` varchar(512) NOT NULL, `last_insert_id` int(11) NOT NULL, `insert_id` int(11) NOT NULL, `server_id` int(10) unsigned NOT NULL, `sql_text` mediumblob NOT NULL, `thread_id` bigint(21) unsigned NOT NULL ) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log';
set global general_log='ON';
set global slow_query_log='ON';
SET GLOBAL log_output=@old_log_output;
TRUNCATE TABLE mysql.general_log;
use test;
