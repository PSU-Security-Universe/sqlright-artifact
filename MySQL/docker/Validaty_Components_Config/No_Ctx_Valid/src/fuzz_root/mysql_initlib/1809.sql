drop table if exists t1;
create table t1 (a int check (a>0));
insert into t1 values (1);
insert into t1 values (0);
drop table t1;
create table t1 (a int, b int, check (a>b));
insert into t1 values (1,0);
insert into t1 values (0,1);
drop table t1;
create table t1 (a int ,b int, constraint abc check (a>b));
insert into t1 values (1,0);
insert into t1 values (0,1);
drop table t1;
create table t1 (a int null);
insert into t1 values (1),(NULL);
drop table t1;
create table t1 (a int null);
alter table t1 add constraint constraint_1 unique (a);
alter table t1 add constraint unique key_1(a);
alter table t1 add constraint constraint_2 unique key_2(a);
show create table t1;
drop table t1;
drop table if exists t_illegal;
create table t_illegal (a int, b int, check a>b);
create table t_illegal (a int, b int, constraint abc check a>b);
drop table if exists t_11714;
create table t_11714(a int, b int);
alter table t_11714 add constraint cons1;
drop table t_11714;
CREATE TABLE t1 (f1 INT, f2 INT);
CREATE TABLE t2 (f1 INT PRIMARY KEY);
ALTER TABLE t1 DROP CONSTRAINT unknown;
ALTER TABLE t1 ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 DROP CONSTRAINT unknown;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE (f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT fk;
ALTER TABLE t1 DROP CONSTRAINT `primary`;
ALTER TABLE t1 DROP CONSTRAINT f2_unique;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE (f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT `primary`, DROP CONSTRAINT f2_unique, DROP CONSTRAINT fk, DROP CONSTRAINT f2_check;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT name2 UNIQUE (f1), ADD CONSTRAINT `primary` FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT name2 CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT `primary`;
ALTER TABLE t1 DROP CONSTRAINT name2;
ALTER TABLE t1 DROP PRIMARY KEY, DROP INDEX name2, DROP FOREIGN KEY `primary`, DROP CHECK name2;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE (f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT `primary`, DROP FOREIGN KEY fk, DROP CONSTRAINT f2_unique, DROP CHECK f2_check;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE (f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0), ADD COLUMN f3 INT;
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT `primary`, ADD CONSTRAINT PRIMARY KEY (f1), DROP CONSTRAINT f2_unique, ADD CONSTRAINT f2_unique UNIQUE (f3), DROP CONSTRAINT f2_check, ADD CONSTRAINT f2_check CHECK ((f3 + f2 + f1) < 999);
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP CONSTRAINT `primary`, DROP CONSTRAINT fk, DROP CONSTRAINT f2_unique, DROP CONSTRAINT f2_check, DROP COLUMN f3;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1);
SET SESSION sql_require_primary_key = true;
ALTER TABLE t1 DROP PRIMARY KEY;
ALTER TABLE t1 DROP CONSTRAINT `primary`;
SET SESSION sql_require_primary_key = default;
ALTER TABLE t1 DROP CONSTRAINT `primary`;
CREATE TABLE t3 (col1 INT, col2 INT GENERATED ALWAYS AS (col1) STORED);
ALTER TABLE t3 ADD UNIQUE INDEX idx (((COS( col2 ))) DESC);
ALTER TABLE t3 DROP CONSTRAINT idx;
ALTER TABLE t3 ADD UNIQUE INDEX idx (((COS( col1 ))) DESC);
DROP TABLE t3;
CREATE TEMPORARY TABLE tmp (f1 INT, f2 INT, CONSTRAINT PRIMARY KEY (f1), CONSTRAINT f2_unique UNIQUE(f2), CONSTRAINT f2_check CHECK (f2 > 0));
SHOW CREATE TABLE tmp;
ALTER TABLE tmp DROP CONSTRAINT `primary`, DROP CONSTRAINT f2_check, DROP CONSTRAINT f2_unique;
SHOW CREATE TABLE tmp;
DROP TABLE tmp;
CREATE PROCEDURE drop_constraint_proc() ALTER TABLE t1 DROP CONSTRAINT `primary`, DROP CONSTRAINT f2_unique, DROP CONSTRAINT fk, DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE(f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
CALL drop_constraint_proc();
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_check UNIQUE(f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_unique CHECK (f2 > 0);
SHOW CREATE TABLE t1;
CALL drop_constraint_proc();
SHOW CREATE TABLE t1;
DROP PROCEDURE drop_constraint_proc;
ALTER TABLE t1 ADD COLUMN f3 INT GENERATED ALWAYS AS (f1) STORED;
CREATE PROCEDURE drop_constraint_proc() ALTER TABLE t1 DROP CONSTRAINT constraint_name;
CREATE PROCEDURE test_drop_constraint() BEGIN ALTER TABLE t1 ADD CONSTRAINT constraint_name UNIQUE(f2); call drop_constraint_proc(); ALTER TABLE t1 ADD UNIQUE INDEX constraint_name (((COS(f3))) DESC); call drop_constraint_proc(); ALTER TABLE t1 ADD CONSTRAINT constraint_name CHECK (f2 > 0); call drop_constraint_proc(); ALTER TABLE t1 ADD CONSTRAINT constraint_name FOREIGN KEY (f1) REFERENCES t2(f1); call drop_constraint_proc(); END;
CALL test_drop_constraint();
DROP PROCEDURE drop_constraint_proc;
DROP PROCEDURE test_drop_constraint;
ALTER TABLE t1 DROP COLUMN f3;
PREPARE drop_constraint_stmt FROM 'ALTER TABLE t1 DROP CONSTRAINT `primary`,                   DROP CONSTRAINT f2_unique,                   DROP CONSTRAINT fk,                   DROP CONSTRAINT f2_check';
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE(f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
EXECUTE drop_constraint_stmt;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_check UNIQUE(f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_unique CHECK (f2 > 0);
SHOW CREATE TABLE t1;
EXECUTE drop_constraint_stmt;
SHOW CREATE TABLE t1;
DROP PREPARE drop_constraint_stmt;
ALTER TABLE t1 ALTER CONSTRAINT unknown ENFORCED;
ALTER TABLE t1 ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 ALTER CONSTRAINT unknown ENFORCED;
ALTER TABLE t1 ALTER CONSTRAINT f2_check NOT ENFORCED;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT name2 UNIQUE (f1), ADD CONSTRAINT `primary` FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT name2 CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 ALTER CONSTRAINT name2 NOT ENFORCED;
ALTER TABLE t1 DROP PRIMARY KEY, DROP INDEX name2, DROP FOREIGN KEY `primary`, DROP CHECK name2;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1), ADD CONSTRAINT f2_unique UNIQUE (f2), ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1), ADD CONSTRAINT f2_check CHECK (f2 > 0);
SHOW CREATE TABLE t1;
ALTER TABLE t1 ALTER CONSTRAINT `primary` NOT ENFORCED;
ALTER TABLE t1 ALTER CONSTRAINT f2_unique NOT ENFORCED;