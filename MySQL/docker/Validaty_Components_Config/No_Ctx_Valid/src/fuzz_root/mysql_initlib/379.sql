CREATE TABLE t1(f1 INT CHECK (f1 < 10)) ENGINE = myisam;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD f2 INT, ALGORITHM=copy;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ALTER f1 SET DEFAULT 10, ALGORITHM=INPLACE;
SHOW CREATE TABLE t1;
DROP TABLE t1;
