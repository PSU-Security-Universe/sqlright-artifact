create table v0(v1 int, v2 int, v3 char);
select v1 from v0 union select v2 from v0;
INSERT INTO V0 VALUES (10, 10, 'x');
reindex table v0;
