drop table if exists t1;
create table t1 (id int auto_increment primary key not null, mydate date not null);
insert into t1 values (0,"2002-05-01"),(0,"2002-05-01"),(0,"2002-05-01");
flush tables;
select * from t1 where isnull(to_days(mydate));
drop table t1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES (0),(0);
SELECT ISNULL((SELECT GET_LOCK('Bug#53933', 0) FROM t1 GROUP BY f1)) AS f2 FROM t1 GROUP BY f1 HAVING f2 = f2;
SELECT RELEASE_LOCK('Bug#53933');
DROP TABLE t1;
CREATE TABLE t1 (id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, PRIMARY KEY(id));
INSERT INTO t1( id ) VALUES ( NULL );
SELECT t1.id  FROM t1  WHERE (id  is not null and id is null );
DROP TABLE t1;
CREATE TABLE t1 ( pk int NOT NULL, col_int_key INT NOT NULL, col_date_key date NOT NULL, PRIMARY KEY (pk), KEY col_int_key (col_int_key), KEY col_date_key (col_date_key) ) ENGINE=MyISAM;
INSERT IGNORE INTO t1 VALUES (14,4,'0000-00-00'), (15,2,'2003-01-13'), (16,5,'2006-07-07'), (17,3,'0000-00-00');
CREATE TABLE t2 ( pk INT NOT NULL, PRIMARY KEY (pk) ) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1), (2), (3);
CREATE TABLE t3(pk INT NOT NULL);
INSERT INTO t3 VALUES(3),(3);
select * from t3 left join (t2 outr2 join t2 outr join t1) on (outr.pk = t3.pk) and (t1.col_int_key = t3.pk) and isnull(t1.col_date_key) and (outr2.pk <> t3.pk) ;
select * from t3 join (t2 outr2 join t2 outr join t1) on (outr.pk = t3.pk) and (t1.col_int_key = t3.pk) and isnull(t1.col_date_key) and (outr2.pk <> t3.pk) ;
delete from t3;
INSERT INTO t3 VALUES(3);
EXPLAIN select * from t3, t1 where t1.col_date_key is null;
select * from t3, t1 where t1.col_date_key is null;
EXPLAIN select * from t3 join t1 on t1.col_date_key is null;
select * from t3 join t1 on t1.col_date_key is null;
EXPLAIN select * from t3 left join t1 on t1.col_date_key is null;
select * from t3 left join t1 on t1.col_date_key is null;
EXPLAIN select * from t3 left join t1 on t1.col_date_key is null where t1.col_date_key is null;
select * from t3 left join t1 on t1.col_date_key is null where t1.col_date_key is null;
EXPLAIN select * from t3, t1 where t1.col_date_key is not null;
select * from t3, t1 where t1.col_date_key is not null;
EXPLAIN select * from t3, t1 where not (t1.col_date_key is null);
select * from t3, t1 where not (t1.col_date_key is null);
EXPLAIN select * from t3, t1 where (t1.col_date_key is null) is true;
select * from t3, t1 where (t1.col_date_key is null) is true;
DROP TABLE t1,t2,t3;
CREATE TABLE t1 (a INTEGER NOT NULL);
SELECT 1 FROM t1 WHERE (a IS NULL) XOR (RAND() > 2.0);
DROP TABLE t1;
DO AVG((SELECT POINT(@x, POINT(115, 219)) IS NULL));
DO AVG((SELECT POINT(@x, POINT(115, 219)) IS NULL)) OVER ();
