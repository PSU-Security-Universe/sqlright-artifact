CREATE TABLE tbl_int (col1 INT);
INSERT INTO tbl_int VALUES (1), (2), (3), (4), (5), (6), (7), (8), (NULL), (NULL);
ANALYZE TABLE tbl_int;
ANALYZE TABLE tbl_int UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
EXPLAIN SELECT * FROM tbl_int WHERE col1 > 0;
EXPLAIN SELECT * FROM tbl_int WHERE 0 < col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 > 8;
EXPLAIN SELECT * FROM tbl_int WHERE 8 < col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 < 10;
EXPLAIN SELECT * FROM tbl_int WHERE 10 > col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 >= 6;
EXPLAIN SELECT * FROM tbl_int WHERE 6 <= col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 >= -100;
EXPLAIN SELECT * FROM tbl_int WHERE -100 <= col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 != 8;
EXPLAIN SELECT * FROM tbl_int WHERE 8 != col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 <> 8;
EXPLAIN SELECT * FROM tbl_int WHERE 8 <> col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 = 100;
EXPLAIN SELECT * FROM tbl_int WHERE 100 = col1;
EXPLAIN SELECT * FROM tbl_int WHERE col1 IS NULL;
EXPLAIN SELECT * FROM tbl_int WHERE col1 IS NOT NULL;
EXPLAIN SELECT * FROM tbl_int WHERE col1 BETWEEN 1 AND 3;
EXPLAIN SELECT * FROM tbl_int WHERE col1 NOT BETWEEN 1 AND 3;
EXPLAIN SELECT * FROM tbl_int WHERE col1 IN (1, 3, 4, 5, 6, 7);
EXPLAIN SELECT * FROM tbl_int WHERE col1 NOT IN (1, 3, 4, 5, 6, 7);
DROP TABLE tbl_int;
CREATE TABLE tbl_varchar (col1 VARCHAR(255));
INSERT INTO tbl_varchar VALUES ("abcd"), ("🍣"), ("🍺"), ("eeeeeeeeee"), ("ef"), ("AG"), ("a very long string that is longer than 42 characters"), ("lorem ipsum"), (NULL), (NULL);
ANALYZE TABLE tbl_varchar UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
ANALYZE TABLE tbl_varchar;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 > "b";
EXPLAIN SELECT * FROM tbl_varchar WHERE "b" < col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 > "lp";
EXPLAIN SELECT * FROM tbl_varchar WHERE "lp" < col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 < "sierra";
EXPLAIN SELECT * FROM tbl_varchar WHERE "sierra" > col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 >= "abcd";
EXPLAIN SELECT * FROM tbl_varchar WHERE "abcd" <= col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 >= "";
EXPLAIN SELECT * FROM tbl_varchar WHERE "" <= col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 != "lorem ipsum";
EXPLAIN SELECT * FROM tbl_varchar WHERE "lorem ipsum" != col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 <> "lorem ipsum";
EXPLAIN SELECT * FROM tbl_varchar WHERE "lorem ipsum" <> col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 = "sierra";
EXPLAIN SELECT * FROM tbl_varchar WHERE "sierra" = col1;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 IS NULL;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 IS NOT NULL;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 BETWEEN "a" AND "b";
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 NOT BETWEEN "a" AND "b";
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 IN ("ag", "ef", "🍣");
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 NOT IN ("ag", "ef", "🍣");
DROP TABLE tbl_varchar;
CREATE TABLE tbl_varchar (col1 VARCHAR(255));
INSERT INTO tbl_varchar VALUES #   |------------ 42 characters -------------| ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnop"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnoq"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnor"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnos"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopp"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnopq"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnoss"), ("abcdefghijklmnopqrstuvwxyzabcdefghijklmnost");
ANALYZE TABLE tbl_varchar UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
ANALYZE TABLE tbl_varchar;
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 < "abcdefghijklmnopqrstuvwxyzabcdefghijklmnos";
EXPLAIN SELECT * FROM tbl_varchar WHERE col1 < "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopr";
DROP TABLE tbl_varchar;
CREATE TABLE tbl_double (col1 DOUBLE);
INSERT INTO tbl_double VALUES (-1.1), (0.0), (1.1), (2.2), (3.3), (4.4), (5.5), (6.6), (NULL), (NULL);
ANALYZE TABLE tbl_double UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
ANALYZE TABLE tbl_double;
EXPLAIN SELECT * FROM tbl_double WHERE col1 > 0.0e0;
EXPLAIN SELECT * FROM tbl_double WHERE 0.0e0 < col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 > 6.6e0;
EXPLAIN SELECT * FROM tbl_double WHERE 6.6e0 < col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 < 100.0;
EXPLAIN SELECT * FROM tbl_double WHERE 100.0 > col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 >= 3.3e0;
EXPLAIN SELECT * FROM tbl_double WHERE 3.3e0 <= col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 >= -2.0e0;
EXPLAIN SELECT * FROM tbl_double WHERE -2.0e0 <= col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 != 0.0e0;
EXPLAIN SELECT * FROM tbl_double WHERE 0.0e0 != col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 <> 0.0e0;
EXPLAIN SELECT * FROM tbl_double WHERE 0.0e0 <> col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 = 100.0;
EXPLAIN SELECT * FROM tbl_double WHERE 100.0 = col1;
EXPLAIN SELECT * FROM tbl_double WHERE col1 IS NULL;
EXPLAIN SELECT * FROM tbl_double WHERE col1 IS NOT NULL;
EXPLAIN SELECT * FROM tbl_double WHERE col1 BETWEEN 1.1e0 AND 3.3e0;
EXPLAIN SELECT * FROM tbl_double WHERE col1 NOT BETWEEN 1.1e0 AND 3.3e0;
EXPLAIN SELECT * FROM tbl_double WHERE col1 IN (-1.1e0, 0.0e0, 1.1e0, 2.2e0);
EXPLAIN SELECT * FROM tbl_double WHERE col1 NOT IN (-1.1e0, 0.0e0, 1.1e0, 2.2e0);
DROP TABLE tbl_double;
CREATE TABLE tbl_time (col1 TIME);
INSERT INTO tbl_time VALUES ("-01:00:00"), ("00:00:00"), ("00:00:01"), ("00:01:00"), ("01:00:00"), ("01:01:00"), ("02:00:00"), ("03:00:00"), (NULL), (NULL);
ANALYZE TABLE tbl_time UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
ANALYZE TABLE tbl_time;
EXPLAIN SELECT * FROM tbl_time WHERE col1 > "00:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE "00:00:00" < col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 > "03:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE "03:00:00" < col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 < "10:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE "10:00:00" > col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 >= "00:00:01";
EXPLAIN SELECT * FROM tbl_time WHERE "00:00:01" <= col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 >= "-01:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE "-01:00:00" <= col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 != "01:01:00";
EXPLAIN SELECT * FROM tbl_time WHERE "01:01:00" != col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 <> "01:01:00";
EXPLAIN SELECT * FROM tbl_time WHERE "01:01:00" <> col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 = "10:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE "10:00:00" = col1;
EXPLAIN SELECT * FROM tbl_time WHERE col1 IS NULL;
EXPLAIN SELECT * FROM tbl_time WHERE col1 IS NOT NULL;
EXPLAIN SELECT * FROM tbl_time WHERE col1 BETWEEN "00:00:01" AND "02:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE col1 NOT BETWEEN "00:00:01" AND "02:00:00";
EXPLAIN SELECT * FROM tbl_time WHERE col1 IN ("-01:00:00", "00:00:00", "03:00:00");
EXPLAIN SELECT * FROM tbl_time WHERE col1 NOT IN ("-01:00:00", "00:00:00", "03:00:00");
DROP TABLE tbl_time;
CREATE TABLE tbl_time (col1 TIME(6));
INSERT INTO tbl_time VALUES ("00:00:00.000000"), ("00:00:00.000001"), ("00:00:00.000002"), ("00:00:00.000003"), ("00:00:00.000004"), ("00:00:00.000005");
ANALYZE TABLE tbl_time UPDATE HISTOGRAM ON col1 WITH 2 BUCKETS;
ANALYZE TABLE tbl_time;
EXPLAIN SELECT * FROM tbl_time WHERE col1 < "00:00:00.000004";
DROP TABLE tbl_time;
CREATE TABLE tbl_date (col1 DATE);
