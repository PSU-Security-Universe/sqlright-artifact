CREATE SCHEMA s1;
CREATE TABLE s1.t1(c1 INTEGER, c2 INTEGER, KEY k1(c1), KEY k2(c2));
INSERT INTO s1.t1 VALUES (1,10), (2,20), (3,30);
HANDLER s1.t1 OPEN;
HANDLER s1.t1 OPEN AS t1;
HANDLER t1 READ k1 FIRST;
HANDLER t1 READ k1=(1,10);
DROP TABLE s1.t1;
DROP SCHEMA s1;
