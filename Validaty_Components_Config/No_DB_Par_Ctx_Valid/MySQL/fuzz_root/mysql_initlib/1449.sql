SET NAMES binary;
set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;
drop table if exists t1;
flush privileges;
flush privileges;
create user CUser@LOCALHOST;
grant select on test.* to CUser@LOCALHOST;
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'LOCALHOST';
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'localhost';
flush privileges;
DROP USER CUser@LOCALHOST;
create table t1 (a int);
grant select on test.t1 to CUser@LOCALHOST;
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'LOCALHOST';
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'localhost';
flush privileges;
DROP USER CUser@LOCALHOST;
grant select(a) on test.t1 to CUser@LOCALHOST;
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'LOCALHOST';
flush privileges;
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'CUser'@'localhost';
flush privileges;
DROP USER CUser@LOCALHOST;
drop table t1;
create user  CUser2@LOCALHOST;
grant select on test.* to CUser2@LOCALHOST;
flush privileges;
REVOKE SELECT ON test.* FROM 'CUser2'@'LOCALHOST';
flush privileges;
REVOKE SELECT ON test.* FROM 'CUser2'@'localhost';
flush privileges;
DROP USER CUser2@LOCALHOST;
CREATE DATABASE mysqltest_1;
CREATE TABLE mysqltest_1.t1 (a INT);
CREATE USER 'mysqltest1'@'%';
GRANT SELECT, UPDATE ON `mysqltest_1`.* TO 'mysqltest1'@'%';
REVOKE SELECT ON `mysqltest_1`.* FROM 'mysqltest1'@'%';
GRANT SELECT, UPDATE ON `mysqltest\_1`.* TO 'mysqltest1'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS;
SELECT * FROM mysqltest_1.t1;
DROP USER 'mysqltest1'@'%';
DROP DATABASE mysqltest_1;
CREATE DATABASE temp;
CREATE TABLE temp.t1(a INT, b VARCHAR(10));
INSERT INTO temp.t1 VALUES(1, 'name1');
INSERT INTO temp.t1 VALUES(2, 'name2');
INSERT INTO temp.t1 VALUES(3, 'name3');
CREATE USER 'user1'@'%';
RENAME USER 'user1'@'%' TO 'user2'@'%';
SHOW GRANTS FOR 'user2'@'%';
GRANT SELECT (a), INSERT (b) ON `temp`.`t1` TO 'user2'@'%';
SHOW GRANTS FOR 'user2'@'%';
SHOW GRANTS;
SELECT a FROM temp.t1;
SELECT b FROM temp.t1;
DROP USER 'user2'@'%';
DROP DATABASE temp;
set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;
SET GLOBAL partial_revokes = @orig_partial_revokes;
