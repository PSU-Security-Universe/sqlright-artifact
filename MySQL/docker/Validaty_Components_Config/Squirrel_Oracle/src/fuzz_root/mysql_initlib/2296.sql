SET time_zone = '+01:00';
SELECT cast(TIMESTAMP'2019-10-10 10:11:12' AT TIME ZONE 'UTC' AS DATETIME);
SELECT cast(TIMESTAMP'2019-10-10 10:11:12' AT TIME ZONE '+00:00' AS DATETIME);
SELECT cast(TIMESTAMP'2019-10-10 10:11:12+00:00' AT TIME ZONE '+00:00' AS DATETIME);
SELECT cast( TIME'10:10' AT TIME ZONE 'UTC' AS DATETIME );
SELECT cast( '2019-10-10' AT TIME ZONE 'UTC' AS DATETIME );
SELECT cast( 123 AT TIME ZONE 'UTC' AS DATETIME );
CREATE TABLE t1 ( a TIMESTAMP, b DATETIME );
INSERT INTO t1 VALUES ( '2019-10-10 10:11:12+00:00', '2019-10-10 10:11:12+00:00' );
SELECT * FROM t1;
SELECT cast( a AT TIME ZONE '+00:00' AS DATETIME ) FROM t1;
SELECT cast( b AT TIME ZONE '+00:00' AS DATETIME ) FROM t1;
SET time_zone = '+12:34';
SELECT cast( a AT TIME ZONE '+00:00' AS DATETIME ) FROM t1;
SELECT cast( b AT TIME ZONE '+00:00' AS DATETIME ) FROM t1;
DROP TABLE t1;
SELECT cast( '2019-10-10 10:11' AT TIME ZONE 'UTC' AS DATETIME );
SET time_zone = DEFAULT;
RENAME TABLE mysql.time_zone TO time_zone_backup;
CREATE TABLE t1 ( a TIMESTAMP );
DROP TABLE t1;
RENAME TABLE time_zone_backup TO mysql.time_zone;