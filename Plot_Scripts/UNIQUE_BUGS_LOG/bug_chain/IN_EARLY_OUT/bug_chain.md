## Bug chain for IN_EARLY_OUT

The bug can be triggered by the original seed with correct SELECT statement. 
Only 0/1 mutation added. And the mutation doesn't introduce valid changes for the query. 

The bug is triggering from rowid_0.txt source seed.

## First Case:

Source Seed. Buggy Query Source
```SQL
/* id:000124,orig:rowid_0.txt */
CREATE TABLE t1(a,b,c,d, PRIMARY KEY(c,a)) WITHOUT ROWID;
CREATE INDEX t1bd ON t1(b, d);
INSERT INTO t1 VALUES('journal','sherman','ammonia','helena');
INSERT INTO t1 VALUES('dynamic','juliet','flipper','command');
INSERT INTO t1 VALUES('journal','sherman','gamma','patriot');
INSERT INTO t1 VALUES('arctic','sleep','ammonia','helena');
SELECT *, '|' FROM t1 ORDER BY c, a;
SELECT *, '|' FROM t1 ORDER BY c, a;
UPDATE t1 SET a=1250 WHERE b='phone';
SELECT *, '|' FROM t1 ORDER BY b, d;
ANALYZE;
```

Bug Triggering Query:
```SQL
CREATE TABLE v0 ( c1, c2, c3, c4, PRIMARY KEY ( c1, c2 ) ) WITHOUT ROWID;
CREATE INDEX i5 ON v0 ( c1, c2 );
INSERT INTO v0 VALUES ( 'v1', 'x', '27 3 3', 'uvwxyzabc' );
INSERT INTO v0 VALUES ( 'v0', 'v0', 'v0', 'v1' );
INSERT INTO v0 VALUES ( 'v1', 'av2 c', 'x', 'v1' );
INSERT INTO v0 VALUES ( 'x', 'v1', 'v1', 'eee' );
UPDATE v0 SET c2 = 0 WHERE c3 = 'teacher';
ANALYZE;

SELECT COUNT ( * ) FROM v0 AS a8, v0 AS a9 WHERE a9.c1 IN ( SELECT a10.c4 FROM v0 AS a10 );
SELECT TOTAL ( ( CAST ( a9.c1 IN ( SELECT a10.c4 FROM v0 AS a10 ) AS BOOL ) ) != 0 ) FROM v0 AS a8, v0 AS a9;
```

## Second case
Source Seed:
```SQL
/* id:000124,orig:rowid_0.txt */
CREATE TABLE t1(a,b,c,d, PRIMARY KEY(c,a)) WITHOUT ROWID;
CREATE INDEX t1bd ON t1(b, d);
INSERT INTO t1 VALUES('journal','sherman','ammonia','helena');
INSERT INTO t1 VALUES('dynamic','juliet','flipper','command');
INSERT INTO t1 VALUES('journal','sherman','gamma','patriot');
INSERT INTO t1 VALUES('arctic','sleep','ammonia','helena');
SELECT *, '|' FROM t1 ORDER BY c, a;
SELECT *, '|' FROM t1 ORDER BY c, a;
UPDATE t1 SET a=1250 WHERE b='phone';
SELECT *, '|' FROM t1 ORDER BY b, d;
ANALYZE;
SELECT * FROM sqlite_stat1 ORDER BY idx;
SELECT DISTINCT tbl, idx FROM sqlite_stat4 ORDER BY idx;
```

Bug Triggering Source, Mutation 1:
Just remove the SELECT statements, no valid mutation changes. 
```SQL
/* id:002821,src:000124,op:(null),pos:0,+cov */
CREATE TABLE v0 ( c1, c2, c3, c4, PRIMARY KEY ( c3, c4 ) ) WITHOUT ROWID;
CREATE INDEX i5 ON v0 ( c4, c1 );
INSERT INTO v0 VALUES ( 'v1', '1993-07-01', 'v1', 'v0' );
INSERT INTO v0 VALUES ( 'x', 'v1', 'x', 'v0' );
INSERT INTO v0 VALUES ( 'Thomas Tallis', '23', 'v1', 'v0' );
INSERT INTO v0 VALUES ( 'v1', 'y', 'v0', 'v1' );
UPDATE v0 SET c2 = 0 WHERE c4 = 'v0';
ANALYZE;
WITH v6 ( c8 ) AS ( VALUES ( 385 ) UNION SELECT c8 + 0 FROM v6 AS a9 WHERE c8 < tointeger ( c8 ) ) SELECT COUNT ( * ) FROM v6 AS a7 WHERE c8;
```

Bug Triggering Query:
```SQL
CREATE TABLE v0 ( c1, c2, c3, c4, PRIMARY KEY ( c3, c1 ) ) WITHOUT ROWID;
CREATE INDEX i5 ON v0 ( c4, c3 );
INSERT INTO v0 VALUES ( 'x', 'x', 'v1', 'This is a test' );
INSERT INTO v0 VALUES ( 'v0', 'v1', 'v0', 'x' );
INSERT INTO v0 VALUES ( 'x', 've', 'f', 'world' );
INSERT INTO v0 VALUES ( 'id.2', 'v0', 'aux', 'patriot' );
UPDATE v0 SET c3 = 18446744073709551488 WHERE c3 = 'v0';
ANALYZE;
SELECT COUNT ( * ) FROM v0 AS a117, v0 AS a118, v0 AS a119 WHERE a118.c3 IN ( SELECT a119.c2 + 18446744073709551488 FROM ( SELECT DISTINCT a117.c3 / ( a119.c3 * a119.c2 ) AS y ) AS y );
SELECT TOTAL ( ( CAST ( a118.c3 IN ( SELECT a119.c2 + 18446744073709551488 FROM ( SELECT DISTINCT a117.c3 / ( a119.c3 * a119.c2 ) AS y ) AS y ) AS BOOL ) ) != 0 ) FROM v0 AS a117, v0 AS a118, v0 AS a119;
```
