SET windowing_use_high_precision= ON;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,1);
INSERT INTO t VALUES (1,4);
INSERT INTO t VALUES (1,2);
INSERT INTO t VALUES (1,4);
ANALYZE TABLE t;
SELECT i, j, STD(i) OVER (ROWS UNBOUNDED PRECEDING) std, VARIANCE(j) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t;
SELECT i, j, STD(i) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) std, VARIANCE(j) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) variance FROM t;
SELECT i, j, STD(i+j) OVER (ROWS UNBOUNDED PRECEDING) std FROM t ORDER BY std;
SELECT i, j, VAR_POP(i+j) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t ORDER BY variance;
SELECT i, j, STD(i+j) OVER (ROWS UNBOUNDED PRECEDING) std FROM t ORDER BY std DESC;
SELECT i, j, VARIANCE(i+j) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t ORDER BY variance DESC;
SELECT i, j, STD(i) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) std, VARIANCE(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) variance FROM t;
SELECT i, j, STDDEV_SAMP(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) std, VARIANCE(i) OVER (ORDER BY i ROWS UNBOUNDED PRECEDING) variance FROM t ORDER BY std ;
SELECT i, j, STD(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) std FROM t ORDER BY std DESC;
SELECT i, j, VAR_POP(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) variance FROM t ORDER BY variance DESC;
SELECT i, j, STDDEV_SAMP(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) std FROM t ORDER BY std DESC;
SELECT i, j, VARIANCE(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) variance FROM t ORDER BY variance DESC;
SELECT i, j, STD(i+j) OVER (ROWS UNBOUNDED PRECEDING) std FROM t ORDER BY NULL DESC;
EXPLAIN FORMAT=JSON SELECT i, j, std(i+j) OVER (ROWS UNBOUNDED PRECEDING) STD FROM t ORDER BY NULL DESC;
SELECT i, j, STD(i+j) OVER (ROWS UNBOUNDED PRECEDING) STD FROM t ORDER BY std DESC LIMIT 3;
CREATE VIEW v AS SELECT i, j, STD(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) STD, VARIANCE(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) variance FROM t;
SHOW CREATE VIEW v;
SELECT * FROM v;
DROP VIEW v;
TRUNCATE TABLE t;
INSERT INTO t VALUES (999961560, DEFAULT);
INSERT INTO t VALUES (44721, DEFAULT);
SELECT STD(i) OVER () FROM t;
SELECT VARIANCE(i) OVER () FROM t;
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
SELECT k, STD(k) OVER (ROWS UNBOUNDED PRECEDING) std, VARIANCE(k) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t;
SELECT k, STD(i), SUM(j), STD(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k);
SELECT k, STD(i), SUM(j), VAR_POP(k) OVER (ROWS UNBOUNDED PRECEDING) variance_wf FROM t GROUP BY (k);
SELECT k, STD(i), SUM(j), STD(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) ORDER BY std_wf DESC;
SELECT k, STD(i), SUM(j), STDDEV(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) ORDER BY std_wf DESC;
SELECT k, STD(i), SUM(j), STDDEV_POP(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) ORDER BY std_wf DESC;
SELECT k, STD(i), SUM(j), STDDEV_SAMP(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) ORDER BY std_wf DESC;
SELECT k, STD(i), SUM(j), VARIANCE(k) OVER (ROWS UNBOUNDED PRECEDING) variance_wf FROM t GROUP BY (k) ORDER BY variance_wf DESC;
SELECT k, STD(i), SUM(j), VAR_POP(k) OVER (ROWS UNBOUNDED PRECEDING) variance_wf FROM t GROUP BY (k) ORDER BY variance_wf DESC;
SELECT k, STD(i), SUM(j), VAR_SAMP(k) OVER (ROWS UNBOUNDED PRECEDING) variance_wf FROM t GROUP BY (k) ORDER BY variance_wf DESC;
SELECT k, GROUP_CONCAT(j ORDER BY j), STD(k) OVER (ROWS UNBOUNDED PRECEDING) std, VAR_SAMP(k) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t GROUP BY (k);
SELECT k, AVG(DISTINCT j), STD(k) OVER (ROWS UNBOUNDED PRECEDING) std, VARIANCE(k) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), STD(k+1) OVER (ROWS UNBOUNDED PRECEDING) std FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), VARIANCE(k+1) OVER (ROWS UNBOUNDED PRECEDING) variance FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), STD(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) std FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), VAR_POP(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) variance FROM t GROUP BY (k);
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
SELECT sex, AVG(id), std(AVG(id)) OVER w std, VARIANCE(AVG(id)) OVER w variance FROM t1 GROUP BY sex HAVING sex='M' OR sex='F' OR sex IS NULL WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), STD(AVG(id)) OVER w std, VARIANCE(AVG(id)) OVER w variance FROM t1 GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), STDDEV(AVG(id)) OVER w std, VAR_POP(AVG(id)) OVER w variance, NTILE(2) OVER w FROM t1 GROUP BY sex WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), STD(AVG(id)) OVER w std, VARIANCE(AVG(id)) OVER w variance, NTILE(2) OVER w FROM t1 GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, NTILE(2) OVER w , STDDEV_POP(ASCII(sex)) OVER w std, VARIANCE(ASCII(sex)) OVER w variance FROM t1 HAVING sex=(SELECT c FROM ss LIMIT 1) WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING);
PREPARE p FROM "SELECT sex, AVG(id), STD(AVG(id)) OVER w std,         VARIANCE(AVG(id)) OVER w variance, NTILE(2) OVER w FROM t1     GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL     WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC";
EXECUTE p;
EXECUTE p;
DROP PREPARE p;
DROP TABLE t1,ss;
SELECT k, STD(i), SUM(j), STDDEV_SAMP(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) WITH ROLLUP;
SELECT k, STD(i), SUM(j), VAR_SAMP(k) OVER (ROWS UNBOUNDED PRECEDING) variance_wf FROM t GROUP BY (k) WITH ROLLUP;
SELECT k, STD(i), SUM(j), STD(k) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY (k) WITH ROLLUP ORDER BY k DESC;
SELECT k, STD(i), SUM(j), STDDEV(k) OVER (ROWS UNBOUNDED PRECEDING) std_wf FROM t GROUP BY k,j WITH ROLLUP;
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
SELECT t3_id, STD(t3_id) OVER w std, VARIANCE(t3_id) OVER w variance, CUME_DIST() OVER w c_dist, LEAD(t3_id, 2) OVER w lead2, NTH_VALUE(t3_id, 3) OVER w nth, k FROM t3 WINDOW w AS (PARTITION BY k ORDER BY t3_id);
SELECT t3_id, STDDEV_SAMP(t3_id) OVER w std, VARIANCE(t3_id) OVER w variance, CUME_DIST() OVER w c_dist, LEAD(t3_id, 2) OVER w lead2, NTH_VALUE(t3_id, 3) OVER w nth, k FROM t3 WINDOW w AS (PARTITION BY k ORDER BY t3_id RANGE UNBOUNDED PRECEDING);
DROP TABLE t3;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,1);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,2);
INSERT INTO t VALUES (2,1);
