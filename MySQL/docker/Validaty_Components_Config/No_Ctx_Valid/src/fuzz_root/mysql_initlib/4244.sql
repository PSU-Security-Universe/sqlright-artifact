SHOW GLOBAL VARIABLES WHERE Variable_name LIKE "abc";
SHOW GLOBAL VARIABLES LIKE "abc";
SHOW SESSION VARIABLES WHERE Variable_name LIKE "abc";
SHOW SESSION VARIABLES LIKE "abc";
SHOW VARIABLES WHERE Variable_name LIKE "abc";
SHOW VARIABLES LIKE "abc";
CREATE TABLE t1 (i INT);
SHOW DATABASES WHERE 0;
SHOW TABLES WHERE 0;
SHOW TRIGGERS WHERE 0;
SHOW EVENTS WHERE 0;
SHOW TABLE STATUS WHERE 0;
SHOW OPEN TABLES WHERE 0;
SHOW COLUMNS FROM t1 WHERE 0;
SHOW KEYS FROM t1 WHERE 0;
SHOW STATUS WHERE 0;
SHOW VARIABLES WHERE 0;
SHOW CHARACTER SET WHERE 0;
SHOW COLLATION WHERE 0;
SHOW PROCEDURE STATUS WHERE 0;
SHOW FUNCTION STATUS WHERE 0;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER, c INTEGER, d INTEGER);
SET @@sql_select_limit=1;
PREPARE stmt FROM "SHOW COLUMNS FROM t1";
EXECUTE stmt;
set @@sql_select_limit=2;
EXECUTE stmt;
set @@sql_select_limit=DEFAULT;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
DROP TABLE t1;