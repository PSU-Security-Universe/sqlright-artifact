CREATE TABLE t1 (a INT);
CREATE USER 'testuser1'@'localhost';
GRANT all ON *.* TO 'testuser1'@'localhost';
SET lock_wait_timeout= 1;
SET autocommit= 0;
LOCK INSTANCE FOR BACKUP;
CREATE DATABASE testdb;
CREATE TABLESPACE testtablespace ADD DATAFILE 'ts.ibd' ENGINE=InnoDB;
CREATE TABLE testtable_1 (c1 int, c2 varchar(10));
CREATE VIEW testview_1 AS SELECT c2 FROM testtable_1;
CREATE INDEX testindex_1 ON testtable_1(c1);
CREATE SERVER s FOREIGN DATA WRAPPER mysql OPTIONS (DATABASE 'test');
CREATE PROCEDURE testproc_1() BEGIN SELECT * FROM testtable_1; END;
CREATE EVENT testevent_1 ON SCHEDULE EVERY 10 SECOND DO SELECT 1;
CREATE TRIGGER testtrigger_1 BEFORE INSERT ON testtable_1 FOR EACH ROW SET @a:=1;
INSERT INTO t1 VALUES(1),(2),(3);
CREATE TEMPORARY TABLE temptable_1 (tt1 int);
INSERT INTO temptable_1 SELECT * FROM t1;
SELECT * FROM temptable_1;
CREATE RESOURCE GROUP rg1 TYPE=USER;
UNLOCK INSTANCE;
CREATE DATABASE testdb;
CREATE TABLESPACE testtablespace ADD DATAFILE 'ts.ibd' ENGINE=InnoDB;
CREATE TABLE testtable_1 (c1 int, c2 varchar(10)) TABLESPACE testtablespace;
CREATE TABLE testtable_3 (c1 int, c2 varchar(10)) PARTITION BY RANGE (c1)( PARTITION p0 VALUES LESS THAN (10), PARTITION p2 VALUES LESS THAN (100), PARTITION p3 VALUES LESS THAN (1000));
INSERT testtable_3 VALUES (1,'a'),(11,'b'),(101,'c');
ALTER TABLE testtable_3 ADD PARTITION (PARTITION p4 VALUES LESS THAN (5000));
CREATE VIEW testview_1 AS SELECT c2 FROM testtable_1;
CREATE INDEX testindex_1 ON testtable_1(c1);
CREATE PROCEDURE testproc_1() BEGIN SELECT * FROM testtable_1; END;
CREATE EVENT testevent_1 ON SCHEDULE EVERY 10 SECOND DO SELECT 1;
CREATE TRIGGER testtrigger_1 BEFORE INSERT ON testtable_1 FOR EACH ROW SET @a:=1;
CREATE SERVER s FOREIGN DATA WRAPPER mysql OPTIONS (DATABASE 'test');
LOCK INSTANCE FOR BACKUP;
LOCK INSTANCE FOR BACKUP;
INSERT INTO testtable_1 VALUES(1,'aaa'),(2,'bbbbbb'),(3,'cccccccc');
INSERT INTO testtable_1 VALUES(4,'ddd'),(5,'eeeee'),(3,'fffffff');
UPDATE testtable_1 SET c1=11, c2='yyy' WHERE c1=1;
DELETE FROM testtable_1 WHERE c2 LIKE "aa";
call testproc_1;
INSERT testtable_3 VALUES (4999,'aa');
ALTER DATABASE testdb CHARACTER SET 'latin1';
ALTER TABLE testtable_1 ADD INDEX i2(c2);
ALTER VIEW testview_1 AS SELECT c1 FROM testtable_1;
ALTER PROCEDURE testproc_1 COMMENT 'procedure';
ALTER EVENT testevent_1 ON SCHEDULE EVERY 100 SECOND DO SELECT 1;
ALTER SERVER s OPTIONS (USER 'sally');
ALTER TABLE testtable_1 ALGORITHM=INPLACE, ADD COLUMN c3 VARCHAR(255);
ALTER TABLE testtable_3 ADD PARTITION (PARTITION p5 VALUES LESS THAN (10000));
UNLOCK INSTANCE;
UNLOCK INSTANCE;
ALTER DATABASE testdb CHARACTER SET 'latin1';
ALTER TABLE testtable_1 ADD INDEX i2(c2);
ALTER VIEW testview_1 AS SELECT c1 FROM testtable_1;
ALTER PROCEDURE testproc_1 COMMENT 'procedure';
ALTER EVENT testevent_1 ON SCHEDULE EVERY 100 SECOND DO SELECT 1;
ALTER SERVER s OPTIONS (USER 'sally');
ALTER TABLE testtable_1 ALGORITHM=INPLACE, ADD COLUMN c3 VARCHAR(255);
ALTER TABLE testtable_3 ADD PARTITION (PARTITION p5 VALUES LESS THAN (10000));
INSERT testtable_3 VALUES (9999,'aa');
DROP DATABASE testdb;
DROP TABLE testtable_1;
DROP TABLE testtable_3;
DROP VIEW testview_1;
DROP TABLESPACE testtablespace;
DROP PROCEDURE testproc_1;
DROP EVENT testevent_1;
DROP SERVER s;
LOCK INSTANCE FOR BACKUP;
CREATE TABLE t2 (c1 int);
DROP USER 'testuser1'@'localhost';
DROP TABLE t1, t2;
