CREATE TABLE t1 ( d datetime default NULL ) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('2002-10-24 14:50:32'),('2002-10-24 14:50:33'),('2002-10-24 14:50:34'),('2002-10-24 14:50:34'),('2002-10-24 14:50:34'),('2002-10-24 14:50:35'),('2002-10-24 14:50:35'),('2002-10-24 14:50:35'),('2002-10-24 14:50:35'),('2002-10-24 14:50:36'),('2002-10-24 14:50:36'),('2002-10-24 14:50:36'),('2002-10-24 14:50:36'),('2002-10-24 14:50:37'),('2002-10-24 14:50:37'),('2002-10-24 14:50:37'),('2002-10-24 14:50:37'),('2002-10-24 14:50:38'),('2002-10-24 14:50:38'),('2002-10-24 14:50:38'),('2002-10-24 14:50:39'),('2002-10-24 14:50:39'),('2002-10-24 14:50:39'),('2002-10-24 14:50:39'),('2002-10-24 14:50:40'),('2002-10-24 14:50:40'),('2002-10-24 14:50:40');
flush status;
select * from t1 group by d;
show status like "created_tmp%tables";
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TEMPORARY TABLE t1(a INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1), (2), (3);
OPTIMIZE TABLE t1;
INSERT INTO t1 VALUES (1), (2), (3);
REPAIR TABLE t1;
DROP TABLES t1;
