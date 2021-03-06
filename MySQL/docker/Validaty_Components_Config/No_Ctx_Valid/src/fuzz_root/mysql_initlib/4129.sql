set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;
CREATE ROLE r1;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
GRANT SELECT ON *.* TO r1;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t1;
REVOKE SELECT ON *.* FROM r1;
SET ROLE r1;
SHOW GRANTS FOR CURRENT_USER() USING r1;
SELECT * FROM db1.t1;
GRANT SELECT ON db1.* TO r1;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t1;
SET ROLE NONE;
SELECT * FROM db1.t1;
SET ROLE r1;
SELECT * FROM db1.t1;
REVOKE SELECT ON db1.* FROM r1;
SET ROLE r1;
SELECT * FROM db1.t1;
GRANT SELECT ON db1.t1 TO r1;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t2;
SELECT * FROM db1.t1;
REVOKE SELECT ON db1.t1 FROM r1;
SET ROLE r1;
SELECT * FROM db1.t1;
GRANT SELECT(c1) ON db1.t1 TO r1;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT c1 FROM db1.t2;
SELECT c2 FROM db1.t1;
SELECT c1 FROM db1.t1;
REVOKE SELECT(c1) ON db1.t1 FROM r1;
SET ROLE r1;
SELECT * FROM db1.t1;
DROP ROLE r1;
DROP DATABASE db1;
CREATE ROLE r1;
CREATE ROLE r2;
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t3 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t2 (c1 INT, c2 INT, c3 INT);
GRANT SELECT ON *.* TO r2;
GRANT SELECT ON db1.t2 TO r1 WITH GRANT OPTION;
GRANT r2 TO r1;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
REVOKE SELECT ON *.* FROM r2;
SET ROLE r1;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
GRANT SELECT ON db1.* TO r2;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;
SELECT * FROM db2.t1;
SELECT * FROM db2.t2;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
REVOKE SELECT ON db1.* FROM r2;
SET ROLE r1;
SELECT * FROM db1.t1;
GRANT SELECT ON db1.t1 TO r2;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t3;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
REVOKE SELECT ON db1.t1 FROM r2;
SET ROLE r1;
SELECT * FROM db1.t1;
GRANT SELECT(c1) ON db1.t1 TO r2;
SET ROLE r1;
UPDATE db1.t1 SET c1=2;
SELECT c1 FROM db1.t3;
SELECT c2 FROM db1.t1;
SELECT c1 FROM db1.t1;
SELECT * FROM db1.t2;
REVOKE SELECT(c1) ON db1.t1 FROM r2;
