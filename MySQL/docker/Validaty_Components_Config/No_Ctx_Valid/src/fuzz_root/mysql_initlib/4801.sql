SELECT IS_USED_LOCK('test') IS NULL AS expect_1;
SELECT IS_FREE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test') IS NULL AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
SELECT GET_LOCK('test', 0) = 1 AS expect_1;
SELECT IS_USED_LOCK('test') = CONNECTION_ID() AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SET @aux = 35;
SELECT IS_USED_LOCK('test') = @aux AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT GET_LOCK('test', 0) = 0 expect_1;
SELECT RELEASE_LOCK('test') = 0 AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test') IS NULL;
SELECT GET_LOCK('test1',0);
SELECT GET_LOCK('test2',0);
SELECT IS_USED_LOCK('test1') = CONNECTION_ID() AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_LOCK('test1') = 1 AS expect_1;
SELECT IS_FREE_LOCK('test1') = 1 AS expect_1;
SELECT IS_FREE_LOCK('test2') = 0 AS expect_1;
SELECT RELEASE_LOCK('test2') = 1 AS expect_1;
SELECT GET_LOCK('test1',0);
SELECT GET_LOCK('test2',0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_FREE_LOCK('test1') AND IS_FREE_LOCK('test2') AS expect_1;
SELECT GET_LOCK('test1',0), GET_LOCK('test2',0);
SELECT IS_USED_LOCK('test1') = CONNECTION_ID() AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK('test1',0) FROM (SELECT 1 AS col1) AS my_tab WHERE GET_LOCK('test2',0) = 1;
SELECT IS_USED_LOCK('test1') = CONNECTION_ID() AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK(col1,0) FROM (SELECT 'test1' AS col1 UNION SELECT 'test2') AS my_tab;
SELECT IS_USED_LOCK('test1') = CONNECTION_ID() AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK('test', 0);
SELECT GET_LOCK('test', 0);
SELECT GET_LOCK('test', 0);
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test') IS NULL AS expect_1;
SELECT GET_LOCK('test', 0), GET_LOCK('test', 0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT GET_LOCK('test', 0);
SELECT GET_LOCK('test', 7200);
SET @aux = 36;
KILL QUERY @aux;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_USED_LOCK('test') <> CONNECTION_ID() AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT GET_LOCK('test', 7200), SLEEP(10);
SET @aux = 36;
KILL QUERY @aux;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_USED_LOCK('test') = CONNECTION_ID() AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test1', 0);
SELECT IS_FREE_LOCK('test1') = 0 AS expect_1;
SET @aux = 36;
KILL @aux;
SELECT IS_FREE_LOCK('test1') = 1 AS expect_1;
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test2', 0);
SELECT GET_LOCK('test1', 7200);
SELECT GET_LOCK('test2', 7200);
SELECT RELEASE_LOCK('test1');
SELECT RELEASE_LOCK('test2') + RELEASE_LOCK('test1') = 2 AS expect_1;
CREATE TABLE t1 (id INT);
SELECT GET_LOCK('test1', 0);
LOCK TABLE t1 WRITE;
SELECT GET_LOCK('test2', 0);
UNLOCK TABLES;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT GET_LOCK('test1', 0);
FLUSH TABLES WITH READ LOCK;
SELECT GET_LOCK('test2', 0);
UNLOCK TABLES;
SELECT (RELEASE_LOCK('test1') = 1) AND (RELEASE_LOCK('test3') IS NULL) AND (RELEASE_LOCK('test2') = 1) AS expect_1;
DELETE FROM t1;
BEGIN;
INSERT INTO t1 SET id = 1;
SELECT GET_LOCK('test1', 0);
COMMIT;
BEGIN;
INSERT INTO t1 SET id = 2;
SELECT GET_LOCK('test2', 0);
ROLLBACK;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT id FROM t1 ORDER BY id;
DELETE FROM t1;
SELECT GET_LOCK('test', 0);
BEGIN;
INSERT INTO t1 VALUES (1);
SELECT GET_LOCK('test', 7200);
RENAME TABLE t1 TO t2;
COMMIT;
RENAME TABLE t2 TO t1;
SELECT RELEASE_LOCK('test');
SELECT COUNT(*) = 1 AS expect_1 FROM t1 WHERE id = 1;
SELECT GET_LOCK('test', 0);
LOCK TABLE t1 WRITE;
SELECT GET_LOCK('test', 7200);
SELECT COUNT(*) FROM t1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test');
UNLOCK TABLES;
DELETE FROM t1;
CREATE TRIGGER trig_t1_ins BEFORE INSERT ON t1 FOR EACH ROW SET @aux = GET_LOCK(new.id,7200);
SELECT GET_LOCK(CAST(2 AS CHAR),0);
