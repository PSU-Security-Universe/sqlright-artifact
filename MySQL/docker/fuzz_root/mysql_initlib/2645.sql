USE INFORMATION_SCHEMA;
SHOW CREATE TABLE INFORMATION_SCHEMA.ROUTINES;
SELECT * FROM information_schema.columns WHERE table_schema = 'information_schema'   AND table_name   = 'ROUTINES' ORDER BY ordinal_position;
DESCRIBE INFORMATION_SCHEMA.ROUTINES;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func1 (s char(20) RETURNS CHAR(50) RETURN CONCAT('Hello', ,s,'!');
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func1 (s char(20)) RETURNS CHAR(50) RETURN CONCAT('Hello, ',s,'!');
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func1';
DROP FUNCTION test_func1;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE PROCEDURE testproc (OUT param1 INT) BEGIN SELECT 2+2 as param1; END; ;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'testproc';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func1 (s char(20)) RETURNS CHAR(50) RETURN CONCAT('Hello, ',s,'!');
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func2 (s int) RETURNS INT RETURN s*2;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func2';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func5 (s date) RETURNS TIMESTAMP RETURN CURRENT_TIMESTAMP;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func5 (s date) RETURNS TIMESTAMP RETURN CURRENT_TIMESTAMP;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func5';
ALTER FUNCTION test_func5 COMMENT 'new comment added';
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test CHARACTER SET  utf8;
USE i_s_routines_test;
CREATE FUNCTION test_func5 (s CHAR(20)) RETURNS VARCHAR(30) RETURN CONCAT('XYZ, ' ,s);
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'i_s_routines_test' AND ROUTINE_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_routines_test;
CREATE DATABASE i_s_routines_test;
USE i_s_routines_test;
CREATE FUNCTION test_func_t (f_p1 DATETIME) RETURNS TIME RETURN NULL;
CREATE FUNCTION test_func_dt (f_p1 DATETIME) RETURNS DATETIME RETURN NULL;
CREATE FUNCTION test_func_ts (f_p1 DATETIME) RETURNS TIMESTAMP RETURN NULL;
CREATE FUNCTION test_func_t0 (f_p1 DATETIME) RETURNS TIME(0) RETURN NULL;
CREATE FUNCTION test_func_dt0 (f_p1 DATETIME) RETURNS DATETIME(0) RETURN NULL;
CREATE FUNCTION test_func_ts0 (f_p1 DATETIME) RETURNS TIMESTAMP(0) RETURN NULL;
CREATE FUNCTION test_func_t1 (f_p1 DATETIME) RETURNS TIME(1) RETURN NULL;
CREATE FUNCTION test_func_dt1 (f_p1 DATETIME) RETURNS DATETIME(1) RETURN NULL;
CREATE FUNCTION test_func_ts1 (f_p1 DATETIME) RETURNS TIMESTAMP(1) RETURN NULL;
CREATE FUNCTION test_func_t2 (f_p1 DATETIME) RETURNS TIME(2) RETURN NULL;
CREATE FUNCTION test_func_dt2 (f_p1 DATETIME) RETURNS DATETIME(2) RETURN NULL;
CREATE FUNCTION test_func_ts2 (f_p1 DATETIME) RETURNS TIMESTAMP(2) RETURN NULL;
CREATE FUNCTION test_func_t3 (f_p1 DATETIME) RETURNS TIME(3) RETURN NULL;
CREATE FUNCTION test_func_dt3 (f_p1 DATETIME) RETURNS DATETIME(3) RETURN NULL;
CREATE FUNCTION test_func_ts3 (f_p1 DATETIME) RETURNS TIMESTAMP(3) RETURN NULL;
CREATE FUNCTION test_func_t4 (f_p1 DATETIME) RETURNS TIME(4) RETURN NULL;
CREATE FUNCTION test_func_dt4 (f_p1 DATETIME) RETURNS DATETIME(4) RETURN NULL;
CREATE FUNCTION test_func_ts4 (f_p1 DATETIME) RETURNS TIMESTAMP(4) RETURN NULL;
CREATE FUNCTION test_func_t5 (f_p1 DATETIME) RETURNS TIME(5) RETURN NULL;
CREATE FUNCTION test_func_dt5 (f_p1 DATETIME) RETURNS DATETIME(5) RETURN NULL;
CREATE FUNCTION test_func_ts5 (f_p1 DATETIME) RETURNS TIMESTAMP(5) RETURN NULL;
CREATE FUNCTION test_func_t6 (f_p1 DATETIME) RETURNS TIME(6) RETURN NULL;
CREATE FUNCTION test_func_dt6 (f_p1 DATETIME) RETURNS DATETIME(6) RETURN NULL;
CREATE FUNCTION test_func_ts6 (f_p1 DATETIME) RETURNS TIMESTAMP(6) RETURN NULL;
SELECT ROUTINE_NAME, ROUTINE_TYPE, DATA_TYPE, DATETIME_PRECISION from  INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA='i_s_routines_test';
DROP DATABASE i_s_routines_test;
USE test;
SELECT @@sql_mode INTO @old_sql_mode;
SET sql_mode = 'pad_char_to_full_length';
CREATE FUNCTION f() RETURNS INT RETURN 1;
SHOW FUNCTION STATUS;
DROP FUNCTION IF EXISTS f;
SET sql_mode = @old_sql_mode;