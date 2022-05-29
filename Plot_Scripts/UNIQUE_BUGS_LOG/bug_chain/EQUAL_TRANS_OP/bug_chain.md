# Bug_chain for EXIST (FALSE): Equivalence Transfer Optimization bug

The original seed, combined with the correct SELECT statement, we can trigger the bug. 
In total 2 mutations. 

Query Source Seed:
```SQL
/* id:000059,orig:alter_2.txt */
CREATE TABLE t4(a PRIMARY KEY, b, c);
CREATE TABLE aux.t4(a PRIMARY KEY, b, c);
CREATE INDEX i4 ON t4(b);
CREATE INDEX aux.i4 ON t4(b);
INSERT INTO t4 VALUES('main', 'main', 'main');
INSERT INTO aux.t4 VALUES('aux', 'aux', 'aux');
SELECT * FROM t4 WHERE a = 'main';
ALTER TABLE t4 RENAME TO t5;
SELECT * FROM t4 WHERE a = 'aux';
ALTER TABLE t3 RENAME TO sqlite_t3;
```

Mutation 1:
Removed one of the ALTER TABLE statement. Line 8 from previous query
```SQL
/* id:002023,src:000059,op:(null),pos:0 */
CREATE TABLE v0 ( c1 PRIMARY KEY, c2, c3 );
CREATE TABLE main . v4 ( c5 PRIMARY KEY, c6, c7 );
CREATE INDEX i8 ON v0 ( c1 );
CREATE INDEX main . i9 ON v0 ( c1 );
INSERT INTO v4 VALUES ( 'zyx', 'v1', '35c' );
INSERT INTO main . v0 VALUES ( 'x', 'xwvutsr', 'v1' );
ALTER TABLE v4 RENAME TO v10;
```


Buggy Query Source, Mutation 2:
The Create INDEX statement has been extended. Line 3
```SQL
/* id:007249,src:002023,op:(null),pos:0 */
CREATE TABLE v0 ( c1 PRIMARY KEY, c2, c3 );
CREATE TABLE main . v4 ( c5 PRIMARY KEY, c6, c7 );
CREATE INDEX i8 ON v4 ( CASE '%bach%' WHEN c6 THEN 0 WHEN 8 THEN 8 WHEN 'x' THEN 0 WHEN 2147483647 THEN c5 END, c5, c7 DESC, c5 );
CREATE INDEX main . i9 ON v0 ( c1 );
INSERT INTO v0 VALUES ( 'x', 'v1', '35.0' );
INSERT INTO main . v4 VALUES ( 'v1', 'jkl', '1' );
ALTER TABLE v0 RENAME TO v10;
```


Bug Triggering Query:
```SQL
CREATE TABLE v0 ( c1 PRIMARY KEY, c2, c3 );
CREATE TABLE main . v4 ( c5 PRIMARY KEY, c6, c7 ) WITHOUT ROWID;
CREATE INDEX i8 ON v0 ( CASE 'v0' WHEN c2 THEN 127 WHEN 0 THEN 18446744073709551488 WHEN '40000 400 1' THEN 4294967295 WHEN 18446744073709551488 THEN c2 END, c1, c3 DESC, c1 );
CREATE INDEX main . i9 ON v0 ( c2 );
INSERT INTO v0 VALUES ( 'v0', 'x', 'v0' );
INSERT INTO main . v4 VALUES ( '12b', 'v0', 'v1' );
ALTER TABLE v0 RENAME TO v10;

SELECT COUNT ( * ) FROM v10 AS a22, v4 AS a23, v10 AS a24 WHERE EXISTS ( SELECT * FROM v10 AS a25 WHERE a25.c2 = a22.c1 AND a25.c1 IS a22.c1 );
SELECT TOTAL ( ( CAST ( EXISTS ( SELECT * FROM v10 AS a25 WHERE a25.c2 = a22.c1 AND a25.c1 IS a22.c1 ) AS BOOL ) ) != 0 ) FROM v10 AS a22, v4 AS a23, v10 AS a24;
```
