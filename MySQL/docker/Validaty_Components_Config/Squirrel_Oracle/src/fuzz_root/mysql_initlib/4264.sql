SET @start_global_value = @@global.max_error_count;
SELECT @start_global_value;
SET @start_session_value = @@session.max_error_count;
SELECT @start_session_value;
drop database if exists demo;
create database demo;
use demo;
create procedure proc_1() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_1'; call proc_2(); end ;
create procedure proc_2() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_2'; call proc_3(); end ;
create procedure proc_3() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_3'; call proc_4(); end ;
create procedure proc_4() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_4'; call proc_5(); end ;
create procedure proc_5() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_5'; call proc_6(); end ;
create procedure proc_6() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_6'; call proc_7(); end ;
create procedure proc_7() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_7'; call proc_8(); end ;
create procedure proc_8() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_8'; call proc_9(); end ;
create procedure proc_9() begin declare exit handler for sqlexception resignal sqlstate '45000' set message_text='Oops in proc_9'; ## Do something that fails, to see how errors are reported drop table oops_it_is_not_here; end ;
call proc_1();
show warnings;
SET @@session.max_error_count = 5;
SELECT @@session.max_error_count;
call proc_1();
show warnings;
SET @@session.max_error_count = 7;
SELECT @@session.max_error_count;
call proc_1();
show warnings;
SET @@session.max_error_count = 9;
SELECT @@session.max_error_count;
call proc_1();
show warnings;
drop database demo;
SET @@global.max_error_count = @start_global_value;
SELECT @@global.max_error_count;
SET @@session.max_error_count = @start_session_value;
SELECT @@session.max_error_count;
