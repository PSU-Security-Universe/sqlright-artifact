SELECT IF(@@open_files_limit < 5000, 4000, @@GLOBAL.table_open_cache);
SELECT @@GLOBAL.table_open_cache;
SET @@GLOBAL.table_open_cache=DEFAULT;
SELECT @@GLOBAL.table_open_cache;
SET @@local.table_open_cache=1;
SET @@session.table_open_cache=1;
SET @@GLOBAL.table_open_cache=1;
SET @@GLOBAL.table_open_cache=DEFAULT;
SELECT @@GLOBAL.table_open_cache;
SELECT @@GLOBAL.table_open_cache = VARIABLE_VALUE FROM performance_schema.global_variables WHERE VARIABLE_NAME='table_open_cache';
SELECT COUNT(@@GLOBAL.table_open_cache);
SELECT COUNT(VARIABLE_VALUE) FROM performance_schema.global_variables  WHERE VARIABLE_NAME='table_open_cache';
SELECT @@table_open_cache = @@GLOBAL.table_open_cache;
SELECT COUNT(@@local.table_open_cache);
SELECT COUNT(@@SESSION.table_open_cache);
SELECT COUNT(@@GLOBAL.table_open_cache);
SELECT table_open_cache = @@SESSION.table_open_cache;
DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;
DROP TABLE IF EXISTS tab3;
CREATE TABLE tab1 (col_1 text(10)) ENGINE=INNODB ;
SET @col_1 = repeat('a', 10);
INSERT INTO tab1 VALUES (@col_1);
commit;
CREATE TABLE tab2 (col_1 text(10)) ENGINE=INNODB ;
SET @col_1 = repeat('a', 10);
commit;
CREATE TABLE tab3 (col_1 text(10)) ENGINE=INNODB ;
SET @col_1 = repeat('a', 10);
commit;
flush tables;
flush status;
set @@GLOBAL.table_open_cache=2;
select 1 from tab1;
select 1 from tab2;
set @opened_tables = (select variable_value from performance_schema.session_status where variable_name ='Opened_tables');
set @open_cache_hits = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits');
set @open_cache_miss = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses');
set @open_cache_overflow = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows');
select 1 from tab1;
select 1 from tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow;
select 1 from tab3;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow + 1;
flush status;
set @global_opened_tables = (select variable_value from performance_schema.global_status where variable_name ='Opened_tables');
set @global_open_cache_hits = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits');
set @global_open_cache_miss = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses');
set @global_open_cache_overflow = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows');
set @opened_tables = (select variable_value from performance_schema.session_status where variable_name ='Opened_tables');
set @open_cache_hits = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits');
set @open_cache_miss = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses');
set @open_cache_overflow = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows');
select 1 from tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow;
flush status;
select (select variable_value from performance_schema.global_status where variable_name ='Opened_tables') = @global_opened_tables;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits') = @global_open_cache_hits + 1;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses') = @global_open_cache_miss;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows') = @global_open_cache_overflow;
select 1 from tab1;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow + 1;
flush status;
select (select variable_value from performance_schema.global_status where variable_name ='Opened_tables') = @global_opened_tables + 1;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits') = @global_open_cache_hits + 1;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses') = @global_open_cache_miss + 1;
select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows') = @global_open_cache_overflow + 1;
DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;
DROP TABLE IF EXISTS tab3;
set @@GLOBAL.table_open_cache=DEFAULT;
