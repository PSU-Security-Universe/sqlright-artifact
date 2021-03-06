SELECT num_nonnulls(NULL);
SELECT num_nonnulls('1');
SELECT num_nonnulls(NULL::text);
SELECT num_nonnulls(NULL::text, NULL::int);
SELECT num_nonnulls(1, 2, NULL::text, NULL::point, '', int8 '9', 1.0 / NULL);
SELECT num_nonnulls(VARIADIC '{1,2,NULL,3}'::int[]);
SELECT num_nonnulls(VARIADIC '{"1","2","3","4"}'::text[]);
SELECT num_nonnulls(VARIADIC ARRAY(SELECT CASE WHEN i <> 40 THEN i END FROM generate_series(1, 100) i));
SELECT num_nulls(NULL);
SELECT num_nulls('1');
SELECT num_nulls(NULL::text);
SELECT num_nulls(NULL::text, NULL::int);
SELECT num_nulls(1, 2, NULL::text, NULL::point, '', int8 '9', 1.0 / NULL);
SELECT num_nulls(VARIADIC '{1,2,NULL,3}'::int[]);
SELECT num_nulls(VARIADIC '{"1","2","3","4"}'::text[]);
SELECT num_nulls(VARIADIC ARRAY(SELECT CASE WHEN i <> 40 THEN i END FROM generate_series(1, 100) i));
SELECT num_nonnulls(VARIADIC NULL::text[]);
SELECT num_nonnulls(VARIADIC '{}'::int[]);
SELECT num_nulls(VARIADIC NULL::text[]);
SELECT num_nulls(VARIADIC '{}'::int[]);
SELECT num_nonnulls();
SELECT num_nulls();
select setting as segsizefrom pg_settings where name = 'wal_segment_size'\gsetselect count(*) > 0 as ok from pg_ls_waldir();
select count(*) > 0 as ok from (select pg_ls_waldir()) ss;
select * from pg_ls_waldir() limit 0;
select count(*) > 0 as ok from (select * from pg_ls_waldir() limit 1) ss;
select (w).size = :segsize as okfrom (select pg_ls_waldir() w) ss where length((w).name) = 24 limit 1;
select count(*) >= 0 as ok from pg_ls_archive_statusdir();
select * from (select pg_ls_dir('.') a) a where a = 'base' limit 1;
select * from (select (pg_timezone_names()).name) ptn where name='UTC' limit 1;
select count(*) > 0 from  (select pg_tablespace_databases(oid) as pts from pg_tablespace   where spcname = 'pg_default') pts  join pg_database db on pts.pts = db.oid;
CREATE FUNCTION my_int_eq(int, int) RETURNS bool  LANGUAGE internal STRICT IMMUTABLE PARALLEL SAFE  AS int4eq;
EXPLAIN (COSTS OFF)SELECT * FROM tenk1 a JOIN tenk1 b ON a.unique1 = b.unique1WHERE my_int_eq(a.unique2, 42);
ALTER FUNCTION my_int_eq(int, int) SUPPORT test_support_func;
EXPLAIN (COSTS OFF)SELECT * FROM tenk1 a JOIN tenk1 b ON a.unique1 = b.unique1WHERE my_int_eq(a.unique2, 42);
CREATE FUNCTION my_gen_series(int, int) RETURNS SETOF integer  LANGUAGE internal STRICT IMMUTABLE PARALLEL SAFE  AS generate_series_int4  SUPPORT test_support_func;
EXPLAIN (COSTS OFF)SELECT * FROM tenk1 a JOIN my_gen_series(1,1000) g ON a.unique1 = g;
EXPLAIN (COSTS OFF)SELECT * FROM tenk1 a JOIN my_gen_series(1,10) g ON a.unique1 = g;
