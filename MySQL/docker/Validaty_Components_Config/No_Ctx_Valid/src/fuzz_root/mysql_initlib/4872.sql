SET NAMES utf8;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,1), (1,4), (1,2), (1,4);
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t;
EXPLAIN FORMAT=TRADITIONAL SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) foo FROM t;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo DESC;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo DESC LIMIT 3;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) foo FROM t;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo DESC;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t;
EXPLAIN FORMAT=TRADITIONAL SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t;
CREATE VIEW v AS SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t;
SHOW CREATE VIEW v;
EXPLAIN FORMAT=JSON SELECT * FROM v;
DROP VIEW v;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t ORDER BY foo DESC;
TRUNCATE TABLE t;
INSERT INTO t VALUES (999961560, DEFAULT), (44721, DEFAULT);
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT SUM(i) OVER () FROM t;
DROP TABLE t;
CREATE TABLE t(i INT, j INT, k INT);
INSERT INTO t VALUES (1,1,1), (1,4,1), (1,2,1), (1,4,1);
INSERT INTO t VALUES (1,1,2), (1,4,2), (1,2,2), (1,4,2);
INSERT INTO t VALUES (1,1,3), (1,4,3), (1,2,3), (1,4,3);
INSERT INTO t VALUES (1,1,4), (1,4,4), (1,2,4), (1,4,4);
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT k, SUM(k) OVER (ROWS UNBOUNDED PRECEDING) wf FROM t;
EXPLAIN FORMAT=JSON SELECT k, MIN(i), SUM(j), SUM(k) OVER (ROWS UNBOUNDED PRECEDING) wf FROM t GROUP BY (k);
EXPLAIN FORMAT=JSON SELECT k, MIN(i), SUM(j), SUM(k) OVER (ROWS UNBOUNDED PRECEDING) wf FROM t GROUP BY (k) ORDER BY wf DESC;
EXPLAIN FORMAT=JSON SELECT k, GROUP_CONCAT(j ORDER BY j), SUM(k) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t GROUP BY (k);
EXPLAIN FORMAT=JSON SELECT k, AVG(DISTINCT j), SUM(k) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t GROUP BY (k);
EXPLAIN FORMAT=JSON SELECT k, GROUP_CONCAT(j ORDER BY j), SUM(k+1) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t GROUP BY (k);
EXPLAIN FORMAT=JSON SELECT k, GROUP_CONCAT(j ORDER BY j), SUM(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) foo FROM t GROUP BY (k);
DROP TABLE t;
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M'), (2, 'F'), (3, 'F'), (4, 'F'), (5, 'M');
ANALYZE TABLE t1;
CREATE TABLE t2 (user_id INTEGER NOT NULL, date DATE);
INSERT INTO t2 VALUES (1, '2002-06-09'), (2, '2002-06-09'), (1, '2002-06-09'), (3, '2002-06-09'), (4, '2002-06-09'), (4, '2002-06-09'), (5, '2002-06-09');
ANALYZE TABLE t2;
EXPLAIN FORMAT=JSON SELECT RANK() OVER (ORDER BY user_id) r FROM t2;
EXPLAIN FORMAT=JSON SELECT DENSE_RANK() OVER (ORDER BY user_id) r FROM t2;
EXPLAIN FORMAT=JSON SELECT sex, SUM(DISTINCT id) AS uids FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex ORDER BY uids;
EXPLAIN FORMAT=JSON SELECT id, sex, RANK() OVER (ORDER BY sex) FROM t1 ORDER BY id;
EXPLAIN FORMAT=JSON SELECT id, sex, DENSE_RANK() OVER (ORDER BY sex) FROM t1 ORDER BY id;
EXPLAIN FORMAT=JSON SELECT sex, RANK() OVER (ORDER BY sex DESC) `rank`, AVG(DISTINCT id) AS uids FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex ORDER BY sex;
EXPLAIN FORMAT=JSON SELECT  sex, AVG(id) AS uids, RANK() OVER w `rank` FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex WINDOW w AS (ORDER BY AVG(id));
EXPLAIN FORMAT=JSON SELECT  sex, AVG(DISTINCT id) AS uids, RANK() OVER w `rank` FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex WINDOW w AS (ORDER BY AVG(DISTINCT id) DESC) ORDER BY sex;
EXPLAIN FORMAT=JSON SELECT  sex, AVG(id) AS uids, RANK() OVER w `rank` FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex WINDOW w AS (ORDER BY AVG(id) DESC) ORDER BY `rank` DESC;
EXPLAIN FORMAT=TRADITIONAL SELECT  sex, AVG(id) AS uids, RANK() OVER w `rank` FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex WINDOW w AS (ORDER BY AVG(id) DESC) ORDER BY `rank` DESC;
INSERT INTO t1 VALUES (10, NULL), (11, NULL);
ANALYZE TABLE t1;
EXPLAIN FORMAT=JSON SELECT id, sex, RANK() OVER w, DENSE_RANK() OVER w FROM t1 WINDOW w AS (ORDER BY sex) ORDER BY id;
EXPLAIN FORMAT=JSON SELECT id, sex, RANK() OVER (ORDER BY sex DESC) FROM t1 ORDER BY id;
EXPLAIN FORMAT=JSON SELECT id value, SUM(id) OVER (ROWS UNBOUNDED PRECEDING) FROM t1 u, t2 WHERE t2.user_id = u.id;
EXPLAIN FORMAT=JSON SELECT AVG(id) average, SUM(AVG(id)) OVER (ROWS UNBOUNDED PRECEDING) FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex;
EXPLAIN FORMAT=JSON SELECT sex, AVG(id), RANK() OVER (ORDER BY AVG(id) DESC) FROM t1 GROUP BY sex ORDER BY sex;
EXPLAIN FORMAT=JSON SELECT sex, RANK() OVER (ORDER BY AVG(id) DESC) FROM t1 GROUP BY sex ORDER BY sex;
EXPLAIN FORMAT=JSON SELECT          RANK() OVER (ORDER BY AVG(id)) FROM t1;
EXPLAIN FORMAT=JSON SELECT AVG(id), RANK() OVER (ORDER BY AVG(id)) FROM t1;
EXPLAIN FORMAT=JSON SELECT AVG(id), SUM(AVG(id)) OVER (ORDER BY AVG(id) ROWS UNBOUNDED PRECEDING) FROM t1;
EXPLAIN FORMAT=JSON SELECT sex, id, RANK() OVER (PARTITION BY sex ORDER BY id DESC) FROM t1;
EXPLAIN FORMAT=JSON SELECT sex, id, RANK() OVER (PARTITION BY sex ORDER BY id ASC) FROM t1;
EXPLAIN FORMAT=JSON SELECT sex, id, SUM(id) OVER w summ, RANK() OVER w `rank` FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ASC ROWS UNBOUNDED PRECEDING);
EXPLAIN FORMAT=JSON SELECT sex, id, SUM(id) OVER w summ, RANK() OVER w `rank` FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ASC ROWS UNBOUNDED PRECEDING) ORDER BY summ;
CREATE TABLE t(d decimal(10,2), date DATE);
INSERT INTO t values  (10.4, '2002-06-09'), (20.5, '2002-06-09'), (10.4, '2002-06-10'), (3,    '2002-06-09'), (40.2, '2015-08-01'), (40.2, '2002-06-09'), (5,    '2015-08-01');
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT * FROM (SELECT  RANK() OVER (ORDER BY d) AS `rank`, d, date FROM t) alias ORDER BY `rank`, d, date;
EXPLAIN FORMAT=JSON SELECT * FROM (SELECT RANK() OVER (ORDER BY date) AS `rank`, date, d FROM t) alias ORDER BY `rank`, d DESC;
DROP TABLE t;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,NULL), (1,NULL), (1,1), (1,NULL), (1,2), (2,1), (2,2), (2,NULL), (2,NULL);
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT i, j, SUM(j) OVER (PARTITION BY i  ORDER BY j ROWS UNBOUNDED PRECEDING) FROM t;
EXPLAIN FORMAT=JSON SELECT SUM(id), SUM(SUM(id)) OVER (ORDER BY sex ROWS UNBOUNDED PRECEDING) FROM t1,t2 WHERE t1.id=t2.user_id GROUP BY sex;
EXPLAIN FORMAT=JSON SELECT RANK() OVER w FROM t1,t2 WHERE t1.id=t2.user_id WINDOW w AS (PARTITION BY id ORDER BY sex);
EXPLAIN FORMAT=JSON SELECT RANK() OVER w FROM (SELECT * FROM t1,t2 WHERE t1.id=t2.user_id) t WINDOW w AS (PARTITION BY id ORDER BY sex);
EXPLAIN FORMAT=JSON SELECT  SUM(id) OVER (PARTITION BY sex ORDER BY id ROWS UNBOUNDED PRECEDING) summ, sex FROM t1;
EXPLAIN FORMAT=JSON SELECT user_id, ROW_NUMBER() OVER (PARTITION BY user_id) FROM t2;
EXPLAIN FORMAT=JSON SELECT * FROM t1,t2 WHERE t1.id=t2.user_id;
EXPLAIN FORMAT=JSON SELECT sex, id, date, ROW_NUMBER() OVER w AS row_no, RANK() OVER w AS `rank` FROM t1,t2 WHERE t1.id=t2.user_id WINDOW w AS (PARTITION BY id ORDER BY sex);
EXPLAIN FORMAT=JSON SELECT sex, id, date, ROW_NUMBER() OVER w AS row_no, RANK() OVER w AS `rank` FROM t1,t2 WHERE t1.id=t2.user_id WINDOW w AS (PARTITION BY date ORDER BY id);
EXPLAIN FORMAT=JSON SELECT  date,id, RANK() OVER w AS `rank` FROM t1,t2 WINDOW w AS (PARTITION BY date ORDER BY id);
EXPLAIN FORMAT=JSON SELECT * from (SELECT  date,id, RANK() OVER w AS `rank` FROM t1,t2 WINDOW w AS (PARTITION BY date ORDER BY id)) t;
EXPLAIN FORMAT=JSON SELECT t.*, SUM(t.`rank`) OVER (ROWS UNBOUNDED PRECEDING) FROM (SELECT sex, id, date, ROW_NUMBER() OVER w AS row_no, RANK() OVER w AS `rank` FROM t1,t2 WHERE t1.id=t2.user_id WINDOW w AS (PARTITION BY date ORDER BY id) ) AS t;
EXPLAIN FORMAT=JSON SELECT t1.*, RANK() OVER (ORDER BY sex), SUM(id) OVER (ORDER BY sex,id ROWS UNBOUNDED PRECEDING) FROM t1;
EXPLAIN FORMAT=JSON SELECT * from (SELECT t1.*, SUM(id) OVER (ROWS UNBOUNDED PRECEDING), RANK() OVER (ORDER BY sex) FROM t1) alias ORDER BY id;
EXPLAIN FORMAT=JSON SELECT t1.*, SUM(id) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING), RANK() OVER (ORDER BY sex,id), ROW_NUMBER() OVER (ORDER BY sex,id) FROM t1;
EXPLAIN FORMAT=JSON SELECT t.*, SUM(id + r00 + r01) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) AS s FROM ( SELECT t1.*, RANK() OVER (ORDER BY sex) AS r00, RANK() OVER (ORDER BY sex DESC) AS r01, RANK() OVER (ORDER BY sex, id DESC) AS r02, RANK() OVER (PARTITION BY id ORDER BY sex) AS r03, RANK() OVER (ORDER BY sex) AS r04, RANK() OVER (ORDER BY sex) AS r05, RANK() OVER (ORDER BY sex) AS r06, RANK() OVER (ORDER BY sex) AS r07, RANK() OVER (ORDER BY sex) AS r08, RANK() OVER (ORDER BY sex) AS r09, RANK() OVER (ORDER BY sex) AS r10, RANK() OVER (ORDER BY sex) AS r11, RANK() OVER (ORDER BY sex) AS r12, RANK() OVER (ORDER BY sex) AS r13, RANK() OVER (ORDER BY sex) AS r14 FROM t1) t;
EXPLAIN FORMAT=JSON SELECT t.*, SUM(id + r00 + r01) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) AS s FROM ( SELECT t1.*, RANK() OVER (ORDER BY sex) AS r00, RANK() OVER (ORDER BY sex DESC) AS r01, RANK() OVER (ORDER BY sex, id DESC) AS r02, RANK() OVER (PARTITION BY id ORDER BY sex) AS r03, RANK() OVER (ORDER BY sex) AS r04, RANK() OVER (ORDER BY sex) AS r05, RANK() OVER (ORDER BY sex) AS r06, RANK() OVER (ORDER BY sex) AS r07, RANK() OVER (ORDER BY sex) AS r08, RANK() OVER (ORDER BY sex) AS r09, RANK() OVER (ORDER BY sex) AS r10, RANK() OVER (ORDER BY sex) AS r11, RANK() OVER (ORDER BY sex) AS r12, RANK() OVER (ORDER BY sex) AS r13, RANK() OVER (ORDER BY sex) AS r14 FROM t1 LIMIT 4) t;
EXPLAIN FORMAT=JSON SELECT SUM(id) OVER w * 2, AVG(id) OVER w, COUNT(id) OVER w FROM t1 WINDOW w AS (PARTITION BY sex);
EXPLAIN FORMAT=JSON SELECT * FROM ( SELECT id, SUM(id) OVER w, COUNT(*) OVER w, sex FROM t1 WINDOW w AS (PARTITION BY sex) ) alias ORDER BY id;
EXPLAIN FORMAT=JSON SELECT SUM(id) OVER w FROM t1 WINDOW w AS (PARTITION BY sex);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w, sex FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
CREATE VIEW v AS SELECT id, SUM(id) OVER w, sex FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SHOW CREATE VIEW v;
EXPLAIN FORMAT=JSON SELECT * FROM v;
DROP VIEW v;
EXPLAIN FORMAT=JSON SELECT SUM(id) OVER w FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w, sex FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT SUM(id) OVER w, COUNT(*) OVER w FROM t1 WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT id, AVG(id) OVER (ROWS UNBOUNDED PRECEDING) FROM t1;
EXPLAIN FORMAT=JSON SELECT id, AVG(id) OVER w, COUNT(id) OVER w FROM t1 WINDOW w AS (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
CREATE TABLE td(d DOUBLE);
INSERT INTO td VALUES (2),(2),(3),(1),(1.2),(NULL);
ANALYZE TABLE td;
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER (ORDER BY d), AVG(d) OVER (ORDER BY d) FROM td;
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER (ORDER BY d), AVG(d) OVER () FROM td;
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER (ORDER BY d), AVG(d) OVER (ORDER BY d ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) FROM td;
TRUNCATE td;
INSERT INTO td VALUES (1.7976931348623157E+307), (1);
ANALYZE TABLE td;
SHOW VARIABLES LIKE 'windowing_use_high_precision';
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER (ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) FROM td;
SET SESSION windowing_use_high_precision=FALSE;