## bug_chain for Loss of precision when comparing large INTEGER PRIMARY KEY with large REAL:

The bug can be triggered from the original seed with correct SELECT statement given. 

In total 3 mutations.

Query Source Seed:
```SQL
/* id:000002,orig:100.txt */
CREATE TABLE t1(a INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(4);
CREATE TABLE t2(b INTEGER PRIMARY KEY);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(2);
INSERT INTO t2 SELECT b+2 FROM t2;
INSERT INTO t2 SELECT b+4 FROM t2;
INSERT INTO t2 SELECT b+8 FROM t2;
INSERT INTO t2 SELECT b+16 FROM t2;
CREATE TABLE t3(c INTEGER PRIMARY KEY);
INSERT INTO t3 VALUES(1);
INSERT INTO t3 VALUES(2);
INSERT INTO t3 VALUES(3);
SELECT 'test-2', t3.c, ( SELECT count(*) FROM t1 JOIN (SELECT DISTINCT t3.c AS p FROM t2) AS x ON t1.a=x.p) FROM t3;
```

Mutation 1:
Line 4, changed one of the CREATE TABLE. CHECK(NULL).
```SQL
/* id:000318,src:000002,op:(null),pos:0 */
CREATE TABLE v0 ( c1 INTEGER PRIMARY KEY );
INSERT INTO v0 VALUES ( 18446744073709551488 );
INSERT INTO v0 VALUES ( 18446744073709551488 );
CREATE TABLE v2 ( c3 INTEGER CHECK( NULL ) );
INSERT INTO v2 VALUES ( 18446744073709551488 );
INSERT INTO v0 VALUES ( 18446744073709518848 );
INSERT INTO v2 SELECT c3 + 18446744073709551488 FROM v2 AS a4;
INSERT INTO v2 SELECT c3 + 18446744073709518848 FROM v2 AS a5;
INSERT INTO v0 SELECT c1 + 18446744073709551488 FROM v2 AS a6;
INSERT INTO v0 SELECT c1 + 18446744073709551488 FROM v0 AS a7;
CREATE TABLE v8 ( c9 INTEGER PRIMARY KEY );
INSERT INTO v8 VALUES ( 18446744073709551488 );
INSERT INTO v8 VALUES ( 18446744073709551615 );
INSERT INTO v0 VALUES ( 18446744073709551488 );
```

Mutation 2:
Line 12. One of the INSERT statement has been replaced as REPLACE statement
```SQL
/* id:003201,src:000318,op:(null),pos:0 */
CREATE TABLE v0 ( c1 INTEGER PRIMARY KEY );
INSERT INTO v0 VALUES ( 8 );
INSERT INTO v0 VALUES ( 255 );
CREATE TABLE v2 ( c3 INTEGER CHECK( NULL ) );
INSERT INTO v2 VALUES ( 0 );
INSERT INTO v0 VALUES ( 495 );
INSERT INTO v0 SELECT c1 + 495 FROM v0 AS a4;
INSERT INTO v0 SELECT c1 + 0 FROM v0 AS a5;
INSERT INTO v2 SELECT c3 + 495 FROM v2 AS a6;
INSERT INTO v2 SELECT c1 + 255 FROM v0 AS a7;
CREATE TABLE v8 ( c9 INTEGER PRIMARY KEY );
REPLACE INTO v2 VALUES ( 495 );
INSERT INTO v8 VALUES ( 0 );
INSERT INTO v0 VALUES ( 0 );
```

Bug Triggering Source, mutation 3:
Line 15: Added a SELECT statement
```SQL
/* id:004452,src:003201,op:(null),pos:0 */
CREATE TABLE v0 ( c1 INTEGER PRIMARY KEY );
INSERT INTO v0 VALUES ( 18446744073709551488 );
INSERT INTO v0 VALUES ( 0 );
CREATE TABLE v2 ( c3 INTEGER CHECK( NULL ) );
INSERT INTO v2 VALUES ( 0 );
INSERT INTO v0 VALUES ( 10 );
SELECT a4.c3 + 10 FROM v2 AS a4;
INSERT INTO v0 SELECT c1 + 0 FROM v2 AS a5;
INSERT INTO v2 SELECT c3 + 0 FROM v2 AS a6;
INSERT INTO v2 SELECT c3 + 0 FROM v2 AS a7;
CREATE TABLE v8 ( c9 INTEGER PRIMARY KEY );
REPLACE INTO v8 VALUES ( 127 );
INSERT INTO v8 VALUES ( 0 );
INSERT INTO v0 VALUES ( 10 );
WITH v10 ( c12 ) AS ( VALUES ( 10 ) UNION ALL SELECT c12 + 0 FROM v10 AS a13 WHERE c12 < 0 ORDER BY + c12 ) SELECT COUNT ( * ) FROM v10 AS a11 WHERE c12;
```

Bug Triggering Query:
```SQL
CREATE TABLE v0 ( c1 INTEGER PRIMARY KEY );
INSERT INTO v0 VALUES ( 9223372036854775807 );
INSERT INTO v0 VALUES ( 9223372036854775807 );
CREATE TABLE v2 ( c3 INTEGER CHECK( NULL ) );
INSERT INTO v2 VALUES ( 2147483647 );
INSERT INTO v2 VALUES ( 100 );
INSERT INTO v2 SELECT c3 + 9223372036854775807 FROM v2 AS a4;
INSERT INTO v0 SELECT c1 + 2147483647 FROM v0 AS a5;
INSERT INTO v0 SELECT c1 + 18446744073709551615 FROM v0 AS a6;
CREATE TABLE v7 ( c8 INTEGER PRIMARY KEY );
REPLACE INTO v0 ( c1, c1, c1, c1, c1, c1, c1, c1, c1, c1, c1 ) VALUES ( 18446744073709551615 );
INSERT INTO v7 VALUES ( 18446744073709551488 );
INSERT INTO v2 VALUES ( 18446744073709551615 );

SELECT COUNT ( * ) FROM v0 AS a137, v2 AS a138 WHERE a138.c3 <= a137.c1;
SELECT TOTAL ( ( CAST ( a138.c3 <= a137.c1 AS BOOL ) ) != 0 ) FROM v0 AS a137, v2 AS a138;
```
