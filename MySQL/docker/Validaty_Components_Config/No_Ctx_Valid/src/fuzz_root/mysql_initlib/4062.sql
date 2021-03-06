CREATE USER u1, r1;
GRANT r1 TO u1;
RENAME USER u1 TO u11;
ALTER USER u1 DEFAULT ROLE ALL;
ALTER USER anything DEFAULT ROLE ALL;
ALTER USER u11 DEFAULT ROLE ALL;
DROP USER u11, r1;
CREATE ROLE r1;
CREATE ROLE r2;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (c1 INT);
GRANT SELECT ON db1.t1 TO r1;
GRANT INSERT ON *.* TO r2;
SHOW GRANTS;
RENAME USER r1 TO r2;
SELECT CURRENT_ROLE();
SET ROLE NONE;
SELECT * FROM db1.t1;
SET ROLE r1;
SELECT * FROM db1.t1;
SELECT CURRENT_USER(), CURRENT_ROLE();
SHOW GRANTS;
DROP ROLE r1;
DROP ROLE r2;
DROP DATABASE db1;
CREATE USER usr, role_usr;
RENAME USER role_usr to role_usr_test;
GRANT role_usr_test to usr;
RENAME USER role_usr_test to role_usr;
REVOKE role_usr_test from usr;
RENAME USER role_usr_test to role_usr;
DROP USER usr, role_usr;
CREATE USER usr, role_usr;
RENAME USER role_usr to role_usr_test;
GRANT role_usr_test to usr;
RENAME USER role_usr_test to role_usr;
DROP USER usr;
RENAME USER role_usr_test to role_usr;
DROP USER role_usr;
CREATE USER u5;
CREATE ROLE r1,r2,r3;
GRANT ALL ON test.* TO r2;
GRANT r1, r2, r3 TO u5;
ALTER USER u5 DEFAULT ROLE r2,r3;
RENAME USER u5 to u1;
SELECT current_role();
SET ROLE DEFAULT;
RENAME USER u1 to u2;
GRANT r3 TO u2;
ALTER USER u2 DEFAULT ROLE r1, r2, r3;
SELECT CURRENT_ROLE();
SET ROLE DEFAULT;
rename user r2 to r22;
REVOKE r2 FROM u2;
RENAME USER r2 to r22;
DROP ROLE r1,r22, r3;
DROP USER u2;
DROP USER u1;
CREATE USER u1;
CREATE ROLE r1,r2,r3;
GRANT r1 TO r2;
GRANT r2 TO r3;
GRANT r3 to u1;
DROP USER u1;
RENAME USER r3 to r33;
DROP ROLE r3;
DROP USER u1;
DROP ROLE r1, r2, r33;
CREATE USER u1;
CREATE ROLE r1,r2,r3;
GRANT r1 TO r2;
GRANT r2 TO r3;
GRANT r3 to u1;
REVOKE r3 FROM u1;
RENAME USER r3 to r33;
DROP ROLE r3;
DROP ROLE r1, r2, r33;
DROP USER u1;
