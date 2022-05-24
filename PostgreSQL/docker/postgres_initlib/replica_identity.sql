CREATE TABLE test_replica_identity (       id serial primary key,       keya text not null,       keyb text not null,       nonkey text,       CONSTRAINT test_replica_identity_unique_defer UNIQUE (keya, keyb) DEFERRABLE,       CONSTRAINT test_replica_identity_unique_nondefer UNIQUE (keya, keyb)) ;
CREATE TABLE test_replica_identity_othertable (id serial primary key);
CREATE INDEX test_replica_identity_keyab ON test_replica_identity (keya, keyb);
CREATE UNIQUE INDEX test_replica_identity_keyab_key ON test_replica_identity (keya, keyb);
CREATE UNIQUE INDEX test_replica_identity_nonkey ON test_replica_identity (keya, nonkey);
CREATE INDEX test_replica_identity_hash ON test_replica_identity USING hash (nonkey);
CREATE UNIQUE INDEX test_replica_identity_expr ON test_replica_identity (keya, keyb, (3));
CREATE UNIQUE INDEX test_replica_identity_partial ON test_replica_identity (keya, keyb) WHERE keyb != '3';
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
SELECT relreplident FROM pg_class WHERE oid = 'pg_class'::regclass;
SELECT relreplident FROM pg_class WHERE oid = 'pg_constraint'::regclass;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_keyab;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_nonkey;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_hash;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_expr;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_partial;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_othertable_pkey;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_unique_defer;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_pkey;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
\d test_replica_identityALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_unique_nondefer;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_keyab_key;
ALTER TABLE test_replica_identity REPLICA IDENTITY USING INDEX test_replica_identity_keyab_key;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
\d test_replica_identitySELECT count(*) FROM pg_index WHERE indrelid = 'test_replica_identity'::regclass AND indisreplident;
ALTER TABLE test_replica_identity REPLICA IDENTITY DEFAULT;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
SELECT count(*) FROM pg_index WHERE indrelid = 'test_replica_identity'::regclass AND indisreplident;
ALTER TABLE test_replica_identity REPLICA IDENTITY FULL;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
\d+ test_replica_identityALTER TABLE test_replica_identity REPLICA IDENTITY NOTHING;
SELECT relreplident FROM pg_class WHERE oid = 'test_replica_identity'::regclass;
CREATE TABLE test_replica_identity2 (id int UNIQUE NOT NULL);
ALTER TABLE test_replica_identity2 REPLICA IDENTITY USING INDEX test_replica_identity2_id_key;
\d test_replica_identity2ALTER TABLE test_replica_identity2 ALTER COLUMN id TYPE bigint;
\d test_replica_identity2CREATE TABLE test_replica_identity3 (id int NOT NULL);
CREATE UNIQUE INDEX test_replica_identity3_id_key ON test_replica_identity3 (id);
ALTER TABLE test_replica_identity3 REPLICA IDENTITY USING INDEX test_replica_identity3_id_key;
\d test_replica_identity3ALTER TABLE test_replica_identity3 ALTER COLUMN id TYPE bigint;
\d test_replica_identity3DROP TABLE test_replica_identity;
DROP TABLE test_replica_identity2;
DROP TABLE test_replica_identity3;
DROP TABLE test_replica_identity_othertable;
