SET NAMES utf8mb4;
CREATE TABLE t1 (d DOUBLE, id INT, sex CHAR(1), n INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(n));
INSERT INTO t1(d, id, sex) VALUES (1.0, 1, 'M'), (2.0, 2, 'F'), (3.0, 3, 'F'), (4.0, 4, 'F'), (5.0, 5, 'M'), (NULL, NULL, 'M'), (10.0, 10, NULL), (10.0, 10, NULL), (11.0, 11, NULL);
ANALYZE TABLE t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LEAD(id, 1) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LAG(id, 1) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LEAD(id, 0) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LEAD(id, 1, id) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LAG(id, 1, id) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT id, sex, LEAD(id, 0, 7) RESPECT NULLS OVER () FROM t1;
EXPLAIN FORMAT=JSON SELECT n, id, LEAD(id, 1, 3) OVER (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
EXPLAIN FORMAT=JSON SELECT n, id,  LAG(id, 0, n*n) OVER (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
EXPLAIN FORMAT=JSON SELECT n, id,  LAG(id, 1, n*n) OVER (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
EXPLAIN FORMAT=JSON SELECT n, id,  LEAD(id, 1, n*n) OVER (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
CREATE TABLE t (c1 CHAR(10) CHARACTER SET big5, i INT, c2 VARCHAR(10) CHARACTER SET euckr);
DROP TABLE t;
CREATE TABLE t (c1 CHAR(10) CHARACTER SET utf8mb4, i INT, c2 VARCHAR(10) CHARACTER SET latin1);
INSERT INTO t VALUES('A', 1, '1');
INSERT INTO t VALUES('A', 3, '3');
INSERT INTO t VALUES(x'F09F90AC' /* dolphin */, 5, null);
INSERT INTO t VALUES('A', 5, null);
INSERT INTO t VALUES(null, 10, '0');
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT c1, c2, LEAD(c1, 0, c2) OVER () l0 FROM t;
EXPLAIN FORMAT=JSON SELECT c1, c2, LEAD(c1, 1, c2) OVER () l1 FROM t;
EXPLAIN FORMAT=JSON SELECT c1, c2, LEAD(c2, 1, c1) OVER () l1 FROM t;
CREATE TABLE tt AS SELECT LEAD(c1, 0, c2) OVER () c FROM t;
CREATE TABLE ts AS SELECT LEAD(c2, 1, c1) OVER () c FROM t;
SHOW CREATE TABLE tt;
SHOW CREATE TABLE ts;
DROP TABLE t, tt, ts;
CREATE TABLE t (c1 VARCHAR(10), j1 JSON, g1 POINT, i1 INT, b1 BLOB, d1 DOUBLE, e1 DECIMAL(5,4), e2 DECIMAL(5,2));
INSERT INTO t VALUES (null, '[6]', ST_POINTFROMTEXT('POINT(6 6)'), 6, '6', 6.0, 10.0/3, 20.0/3), ('7', null ,   ST_POINTFROMTEXT('POINT(7 7)'), 7, '7', 7.0, 10.0/3, 20.0/3), ('8', '[8]' ,  null,                           7, '8', 8.0, 10.0/3, 20.0/3), ('9', '[9]' , ST_POINTFROMTEXT('POINT(9 9)'), null, '9', 9.0, 10.0/3, 20.0/3), ('0', '[0]' , ST_POINTFROMTEXT('POINT(0 0)'), 0, null, 0.0, 10.0/3, 20.0/3), ('1', '[1]' , ST_POINTFROMTEXT('POINT(1 1)'), 1, '1', null, 10.0/3, 20.0/3), ('2', '[2]' , ST_POINTFROMTEXT('POINT(2 2)'), 2, '2', 2.0, null, 20.0/3), ('3', '[3]' , ST_POINTFROMTEXT('POINT(3 3)'), 3, '3', 3.0, 10.0/3, null);
ANALYZE TABLE t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, j1) OVER () lcj, IFNULL(c1, j1) ifn_cj FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, g1) OVER () lcg, IFNULL(c1, g1) ifn_cg FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, i1) OVER () lci, IFNULL(c1, i1) ifn_ci FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, b1) OVER () lcb, IFNULL(c1, b1) ifn_cb FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, d1) OVER () lcd, IFNULL(c1, d1) ifn_cd FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, e1) OVER () lce1, IFNULL(c1, e1) ifn_ce1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(c1, 0, e2) OVER () lce2, IFNULL(c1, e2) ifn_ce2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, c1) OVER () ljc, IFNULL(j1, c1) ifn_jc FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, g1) OVER () ljg, IFNULL(j1, g1) ifn_jg FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, i1) OVER () lji, IFNULL(j1, i1) ifn_ji FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, b1) OVER () ljb, IFNULL(j1, b1) ifn_jb FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, d1) OVER () ljd, IFNULL(j1, d1) ifn_jd FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, e1) OVER () lje1, IFNULL(j1, e1) ifn_je1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(j1, 0, e2) OVER () lje2, IFNULL(j1, e2) ifn_je2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, c1) OVER () lgc, IFNULL(g1, c1) ifn_gc FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, j1) OVER () lgj, IFNULL(g1, j1) ifn_gj FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, i1) OVER () lgi, IFNULL(g1, i1) ifn_gi FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, b1) OVER () lgb, IFNULL(g1, b1) ifn_gb FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, d1) OVER () lgd, IFNULL(g1, d1) ifn_gd FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, e1) OVER () lge1, IFNULL(g1, e1) ifn_ge1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(g1, 0, e2) OVER () lge2, IFNULL(g1, e2) ifn_ge2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, c1) OVER () lic, IFNULL(i1, c1) ifn_ic FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, j1) OVER () lij, IFNULL(i1, j1) ifn_ij FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, g1) OVER () lig, IFNULL(i1, g1) ifn_ig FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, b1) OVER () lib, IFNULL(i1, b1) ifn_ib FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, d1) OVER () lid, IFNULL(i1, d1) ifn_id FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, e1) OVER () lie1, IFNULL(i1, e1) ifn_ie1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(i1, 0, e2) OVER () lie2, IFNULL(i1, e2) ifn_ie2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, c1) OVER () lbc, IFNULL(b1, c1) ifn_bc FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, j1) OVER () lbj, IFNULL(b1, j1) ifn_bj FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, g1) OVER () lbg, IFNULL(b1, g1) ifn_bg FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, i1) OVER () lbi, IFNULL(b1, i1) ifn_bi FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, d1) OVER () lbd, IFNULL(b1, d1) ifn_bd FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, e1) OVER () lbe1, IFNULL(b1, e1) ifn_be1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(b1, 0, e2) OVER () lbe2, IFNULL(b1, e2) ifn_be2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, c1) OVER () ldc, IFNULL(d1, c1) ifn_dc FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, j1) OVER () ldj, IFNULL(d1, j1) ifn_dj FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, g1) OVER () ldg, IFNULL(d1, g1) ifn_dg FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, i1) OVER () ldi, IFNULL(d1, i1) ifn_di FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, b1) OVER () ldd, IFNULL(d1, b1) ifn_db FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, e1) OVER () lde1, IFNULL(d1, e1) ifn_de1 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(d1, 0, e2) OVER () lde2, IFNULL(d1, e2) ifn_de2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, c1) OVER () le1c, IFNULL(e1, c1) ifn_e1c FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, j1) OVER () le1j, IFNULL(e1, j1) ifn_e1j FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, g1) OVER () le1g, IFNULL(e1, g1) ifn_e1g FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, i1) OVER () le1i, IFNULL(e1, i1) ifn_e1i FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, b1) OVER () le1d, IFNULL(e1, b1) ifn_e1d FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, d1) OVER () le1d, IFNULL(e1, d1) ifn_e1d FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e1, 0, e2) OVER () le1e2, IFNULL(e1, e2) ifn_e1e2 FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, c1) OVER () le2c, IFNULL(e2, c1) ifn_e2c FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, j1) OVER () le2j, IFNULL(e2, j1) ifn_e2j FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, g1) OVER () le2g, IFNULL(e2, g1) ifn_e2g FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, i1) OVER () le2i, IFNULL(e2, i1) ifn_e2i FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, b1) OVER () le2d, IFNULL(e2, b1) ifn_e2d FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, d1) OVER () le2d, IFNULL(e2, d1) ifn_e2d FROM t;
EXPLAIN FORMAT=JSON SELECT LEAD(e2, 0, e1) OVER () le2e1, IFNULL(e2, e1) ifn_e2e1 FROM t;
DROP TABLE t;
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, NTILE(3) OVER w `ntile`, LEAD(id, 1) OVER w le1, LAG(id, 1) OVER w la1, LEAD(id, 100) OVER w le100, LAG(id, 2, 777) OVER w la2 FROM t1 WINDOW w AS (ORDER BY id);
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth, LEAD(id, 1) OVER w le1, LAG(id, 1) OVER w la1, LEAD(id, 100) OVER w le100, LAG(id, 2, 777) OVER w la2 FROM t1 WINDOW w as (PARTITION BY sex);
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth, LEAD(id, 1) OVER w le1, LAG(id, 1) OVER w la1, LEAD(id, 100) OVER w le100, LAG(id, 2, 777) OVER w la2 FROM t1 WINDOW w as (PARTITION BY id);
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, LEAD(id, 1) OVER w le1, LAG(id, 1) OVER w la1, LEAD(id, 100) OVER w le100, LAG(id, 2, 777) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY ID ROWS UNBOUNDED PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY ID RANGE UNBOUNDED PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY d ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY d RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY d DESC ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY d DESC RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(d, 2) OVER w le2, LAG(d, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT id, sex, COUNT(*) OVER w cnt, NTILE(3) OVER w `ntile`, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, sex, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY id ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, sex, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY id RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id ROWS 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id RANGE 2 PRECEDING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
EXPLAIN FORMAT=JSON SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex, LEAD(id, 2) OVER w le2, LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY id DESC ROWS 2 PRECEDING);
