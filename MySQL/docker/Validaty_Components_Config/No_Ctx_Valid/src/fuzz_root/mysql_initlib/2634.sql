USE INFORMATION_SCHEMA;
SHOW CREATE TABLE INFORMATION_SCHEMA.PARAMETERS;
SELECT * FROM information_schema.columns WHERE table_schema = 'information_schema'   AND table_name   = 'PARAMETERS' ORDER BY ordinal_position;
DESCRIBE INFORMATION_SCHEMA.PARAMETERS;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func1 (s char(20) RETURNS CHAR(50) RETURN CONCAT('Hello', ,s,'!');
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func1 (s char(20)) RETURNS CHAR(50) RETURN CONCAT('Hello, ',s,'!');
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func1';
DROP FUNCTION test_func1;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE PROCEDURE testproc (OUT param1 INT) BEGIN SELECT 2+2 as param1; END; ;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'testproc';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE PROCEDURE test_proc(INOUT P INT) SET @x=P*2;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_proc';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE PROCEDURE test_proc(OUT p VARCHAR(10)) SET P='test';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_proc';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func1 (s char(20), t char(20)) RETURNS CHAR(40) RETURN CONCAT(s,t);
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func1 (s char(20)) RETURNS CHAR(50) RETURN CONCAT('Hello, ',s,'!');
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func1';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func2 (s int) RETURNS INT RETURN s*2;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func2';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func5 (s date) RETURNS TIMESTAMP RETURN CURRENT_TIMESTAMP;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE FUNCTION test_func5 (s date) RETURNS TIMESTAMP RETURN CURRENT_TIMESTAMP;
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func5';
ALTER FUNCTION test_func5 COMMENT 'new comment added';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test CHARACTER SET  utf8;
USE i_s_parameters_test;
CREATE FUNCTION test_func5 (s CHAR(20)) RETURNS VARCHAR(30) RETURN CONCAT('XYZ, ' ,s);
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_SCHEMA = 'i_s_parameters_test' AND SPECIFIC_NAME = 'test_func5';
DROP DATABASE IF EXISTS i_s_parameters_test;
CREATE DATABASE i_s_parameters_test;
USE i_s_parameters_test;
CREATE PROCEDURE test_proc (OUT p_p1 datetime,OUT p_p2 time,OUT p_p3 timestamp) BEGIN SELECT 1 ; END; ;
CREATE PROCEDURE test_proc0 (OUT p_p1 datetime(0),OUT p_p2 time(0),OUT p_p3 timestamp(0)) BEGIN SELECT 1 ; END; ;
CREATE PROCEDURE test_proc1 (OUT p_p1 datetime(1),OUT p_p2 time(1),OUT p_p3 timestamp(1)) BEGIN SELECT 1 ; END; ;
CREATE PROCEDURE test_proc2 (OUT p_p1 datetime(2),OUT p_p2 time(2),OUT p_p3 timestamp(2)) BEGIN SELECT 1 ; END; ;
CREATE PROCEDURE test_proc5 (OUT p_p1 datetime(5),OUT p_p2 time(5),OUT p_p3 timestamp(5)) BEGIN SELECT 1 ; END; ;
CREATE FUNCTION test_func (f_p1 DATETIME, f_p2 TIMESTAMP) RETURNS TIME RETURN NULL;
CREATE FUNCTION test_func0 (f_p1 DATETIME(0), f_p2 TIMESTAMP(0)) RETURNS TIME(0) RETURN NULL;
CREATE FUNCTION test_func1 (f_p1 DATETIME(1), f_p2 TIMESTAMP(1)) RETURNS TIME(1) RETURN NULL;
CREATE FUNCTION test_func2 (f_p1 DATETIME(2), f_p2 TIMESTAMP(2)) RETURNS TIME(2) RETURN NULL;
CREATE FUNCTION test_func3 (f_p1 DATETIME(3), f_p2 TIMESTAMP(3)) RETURNS TIME(3) RETURN NULL;
CREATE FUNCTION test_func4 (f_p1 DATETIME(4), f_p2 TIMESTAMP(4)) RETURNS TIME(4) RETURN NULL;
CREATE FUNCTION test_func5 (f_p1 DATETIME(5), f_p2 TIMESTAMP(5)) RETURNS TIME(5) RETURN NULL;
CREATE FUNCTION test_func6 (f_p1 DATETIME(6), f_p2 TIMESTAMP(6)) RETURNS TIME(6) RETURN NULL;
SELECT SPECIFIC_SCHEMA, SPECIFIC_NAME, PARAMETER_NAME, DATA_TYPE,  DATETIME_PRECISION from INFORMATION_SCHEMA.PARAMETERS WHERE  SPECIFIC_SCHEMA='i_s_parameters_test' ORDER BY SPECIFIC_NAME,PARAMETER_NAME;
DROP DATABASE i_s_parameters_test;
