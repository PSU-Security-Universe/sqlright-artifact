SELECT _utf8'abc';
SELECT n'abc';
SELECT CONVERT ( 'abc' USING utf8 );
SELECT CAST( 'abc' AS NATIONAL CHAR );
SELECT CAST( 'abc' AS NCHAR );
SELECT CAST('test' AS CHAR CHARACTER SET utf8);
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET utf8;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "utf8";
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'utf8';
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `utf8`;
CREATE TABLE t5 ( a NATIONAL CHAR(1) );
CREATE TABLE t6 ( a NCHAR(1) );
CREATE TABLE t7 ( a NCHAR );
CREATE TABLE t8 ( a NVARCHAR(1) );
DROP TABLE t1, t2, t3, t4, t5, t6, t7, t8;
CREATE FUNCTION f1 ( a CHAR(1) CHARACTER SET utf8 ) RETURNS INT RETURN 1;
CREATE FUNCTION f2 ( a CHAR(1) CHARACTER SET "utf8" ) RETURNS INT RETURN 1;
CREATE FUNCTION f3 ( a CHAR(1) CHARACTER SET 'utf8' ) RETURNS INT RETURN 1;
CREATE FUNCTION f4 ( a CHAR(1) CHARACTER SET `utf8` ) RETURNS INT RETURN 1;
CREATE FUNCTION f5 ( a NATIONAL CHAR(1) ) RETURNS INT RETURN 1;
CREATE FUNCTION f6 ( a NCHAR(1) ) RETURNS INT RETURN 1;
CREATE FUNCTION f7 ( a NCHAR ) RETURNS INT RETURN 1;
CREATE FUNCTION f8 ( a NVARCHAR(1) ) RETURNS INT RETURN 1;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP FUNCTION f4;
DROP FUNCTION f5;
DROP FUNCTION f6;
DROP FUNCTION f7;
DROP FUNCTION f8;
SELECT * FROM json_table('[]', '$[*]'   COLUMNS (p CHAR(1) CHARACTER SET utf8 PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'   COLUMNS (p CHAR(1) CHARACTER SET "utf8" PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'   COLUMNS (p CHAR(1) CHARACTER SET 'utf8' PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'   COLUMNS (p CHAR(1) CHARACTER SET `utf8` PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'   COLUMNS (p NATIONAL CHAR(1) PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NCHAR(1) PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NCHAR PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NVARCHAR(1) PATH '$.a')) AS t;
