CREATE TABLE PKTABLE ( ptest1 int PRIMARY KEY, ptest2 text );
CREATE TABLE FKTABLE ( ftest1 int REFERENCES PKTABLE MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE, ftest2 int );
INSERT INTO PKTABLE VALUES (1, 'Test1');
INSERT INTO PKTABLE VALUES (2, 'Test2');
INSERT INTO PKTABLE VALUES (3, 'Test3');
INSERT INTO PKTABLE VALUES (4, 'Test4');
INSERT INTO PKTABLE VALUES (5, 'Test5');
INSERT INTO FKTABLE VALUES (1, 2);
INSERT INTO FKTABLE VALUES (2, 3);
INSERT INTO FKTABLE VALUES (3, 4);
INSERT INTO FKTABLE VALUES (NULL, 1);
INSERT INTO FKTABLE VALUES (100, 2);
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 text, PRIMARY KEY(ptest1, ptest2) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int, ftest3 int, CONSTRAINT constrname FOREIGN KEY(ftest1, ftest2) REFERENCES PKTABLE MATCH FULL ON DELETE SET NULL ON UPDATE SET NULL);
