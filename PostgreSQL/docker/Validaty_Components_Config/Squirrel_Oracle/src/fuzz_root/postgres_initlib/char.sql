SELECT char 'c' = char 'c' AS true;
CREATE TABLE CHAR_TBL(f1 char);
INSERT INTO CHAR_TBL (f1) VALUES ('a');
INSERT INTO CHAR_TBL (f1) VALUES ('A');
INSERT INTO CHAR_TBL (f1) VALUES ('1');
INSERT INTO CHAR_TBL (f1) VALUES (2);
INSERT INTO CHAR_TBL (f1) VALUES ('3');
INSERT INTO CHAR_TBL (f1) VALUES ('');
INSERT INTO CHAR_TBL (f1) VALUES ('cd');
INSERT INTO CHAR_TBL (f1) VALUES ('c     ');
SELECT '' AS seven, * FROM CHAR_TBL;
SELECT '' AS six, c.*   FROM CHAR_TBL c   WHERE c.f1 <> 'a';
SELECT '' AS one, c.*   FROM CHAR_TBL c   WHERE c.f1 = 'a';
SELECT '' AS five, c.*   FROM CHAR_TBL c   WHERE c.f1 < 'a';
SELECT '' AS six, c.*   FROM CHAR_TBL c   WHERE c.f1 <= 'a';
SELECT '' AS one, c.*   FROM CHAR_TBL c   WHERE c.f1 > 'a';
SELECT '' AS two, c.*   FROM CHAR_TBL c   WHERE c.f1 >= 'a';
DROP TABLE CHAR_TBL;
CREATE TABLE CHAR_TBL(f1 char(4));
INSERT INTO CHAR_TBL (f1) VALUES ('a');
INSERT INTO CHAR_TBL (f1) VALUES ('ab');
INSERT INTO CHAR_TBL (f1) VALUES ('abcd');
INSERT INTO CHAR_TBL (f1) VALUES ('abcde');
INSERT INTO CHAR_TBL (f1) VALUES ('abcd    ');
SELECT '' AS four, * FROM CHAR_TBL;