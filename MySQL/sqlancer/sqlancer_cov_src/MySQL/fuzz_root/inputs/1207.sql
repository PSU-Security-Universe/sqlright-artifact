SET default_storage_engine=InnoDB;
SET SESSION innodb_strict_mode = ON;
SET GLOBAL innodb_file_per_table = OFF;
CREATE TABLE t1 (a int KEY, b text) ENGINE = InnoDB PARTITION BY HASH (a) (PARTITION p0 engine=InnoDB DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data' INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data', PARTITION p1 engine=InnoDB DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data' INDEX DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data');
SHOW WARNINGS;
INSERT INTO t1 VALUES (1, "red");
TRUNCATE TABLE t1;
RENAME TABLE t1 TO t11;
DROP TABLE t11;
PREPARE stmt1 FROM "CREATE TABLE t1 (a int KEY, b text)      ENGINE = InnoDB PARTITION BY HASH (a)      (PARTITION p0 engine=InnoDB DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data',       PARTITION p1 engine=InnoDB DATA DIRECTORY='/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/bld/mysql-test/var/tmp/alternate_dir/data2')";
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
SET @@global.innodb_file_per_table = ON;
ALTER TABLE t1 COALESCE PARTITION 1;
