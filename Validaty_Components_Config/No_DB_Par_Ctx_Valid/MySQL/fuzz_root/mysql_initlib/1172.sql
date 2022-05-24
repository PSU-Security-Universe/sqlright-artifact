SET @@session.myisam_sort_buffer_size = 4294967296;
SET @@session.myisam_sort_buffer_size = 8388608;
SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT COUNT(@@SESSION.sort_buffer_size);
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@SESSION.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
SET @@GLOBAL.sort_buffer_size=DEFAULT;
SELECT @@GLOBAL.sort_buffer_size;
SET @@local.sort_buffer_size=9999999;
SET @@session.sort_buffer_size=9999999;
SET @@GLOBAL.sort_buffer_size=9999999;
SET @@local.sort_buffer_size=DEFAULT;
SET @@session.sort_buffer_size=DEFAULT;
SET @@GLOBAL.sort_buffer_size=DEFAULT;
SELECT @@GLOBAL.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size = VARIABLE_VALUE FROM performance_schema.global_variables WHERE VARIABLE_NAME='sort_buffer_size';
SELECT @@session.sort_buffer_size = VARIABLE_VALUE  FROM performance_schema.session_variables  WHERE VARIABLE_NAME='sort_buffer_size';
SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT COUNT(VARIABLE_VALUE) FROM performance_schema.global_variables  WHERE VARIABLE_NAME='sort_buffer_size';
SELECT @@sort_buffer_size = @@GLOBAL.sort_buffer_size;
SELECT COUNT(@@sort_buffer_size);
SELECT COUNT(@@local.sort_buffer_size);
SELECT COUNT(@@SESSION.sort_buffer_size);
SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT sort_buffer_size = @@SESSION.sort_buffer_size;
SET @@GLOBAL.sort_buffer_size=32767;
SET @@session.sort_buffer_size=32767;
SELECT @@GLOBAL.sort_buffer_size;
select @@session.sort_buffer_size;
SET @@global.sort_buffer_size=-1;
SET @@session.sort_buffer_size=-1;
select @@session.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
CREATE TABLE tab1 (col_1 text(10)) ENGINE=INNODB ;
SET @col_1 = repeat('a', 10);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
INSERT INTO tab1 VALUES (@col_1);
commit;
flush status;
flush table;
SET @@GLOBAL.sort_buffer_size=32768;
SET @@SESSION.sort_buffer_size=32768;
select variable_value from performance_schema.session_status where variable_name ='Sort_merge_passes';
select variable_value from performance_schema.session_status where variable_name ='Sort_rows';
select variable_value from performance_schema.session_status where variable_name ='Sort_scan';
set @Sort_merge_passes = (select variable_value from performance_schema.session_status where variable_name ='Sort_merge_passes');
set @Sort_rows = (select variable_value from performance_schema.session_status where variable_name ='Sort_rows');
set @Sort_scan = (select variable_value from performance_schema.session_status where variable_name ='Sort_scan');
set @optimizer_switch_saved=@@optimizer_switch;
set optimizer_switch='derived_merge=off';
select count(1) from (select b.* from tab1 b inner join tab1 c inner join tab1 d inner join tab1 e inner join tab1 f order by 1) a;
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;
select count(1) from (select b.* from tab1 b inner join tab1 c inner join tab1 d inner join tab1 e inner join tab1 f order by 1) a;
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;
set @@optimizer_switch=@optimizer_switch_saved;
DROP TABLE IF EXISTS tab1;
SET @@session.sort_buffer_size=DEFAULT;
SET @@GLOBAL.sort_buffer_size=DEFAULT;
