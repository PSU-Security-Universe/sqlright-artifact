CREATE TABLE t1(i INT) ENGINE_ATTRIBUTE;
SHOW CREATE TABLE t1;
ALTER TABLE t1 ENGINE_ATTRIBUTE='{"table algo": "none"}';
