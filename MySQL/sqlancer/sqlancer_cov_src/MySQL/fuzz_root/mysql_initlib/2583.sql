DROP TABLE IF EXISTS t5;
CREATE TABLE t5(c1  BIT(2) PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (0), (1), (2);
SELECT HEX(c1) FROM t5 ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 = b'1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 <=> b'1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 != b'1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 >= '1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 <= '1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 < '1' ORDER BY c1;
SELECT HEX(c1) FROM t5 WHERE c1 > '0' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 FLOAT(5,2) PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (95.95), (-10.10), (1), (0);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '10.10' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '1' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '1' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '0' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 TINYINT PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (95), (10),(11),(-8);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '10' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '10' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-8' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '10' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 SMALLINT PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (395), (-200), (100), (111);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '100' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '100' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '395' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '-200' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '100' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '111' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '111' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 MEDIUMINT PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (-8388607), (311),(215),(88608);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '311' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '311' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '215' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '88608' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-8388607' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '215' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '215' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 INT PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (-2147483647), (1011),(15),(9388607);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '9388607' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '9388607' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '15' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '1011' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-2147483647' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '15' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '15' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 BIGINT PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (-9223372036854775807), (12011),(500),(3372036854775808);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '-9223372036854775807' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '-9223372036854775807' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '12011' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '500' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '3372036854775808' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '12011' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '12011' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 DOUBLE(5,2) PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (95.95), (11.11),(5),(-908.92);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '5' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-908.92' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '-908.92' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 NUMERIC(5,2) PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (95.95), (11.11),(5),(-908.92);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '5' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-908.92' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '-908.92' ORDER BY c1;
DROP TABLE t5;
CREATE TABLE t5(c1 DECIMAL(5,2)  PRIMARY KEY) ENGINE = InnoDB;
INSERT INTO t5 VALUES (95.95), (11.11),(5),(-908.92);
SELECT c1 FROM t5 ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 = '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <=> '11.11' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 >= '5' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 <= '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 != '-908.92' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 < '95.95' ORDER BY c1;
SELECT c1 FROM t5 WHERE c1 > '-908.92' ORDER BY c1;
DROP TABLE t5;
