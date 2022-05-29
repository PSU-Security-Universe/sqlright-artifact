# Bug_chain for UNORDER_ALTER_TABLE

Bug is triggerred directly from the Seed inputs. With the correct SELECT statement, it is possible to trigger the bug directly from the seed. 

Source Seed. Buggy Query Source:
```SQL
CREATE TABLE t1(a INT PRIMARY KEY) WITHOUT ROWID;
INSERT INTO t1(a) VALUES(10);
ALTER TABLE t1 ADD COLUMN b INT;
SELECT * FROM t1 WHERE a=20 OR (a=10 AND b=10);
```

Bug Triggering Query, Mutation 1, change INT to CHAR. Line 1:
```SQL
CREATE TABLE v0 ( c1 CHAR(20) PRIMARY KEY ) WITHOUT ROWID;
INSERT INTO v0 ( c1 ) VALUES ( 8 );
ALTER TABLE v0 ADD COLUMN c2 INT;

SELECT COUNT ( * ) FROM v0 AS a22 WHERE a22.c2 = 127 AND a22.c2 = 127 AND a22.c1 = 'v1' OR a22.c2 = 127 AND a22.c1 = 8 OR a22.c2 = 8 AND a22.c2 = 127 AND a22.c1 = 0 AND a22.c2 = 300 = 'ValueB' || 'test-2' AND a22.c2 = 4294967295;

SELECT TOTAL ( ( CAST ( a22.c2 = 127 AND a22.c2 = 127 AND a22.c1 = 'v1' OR a22.c2 = 127 AND a22.c1 = 8 OR a22.c2 = 8 AND a22.c2 = 127 AND a22.c1 = 0 AND a22.c2 = 300 = 'ValueB' || 'test-2' AND a22.c2 = 4294967295 AS BOOL ) ) != 0 ) FROM v0 AS a22;
```