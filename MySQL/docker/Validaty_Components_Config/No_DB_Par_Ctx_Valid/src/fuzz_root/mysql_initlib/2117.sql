CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
ANALYZE TABLE t1;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT * FROM t1 LIMIT 5) SELECT * FROM cte;
WITH cte AS (SELECT * FROM t1 LIMIT 5) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 5) SELECT * FROM cte;
WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 5) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 5) SELECT * FROM cte;
WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 5) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a+20 FROM t1 UNION DISTINCT SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
WITH cte AS (SELECT a+20 FROM t1 UNION DISTINCT SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 15) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte;
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT * FROM t1 LIMIT 5 OFFSET 1) SELECT * FROM cte;
WITH cte AS (SELECT * FROM t1 LIMIT 5 OFFSET 1) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte;
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte LIMIT 4 OFFSET 7;
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte LIMIT 4 OFFSET 7;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte LIMIT 2 OFFSET 7;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1) SELECT * FROM cte LIMIT 2 OFFSET 7;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte LIMIT 4;
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte LIMIT 4;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte LIMIT 2;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15) SELECT * FROM cte LIMIT 2;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8) SELECT /*+ no_bnl() */ * FROM cte cte1, cte cte2;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8) SELECT /*+ no_bnl() */ * FROM cte cte1, cte cte2;
EXPLAIN FORMAT=TREE WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8) SELECT /*+ no_bnl() */ * FROM cte cte1, (SELECT 100 UNION SELECT 101) dt;
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8) SELECT /*+ no_bnl() */ * FROM cte cte1, (SELECT 100 UNION SELECT 101) dt;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION DISTINCT SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION DISTINCT SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a FROM cte) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a FROM cte LIMIT 199999) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte LIMIT 1 OFFSET 2;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte LIMIT 1 OFFSET 2;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte LIMIT 1 OFFSET 2;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5 OFFSET 1) SELECT * FROM cte LIMIT 1 OFFSET 2;
EXPLAIN FORMAT=TREE WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte LIMIT 3;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5) SELECT * FROM cte LIMIT 3;
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 1.3) SELECT * FROM cte;
DROP TABLE t1;
