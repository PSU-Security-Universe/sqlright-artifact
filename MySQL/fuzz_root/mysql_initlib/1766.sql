SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
CREATE TABLE t1 (s1 INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1),(2);
COMMIT;
START TRANSACTION;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
COMMIT;
SET @@autocommit=0;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
SELECT @@transaction_isolation;
SELECT * FROM t1;
SELECT @@transaction_isolation;
INSERT INTO t1 VALUES (-1);
SELECT @@transaction_isolation;
COMMIT;
START TRANSACTION;
SELECT * FROM t1;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
INSERT INTO t1 VALUES (1000);
COMMIT;
SELECT * FROM t1;
COMMIT;
START TRANSACTION;
SELECT * FROM t1;
COMMIT;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
START TRANSACTION;
INSERT INTO t1 VALUES (1001);
COMMIT;
SELECT COUNT(*) FROM t1 WHERE s1 = 1001;
COMMIT AND CHAIN;
INSERT INTO t1 VALUES (1002);
COMMIT;
SELECT COUNT(*) FROM t1 WHERE s1 = 1002;
COMMIT;
SELECT * FROM t1;
DELETE FROM t1 WHERE s1 >= 1000;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
START TRANSACTION;
INSERT INTO t1 VALUES (1001);
COMMIT;
SELECT COUNT(*) FROM t1 WHERE s1 = 1001;
ROLLBACK AND CHAIN;
INSERT INTO t1 VALUES (1002);
COMMIT;
SELECT COUNT(*) FROM t1 WHERE s1 = 1002;
COMMIT;
SELECT * FROM t1;
DELETE FROM t1 WHERE s1 >= 1000;
COMMIT;
SET @@completion_type=1;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
START TRANSACTION;
INSERT INTO t1 VALUES (1001);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
COMMIT AND NO CHAIN;
INSERT INTO t1 VALUES (1002);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
INSERT INTO t1 VALUES (1003);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
COMMIT;
SELECT * FROM t1;
DELETE FROM t1 WHERE s1 >= 1000;
COMMIT AND NO CHAIN;
SET @@completion_type=0;
COMMIT;
SET @@completion_type=1;
COMMIT AND NO CHAIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
START TRANSACTION;
INSERT INTO t1 VALUES (1001);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
ROLLBACK AND NO CHAIN;
INSERT INTO t1 VALUES (1002);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
INSERT INTO t1 VALUES (1003);
COMMIT;
SELECT * FROM t1 WHERE s1 >= 1000;
COMMIT;
SELECT * FROM t1;
DELETE FROM t1 WHERE s1 >= 1000;
COMMIT AND NO CHAIN;
SET @@completion_type=0;
COMMIT;
SET TRANSACTION ISOLATION LEVEL	READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM t1;
INSERT INTO t1 VALUES (1000);
COMMIT;
SELECT * FROM t1;
COMMIT;
DELETE FROM t1 WHERE s1 >= 1000;
COMMIT;
SET @@completion_type=1;
COMMIT AND NO CHAIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
TRUNCATE TABLE t1;
INSERT INTO t1 VALUES (1000);
SELECT * FROM t1;
INSERT INTO t1 VALUES (1001);
COMMIT;
SELECT * FROM t1;
COMMIT AND NO CHAIN;
SET @@completion_type=0;
COMMIT AND NO CHAIN;
SET @@autocommit=1;
