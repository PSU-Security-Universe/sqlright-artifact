CREATE TABLE t1 ( fid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  g GEOMETRY NOT NULL SRID 0, SPATIAL KEY(g) ) ENGINE=MyISAM;
SHOW CREATE TABLE t1;
INSERT INTO t1 (g) VALUES (ST_GeomFromText('LineString(150 150, 150 150)'));
