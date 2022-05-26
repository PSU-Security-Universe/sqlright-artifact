CREATE OPERATOR === (        PROCEDURE = int8eq,        LEFTARG = bigint,        RIGHTARG = bigint,        COMMUTATOR = ===);
CREATE OPERATOR !== (        PROCEDURE = int8ne,        LEFTARG = bigint,        RIGHTARG = bigint,        NEGATOR = ===,        COMMUTATOR = !==);
DROP OPERATOR !==(bigint, bigint);
SELECT  ctid, oprcomFROM    pg_catalog.pg_operator fkWHERE   oprcom != 0 AND        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprcom);
SELECT  ctid, oprnegateFROM    pg_catalog.pg_operator fkWHERE   oprnegate != 0 AND        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprnegate);
DROP OPERATOR ===(bigint, bigint);
CREATE OPERATOR <| (        PROCEDURE = int8lt,        LEFTARG = bigint,        RIGHTARG = bigint);
CREATE OPERATOR |> (        PROCEDURE = int8gt,        LEFTARG = bigint,        RIGHTARG = bigint,        NEGATOR = <|,        COMMUTATOR = <|);
DROP OPERATOR |>(bigint, bigint);
SELECT  ctid, oprcomFROM    pg_catalog.pg_operator fkWHERE   oprcom != 0 AND        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprcom);
SELECT  ctid, oprnegateFROM    pg_catalog.pg_operator fkWHERE   oprnegate != 0 AND        NOT EXISTS(SELECT 1 FROM pg_catalog.pg_operator pk WHERE pk.oid = fk.oprnegate);
DROP OPERATOR <|(bigint, bigint);