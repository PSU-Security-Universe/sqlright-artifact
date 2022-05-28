DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 ( id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,  gender CHAR(1), name VARCHAR(20) );
SELECT SUM(DISTINCT LENGTH(name)) s1 FROM t1;
INSERT INTO t1 (gender, name) VALUES (NULL, NULL);
INSERT INTO t1 (gender, name) VALUES (NULL, NULL);
INSERT INTO t1 (gender, name) VALUES (NULL, NULL);
SELECT SUM(DISTINCT LENGTH(name)) s1 FROM t1;
INSERT INTO t1 (gender, name) VALUES ('F', 'Helen'), ('F', 'Anastasia'), ('F', 'Katherine'), ('F', 'Margo'), ('F', 'Magdalene'), ('F', 'Mary');
CREATE TABLE t2 SELECT name FROM t1;
SELECT (SELECT SUM(DISTINCT LENGTH(name)) FROM t1) FROM t2;
DROP TABLE t2;
INSERT INTO t1 (gender, name) VALUES ('F', 'Eva'), ('F', 'Sofia'), ('F', 'Sara'), ('F', 'Golda'), ('F', 'Toba'), ('F', 'Victory'), ('F', 'Faina'), ('F', 'Miriam'), ('F', 'Beki'), ('F', 'America'), ('F', 'Susan'), ('F', 'Glory'), ('F', 'Priscilla'), ('F', 'Rosmary'), ('F', 'Rose'), ('F', 'Margareth'), ('F', 'Elizabeth'), ('F', 'Meredith'), ('F', 'Julie'), ('F', 'Xenia'), ('F', 'Zena'), ('F', 'Olga'), ('F', 'Brunhilda'), ('F', 'Nataly'), ('F', 'Lara'), ('F', 'Svetlana'), ('F', 'Grethem'), ('F', 'Irene');
SELECT SUM(DISTINCT LENGTH(name)) s1, SUM(DISTINCT SUBSTRING(NAME, 1, 3)) s2, SUM(DISTINCT LENGTH(SUBSTRING(name, 1, 4))) s3 FROM t1;
SELECT SUM(DISTINCT LENGTH(g1.name)) s1, SUM(DISTINCT SUBSTRING(g2.name, 1, 3)) s2, SUM(DISTINCT LENGTH(SUBSTRING(g3.name, 1, 4))) s3 FROM t1 g1, t1 g2, t1 g3;
SELECT SUM(DISTINCT LENGTH(g1.name)) s1, SUM(DISTINCT SUBSTRING(g2.name, 1, 3)) s2, SUM(DISTINCT LENGTH(SUBSTRING(g3.name, 1, 4))) s3 FROM t1 g1, t1 g2, t1 g3 GROUP BY LENGTH(SUBSTRING(g3.name, 5, 10));
SELECT SQL_BUFFER_RESULT SUM(DISTINCT LENGTH(name)) s1, SUM(DISTINCT SUBSTRING(NAME, 1, 3)) s2, SUM(DISTINCT LENGTH(SUBSTRING(name, 1, 4))) s3 FROM t1;
SELECT SQL_BUFFER_RESULT SUM(DISTINCT LENGTH(g1.name)) s1, SUM(DISTINCT SUBSTRING(g2.name, 1, 3)) s2, SUM(DISTINCT LENGTH(SUBSTRING(g3.name, 1, 4))) s3 FROM t1 g1, t1 g2, t1 g3 GROUP BY LENGTH(SUBSTRING(g3.name, 5, 10));
SET @l=1;
UPDATE t1 SET name=CONCAT(name, @l:=@l+1);
SELECT SUM(DISTINCT RIGHT(name, 1)) FROM t1;
SELECT SUM(DISTINCT id) FROM t1;
SELECT SUM(DISTINCT id % 11) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 ( pk int(11) NOT NULL AUTO_INCREMENT, int_key int(11) DEFAULT NULL, PRIMARY KEY (pk), KEY int_key (int_key) );
INSERT INTO t1 VALUES (1,10);
CREATE TABLE t2 ( pk int(11) NOT NULL AUTO_INCREMENT, time_nokey time DEFAULT NULL, datetime_key time DEFAULT NULL, PRIMARY KEY (pk), KEY datetime_key (datetime_key) );
INSERT INTO t2 VALUES (1,'18:19:29',NOW());
SELECT * FROM t1 WHERE int_key IN ( SELECT SUM(DISTINCT pk) FROM t2 WHERE time_nokey = datetime_key );
SELECT * FROM t1 WHERE int_key IN ( SELECT AVG(DISTINCT pk) FROM t2 WHERE time_nokey = datetime_key );
drop table t1,t2;