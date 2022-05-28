SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
ALTER TABLE t1 MODIFY COLUMN c8 CHAR(10);
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
ALTER TABLE t1 CHANGE COLUMN c9 c9_1 INTEGER COMMENT '1234567890';
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
ALTER TABLE t1 DROP COLUMN c1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
set sql_mode='TRADITIONAL';
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
set sql_mode='';
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
drop table t1;
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SHOW CREATE TABLE t1;
DROP TABLE t1;
set sql_mode='TRADITIONAL';
SELECT table_comment,char_length(table_comment) FROM information_schema.tables WHERE table_name='t1';
SELECT column_comment,char_length(column_comment) FROM information_schema.columns WHERE table_name='t1' ORDER BY column_comment;
SELECT comment,index_comment,char_length(index_comment) FROM information_schema.statistics WHERE table_name='t1';
SET sql_mode='';
drop table t1_toupg;
SET sql_mode = default;