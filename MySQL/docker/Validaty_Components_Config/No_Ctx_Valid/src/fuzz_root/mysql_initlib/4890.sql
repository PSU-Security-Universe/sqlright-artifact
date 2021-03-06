SET NAMES utf8;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,1);
INSERT INTO t VALUES (1,4);
INSERT INTO t VALUES (1,2);
INSERT INTO t VALUES (1,4);
ANALYZE TABLE t;
SELECT i, j, MIN(i) OVER (ROWS UNBOUNDED PRECEDING) min, MAX(j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT i, j, MIN(i) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) min, MAX(j) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max FROM t;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j;
SELECT i, j, MAX(i+j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min, MAX(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT i, j, MIN(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min, MAX(i) OVER (ORDER BY i ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j ;
SELECT i, j, MIN(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY NULL DESC;
EXPLAIN FORMAT=JSON SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY NULL DESC;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC LIMIT 3;
CREATE VIEW v AS SELECT i, j, MIN(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) min, MAX(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) max FROM t;
SHOW CREATE VIEW v;
SELECT * FROM v;
DROP VIEW v;
TRUNCATE TABLE t;
INSERT INTO t VALUES (999961560, DEFAULT);
INSERT INTO t VALUES (44721, DEFAULT);
SELECT MIN(i) OVER () FROM t;
SELECT MAX(i) OVER () FROM t;
DROP TABLE t;
CREATE TABLE t(i INT, j INT, k INT);
INSERT INTO t VALUES (1,1,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,2,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,1,2);
INSERT INTO t VALUES (1,4,2);
INSERT INTO t VALUES (1,2,2);
INSERT INTO t VALUES (1,4,2);
INSERT INTO t VALUES (1,1,3);
INSERT INTO t VALUES (1,4,3);
INSERT INTO t VALUES (1,2,3);
INSERT INTO t VALUES (1,4,3);
INSERT INTO t VALUES (1,1,4);
INSERT INTO t VALUES (1,4,4);
INSERT INTO t VALUES (1,2,4);
INSERT INTO t VALUES (1,4,4);
SELECT k, MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min, MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k);
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t GROUP BY (k);
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k) ORDER BY min_wf DESC;
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t GROUP BY (k) ORDER BY max_wf DESC;
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min, MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, AVG(DISTINCT j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min, MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k+1) OVER (ROWS UNBOUNDED PRECEDING) min FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MAX(k+1) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) min FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MAX(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M');
INSERT INTO t1 VALUES (2, 'F');
INSERT INTO t1 VALUES (3, 'F');
INSERT INTO t1 VALUES (4, 'F');
INSERT INTO t1 VALUES (5, 'M');
INSERT INTO t1 VALUES (10, NULL);
INSERT INTO t1 VALUES (11, NULL);
CREATE TABLE ss(c CHAR(1));
INSERT INTO ss VALUES ('M');
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max FROM t1 GROUP BY sex HAVING sex='M' OR sex='F' OR sex IS NULL WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max FROM t1 GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1 GROUP BY sex WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1 GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, NTILE(2) OVER w , MIN(ASCII(sex)) OVER w min, MAX(ASCII(sex)) OVER w max FROM t1 HAVING sex=(SELECT c FROM ss LIMIT 1) WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING);
PREPARE p FROM "SELECT sex, AVG(id), MIN(AVG(id)) OVER w min,         MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1     GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL     WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC";
EXECUTE p;
EXECUTE p;
DROP PREPARE p;
DROP TABLE t1,ss;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k) WITH ROLLUP;
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t GROUP BY (k) WITH ROLLUP;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k) WITH ROLLUP ORDER BY k DESC;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY k,j WITH ROLLUP;
DROP TABLE t;
CREATE TABLE t3(t3_id INT, k INT);
INSERT INTO t3 VALUES (0, 0);
INSERT INTO t3 VALUES (0, 0);
INSERT INTO t3 VALUES (2, 0);
INSERT INTO t3 VALUES (2, 0);
INSERT INTO t3 VALUES (4, 0);
INSERT INTO t3 VALUES (4, 0);
INSERT INTO t3 VALUES (6, 0);
INSERT INTO t3 VALUES (6, 0);
INSERT INTO t3 VALUES (8, 0);
INSERT INTO t3 VALUES (8, 0);
INSERT INTO t3 VALUES (1, 1);
INSERT INTO t3 VALUES (1, 1);
INSERT INTO t3 VALUES (3, 1);
INSERT INTO t3 VALUES (3, 1);
INSERT INTO t3 VALUES (5, 1);
INSERT INTO t3 VALUES (5, 1);
INSERT INTO t3 VALUES (7, 1);
INSERT INTO t3 VALUES (7, 1);
INSERT INTO t3 VALUES (9, 1);
INSERT INTO t3 VALUES (9, 1);
SELECT t3_id, MIN(t3_id) OVER w min, MAX(t3_id) OVER w max, CUME_DIST() OVER w c_dist, LEAD(t3_id, 2) OVER w lead2, NTH_VALUE(t3_id, 3) OVER w nth, k FROM t3 WINDOW w AS (PARTITION BY k ORDER BY t3_id);
SELECT t3_id, MIN(t3_id) OVER w min, MAX(t3_id) OVER w max, CUME_DIST() OVER w c_dist, LEAD(t3_id, 2) OVER w lead2, NTH_VALUE(t3_id, 3) OVER w nth, k FROM t3 WINDOW w AS (PARTITION BY k ORDER BY t3_id RANGE UNBOUNDED PRECEDING);
DROP TABLE t3;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,1);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,2);
INSERT INTO t VALUES (2,1);
INSERT INTO t VALUES (2,2);
INSERT INTO t VALUES (2,NULL);
INSERT INTO t VALUES (2,NULL);
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M');
