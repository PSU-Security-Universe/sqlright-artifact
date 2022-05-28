CREATE TABLE t1 ( col_varchar_1024_utf8_key varchar(1024), pk int, col_int_key int, col_int int, PRIMARY KEY (pk), KEY col_varchar_1024_utf8_key (col_varchar_1024_utf8_key(333)), KEY col_int_key (col_int_key) ) charset latin1;
INSERT INTO t1 VALUES ('pvg',1,5,773586944),('akl',2,NULL,NULL),('from',3,NULL,8), ('qmx',4,4,-693436416),('p',5,3,5),('want',6,-34930688,-1647247360), ('q',19,6,-805896192),('kov',20,7,NULL),('d',21,NULL,1752498176);
OPTIMIZE TABLE t1;
CREATE TABLE t2 ( col_varchar_1024_utf8_key varchar(1024), col_int int, col_int_key int, pk int, PRIMARY KEY (pk), KEY col_varchar_1024_utf8_key (col_varchar_1024_utf8_key(255)), KEY col_int_key (col_int_key) ) charset latin1;
INSERT INTO t2 VALUES ('he',1,NULL,1),('y',551288832,NULL,2),('uac',NULL,166789120,3), ('jhu',-1002176512,NULL,4),('t',NULL,5,5),('z',1017970688,NULL,6), ('jnp',8,NULL,7),('up',-1243742208,-857014272,8),('q',8,NULL,9), ('hqn',NULL,0,10),('afk',5,NULL,11),('e',9,0,12),('noq',NULL,-239075328,13), ('they',7,NULL,14),('slb',NULL,NULL,15),('cxh',2,-599130112,16), ('it\'s',0,1571749888,17),('acx',8,-1055457280,18),('out',NULL,NULL,19), ('a',-1747648512,1182400512,20),('we',NULL,NULL,21),('I',NULL,1886846976,22), ('y',9,8,23),('something',8,NULL,24),('s',-738590720,NULL,25);
OPTIMIZE TABLE t2;
CREATE TABLE t3 ( col_varchar_1024_utf8 varchar(1024), pk int, col_varchar_1024_latin1_key varchar(1024), col_varchar_1024_utf8_key varchar(1024), col_int int, PRIMARY KEY (pk), KEY col_varchar_1024_latin1_key (col_varchar_1024_latin1_key(1000)), KEY col_varchar_1024_utf8_key (col_varchar_1024_utf8_key(333)) ) charset latin1;
OPTIMIZE TABLE t3;
CREATE TABLE t4 ( pk int, PRIMARY KEY (pk) );
SELECT a2.col_int AS f1,a1.pk AS f2,a1.col_int_key AS f3 FROM (  t2 AS a2 RIGHT JOIN (   t3 AS a3 LEFT JOIN ( t4 AS a4 LEFT OUTER JOIN t2 AS a5 ON a4.pk = a5.col_int_key ) ON a3.pk = a4.pk ) ON a2.pk = a3.pk ) LEFT JOIN t1 AS a1 ON a1.col_varchar_1024_utf8_key = a2.col_varchar_1024_utf8_key WHERE (a3.col_int > 7 AND a1.col_int = 8) ORDER BY f1,f2,f3 DESC;
DROP TABLE t1,t2,t3,t4;