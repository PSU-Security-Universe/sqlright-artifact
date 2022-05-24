create domain domaindroptest int4;
comment on domain domaindroptest is 'About to drop this..';
create domain dependenttypetest domaindroptest;
drop domain domaindroptest;
drop domain domaindroptest cascade;
drop domain domaindroptest cascade;
create domain domainvarchar varchar(5);
create domain domainnumeric numeric(8,2);
create domain domainint4 int4;
create domain domaintext text;
SELECT cast('123456' as domainvarchar);
SELECT cast('12345' as domainvarchar);
create table basictest           ( testint4 domainint4           , testtext domaintext           , testvarchar domainvarchar           , testnumeric domainnumeric           );
INSERT INTO basictest values ('88', 'haha', 'short', '123.12');
      INSERT INTO basictest values ('88', 'haha', 'short text', '123.12');
 INSERT INTO basictest values ('88', 'haha', 'short', '123.1212');
    COPY basictest (testvarchar) FROM stdin;
 notsoshorttext\.COPY basictest (testvarchar) FROM stdin;
 notsoshorttext\.COPY basictest (testvarchar) FROM stdin;
short\.select * from basictest;
select testtext || testvarchar as concat, testnumeric + 42 as sumfrom basictest;
select coalesce(4::domainint4, 7) is of (int4) as t;
select coalesce(4::domainint4, 7) is of (domainint4) as f;
select coalesce(4::domainint4, 7::domainint4) is of (domainint4) as t;
drop table basictest;
drop domain domainvarchar restrict;
drop domain domainnumeric restrict;
drop domain domainint4 restrict;
drop domain domaintext;
create domain domainint4arr int4[1];
create domain domainchar4arr varchar(4)[2][3];
create table domarrtest           ( testint4arr domainint4arr           , testchar4arr domainchar4arr            );
INSERT INTO domarrtest values ('{2,2}', '{{"a","b"},{"c","d"}}');
INSERT INTO domarrtest values ('{{2,2},{2,2}}', '{{"a","b"}}');
INSERT INTO domarrtest values ('{2,2}', '{{"a","b"},{"c","d"},{"e","f"}}');
INSERT INTO domarrtest values ('{2,2}', '{{"a"},{"c"}}');
INSERT INTO domarrtest values (NULL, '{{"a","b","c"},{"d","e","f"}}');
INSERT INTO domarrtest values (NULL, '{{"toolong","b","c"},{"d","e","f"}}');
INSERT INTO domarrtest (testint4arr[1], testint4arr[3]) values (11,22);
select * from domarrtest;
select testint4arr[1], testchar4arr[2:2] from domarrtest;
select array_dims(testint4arr), array_dims(testchar4arr) from domarrtest;
COPY domarrtest FROM stdin;
{3,4}	{q,w,e}\N	\N\.COPY domarrtest FROM stdin;
	{3,4}	{qwerty,w,e}\.select * from domarrtest;
	{3,4}	{qwerty,w,e}\.select * from domarrtest;
update domarrtest set  testint4arr[1] = testint4arr[1] + 1,  testint4arr[3] = testint4arr[3] - 1where testchar4arr is null;
select * from domarrtest where testchar4arr is null;
drop table domarrtest;
drop domain domainint4arr restrict;
drop domain domainchar4arr restrict;
create domain dia as int[];
select '{1,2,3}'::dia;
select array_dims('{1,2,3}'::dia);
select pg_typeof('{1,2,3}'::dia);
select pg_typeof('{1,2,3}'::dia || 42);
 drop domain dia;
 drop domain dia;
create type comptype as (r float8, i float8);
create domain dcomptype as comptype;
create table dcomptable (d1 dcomptype unique);
insert into dcomptable values (row(1,2)::dcomptype);
insert into dcomptable values (row(3,4)::comptype);
insert into dcomptable values (row(1,2)::dcomptype);
  insert into dcomptable (d1.r) values(11);
  insert into dcomptable (d1.r) values(11);
select * from dcomptable;
select (d1).r, (d1).i, (d1).* from dcomptable;
update dcomptable set d1.r = (d1).r + 1 where (d1).i > 0;
select * from dcomptable;
alter domain dcomptype add constraint c1 check ((value).r <= (value).i);
alter domain dcomptype add constraint c2 check ((value).r > (value).i);
  select row(2,1)::dcomptype;
  insert into dcomptable values (row(1,2)::comptype);
  insert into dcomptable values (row(1,2)::comptype);
insert into dcomptable values (row(2,1)::comptype);
  insert into dcomptable (d1.r) values(99);
  insert into dcomptable (d1.r) values(99);
insert into dcomptable (d1.r, d1.i) values(99, 100);
insert into dcomptable (d1.r, d1.i) values(100, 99);
  update dcomptable set d1.r = (d1).r + 1 where (d1).i > 0;
  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
select * from dcomptable;
explain (verbose, costs off)  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
create rule silly as on delete to dcomptable do instead  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
\d+ dcomptabledrop table dcomptable;
drop type comptype cascade;
create type comptype as (r float8, i float8);
create domain dcomptype as comptype;
alter domain dcomptype add constraint c1 check ((value).r > 0);
comment on constraint c1 on domain dcomptype is 'random commentary';
select row(0,1)::dcomptype;
  alter type comptype alter attribute r type varchar;
  alter type comptype alter attribute r type bigint;
  alter type comptype alter attribute r type bigint;
alter type comptype drop attribute r;
  alter type comptype drop attribute i;
  alter type comptype drop attribute i;
select conname, obj_description(oid, 'pg_constraint') from pg_constraint  where contypid = 'dcomptype'::regtype;
  drop type comptype cascade;
  drop type comptype cascade;
create type comptype as (r float8, i float8);
create domain dcomptypea as comptype[];
create table dcomptable (d1 dcomptypea unique);
insert into dcomptable values (array[row(1,2)]::dcomptypea);
insert into dcomptable values (array[row(3,4), row(5,6)]::comptype[]);
insert into dcomptable values (array[row(7,8)::comptype, row(9,10)::comptype]);
insert into dcomptable values (array[row(1,2)]::dcomptypea);
  insert into dcomptable (d1[1]) values(row(9,10));
  insert into dcomptable (d1[1]) values(row(9,10));
insert into dcomptable (d1[1].r) values(11);
select * from dcomptable;
select d1[2], d1[1].r, d1[1].i from dcomptable;
update dcomptable set d1[2] = row(d1[2].i, d1[2].r);
select * from dcomptable;
update dcomptable set d1[1].r = d1[1].r + 1 where d1[1].i > 0;
select * from dcomptable;
alter domain dcomptypea add constraint c1 check (value[1].r <= value[1].i);
alter domain dcomptypea add constraint c2 check (value[1].r > value[1].i);
  select array[row(2,1)]::dcomptypea;
  insert into dcomptable values (array[row(1,2)]::comptype[]);
  insert into dcomptable values (array[row(1,2)]::comptype[]);
insert into dcomptable values (array[row(2,1)]::comptype[]);
  insert into dcomptable (d1[1].r) values(99);
  insert into dcomptable (d1[1].r) values(99);
insert into dcomptable (d1[1].r, d1[1].i) values(99, 100);
insert into dcomptable (d1[1].r, d1[1].i) values(100, 99);
  update dcomptable set d1[1].r = d1[1].r + 1 where d1[1].i > 0;
  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1  where d1[1].i > 0;
  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1  where d1[1].i > 0;
select * from dcomptable;
explain (verbose, costs off)  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1    where d1[1].i > 0;
create rule silly as on delete to dcomptable do instead  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1    where d1[1].i > 0;
\d+ dcomptabledrop table dcomptable;
drop type comptype cascade;
create domain posint as int check (value > 0);
create table pitable (f1 posint[]);
insert into pitable values(array[42]);
insert into pitable values(array[-1]);
  insert into pitable values('{0}');
  update pitable set f1[1] = f1[1] + 1;
  update pitable set f1[1] = f1[1] + 1;
update pitable set f1[1] = 0;
  select * from pitable;
  select * from pitable;
drop table pitable;
create domain vc4 as varchar(4);
create table vc4table (f1 vc4[]);
insert into vc4table values(array['too long']);
  insert into vc4table values(array['too long']::vc4[]);
  select * from vc4table;
  select * from vc4table;
drop table vc4table;
drop type vc4;
create domain dposinta as posint[];
create table dposintatable (f1 dposinta[]);
insert into dposintatable values(array[array[42]]);
  insert into dposintatable values(array[array[42]::posint[]]);
 insert into dposintatable values(array[array[42]::dposinta]);
 select f1, f1[1], (f1[1])[1] from dposintatable;
 select f1, f1[1], (f1[1])[1] from dposintatable;
select pg_typeof(f1) from dposintatable;
select pg_typeof(f1[1]) from dposintatable;
select pg_typeof(f1[1][1]) from dposintatable;
select pg_typeof((f1[1])[1]) from dposintatable;
update dposintatable set f1[2] = array[99];
select f1, f1[1], (f1[2])[1] from dposintatable;
update dposintatable set f1[2][1] = array[97];
update dposintatable set (f1[2])[1] = array[98];
drop table dposintatable;
drop domain posint cascade;
create domain dnotnull varchar(15) NOT NULL;
create domain dnull    varchar(15);
create domain dcheck   varchar(15) NOT NULL CHECK (VALUE = 'a' OR VALUE = 'c' OR VALUE = 'd');
create table nulltest           ( col1 dnotnull           , col2 dnotnull NULL             , col3 dnull    NOT NULL           , col4 dnull           , col5 dcheck CHECK (col5 IN ('c', 'd'))           );
INSERT INTO nulltest DEFAULT VALUES;
INSERT INTO nulltest values ('a', 'b', 'c', 'd', 'c');
  insert into nulltest values ('a', 'b', 'c', 'd', NULL);
  insert into nulltest values ('a', 'b', 'c', 'd', NULL);
insert into nulltest values ('a', 'b', 'c', 'd', 'a');
INSERT INTO nulltest values (NULL, 'b', 'c', 'd', 'd');
INSERT INTO nulltest values ('a', NULL, 'c', 'd', 'c');
INSERT INTO nulltest values ('a', 'b', NULL, 'd', 'c');
INSERT INTO nulltest values ('a', 'b', 'c', NULL, 'd');
 COPY nulltest FROM stdin;
 a	b	\N	d	d\.COPY nulltest FROM stdin;
 a	b	c	d	\N\.COPY nulltest FROM stdin;
 a	b	c	d	\N\.COPY nulltest FROM stdin;
a	b	c	\N	ca	b	c	\N	da	b	c	\N	a\.select * from nulltest;
SELECT cast('1' as dnotnull);
SELECT cast(NULL as dnotnull);
 SELECT cast(cast(NULL as dnull) as dnotnull);
 SELECT cast(col4 as dnotnull) from nulltest;
 drop table nulltest;
 drop table nulltest;
drop domain dnotnull restrict;
drop domain dnull restrict;
drop domain dcheck restrict;
create domain ddef1 int4 DEFAULT 3;
create domain ddef2 oid DEFAULT '12';
create domain ddef3 text DEFAULT 5;
create sequence ddef4_seq;
create domain ddef4 int4 DEFAULT nextval('ddef4_seq');
create domain ddef5 numeric(8,2) NOT NULL DEFAULT '12.12';
create table defaulttest            ( col1 ddef1            , col2 ddef2            , col3 ddef3            , col4 ddef4 PRIMARY KEY            , col5 ddef1 NOT NULL DEFAULT NULL            , col6 ddef2 DEFAULT '88'            , col7 ddef4 DEFAULT 8000            , col8 ddef5            );
insert into defaulttest(col4) values(0);
 alter table defaulttest alter column col5 drop default;
 alter table defaulttest alter column col5 drop default;
insert into defaulttest default values;
 alter table defaulttest alter column col5 set default null;
 alter table defaulttest alter column col5 set default null;
insert into defaulttest(col4) values(0);
 alter table defaulttest alter column col5 drop default;
 alter table defaulttest alter column col5 drop default;
insert into defaulttest default values;
insert into defaulttest default values;
COPY defaulttest(col5) FROM stdin;
42\.select * from defaulttest;
drop table defaulttest cascade;
create domain dnotnulltest integer;
create table domnotnull( col1 dnotnulltest, col2 dnotnulltest);
insert into domnotnull default values;
alter domain dnotnulltest set not null;
 update domnotnull set col1 = 5;
 update domnotnull set col1 = 5;
alter domain dnotnulltest set not null;
 update domnotnull set col2 = 6;
 update domnotnull set col2 = 6;
alter domain dnotnulltest set not null;
update domnotnull set col1 = null;
 alter domain dnotnulltest drop not null;
 alter domain dnotnulltest drop not null;
update domnotnull set col1 = null;
drop domain dnotnulltest cascade;
create table domdeftest (col1 ddef1);
insert into domdeftest default values;
select * from domdeftest;
alter domain ddef1 set default '42';
insert into domdeftest default values;
select * from domdeftest;
alter domain ddef1 drop default;
insert into domdeftest default values;
select * from domdeftest;
drop table domdeftest;
create domain con as integer;
create table domcontest (col1 con);
insert into domcontest values (1);
insert into domcontest values (2);
alter domain con add constraint t check (VALUE < 1);
 alter domain con add constraint t check (VALUE < 34);
 alter domain con add constraint t check (VALUE < 34);
alter domain con add check (VALUE > 0);
insert into domcontest values (-5);
 insert into domcontest values (42);
 insert into domcontest values (5);
 insert into domcontest values (5);
alter domain con drop constraint t;
insert into domcontest values (-5);
 insert into domcontest values (42);
 insert into domcontest values (42);
alter domain con drop constraint nonexistent;
alter domain con drop constraint if exists nonexistent;
create domain things AS INT;
CREATE TABLE thethings (stuff things);
INSERT INTO thethings (stuff) VALUES (55);
ALTER DOMAIN things ADD CONSTRAINT meow CHECK (VALUE < 11);
ALTER DOMAIN things ADD CONSTRAINT meow CHECK (VALUE < 11) NOT VALID;
ALTER DOMAIN things VALIDATE CONSTRAINT meow;
UPDATE thethings SET stuff = 10;
ALTER DOMAIN things VALIDATE CONSTRAINT meow;
create table domtab (col1 integer);
create domain dom as integer;
create view domview as select cast(col1 as dom) from domtab;
insert into domtab (col1) values (null);
insert into domtab (col1) values (5);
select * from domview;
alter domain dom set not null;
select * from domview;
 alter domain dom drop not null;
 alter domain dom drop not null;
select * from domview;
alter domain dom add constraint domchkgt6 check(value > 6);
select * from domview;
 alter domain dom drop constraint domchkgt6 restrict;
 alter domain dom drop constraint domchkgt6 restrict;
select * from domview;
drop domain ddef1 restrict;
drop domain ddef2 restrict;
drop domain ddef3 restrict;
drop domain ddef4 restrict;
drop domain ddef5 restrict;
drop sequence ddef4_seq;
create domain vchar4 varchar(4);
create domain dinter vchar4 check (substring(VALUE, 1, 1) = 'x');
create domain dtop dinter check (substring(VALUE, 2, 1) = '1');
select 'x123'::dtop;
select 'x1234'::dtop;
 select 'y1234'::dtop;
 select 'y123'::dtop;
 select 'yz23'::dtop;
 select 'xz23'::dtop;
 create temp table dtest(f1 dtop);
 create temp table dtest(f1 dtop);
insert into dtest values('x123');
insert into dtest values('x1234');
 insert into dtest values('y1234');
 insert into dtest values('y123');
 insert into dtest values('yz23');
 insert into dtest values('xz23');
 drop table dtest;
 drop table dtest;
drop domain vchar4 cascade;
create domain str_domain as text not null;
create table domain_test (a int, b int);
insert into domain_test values (1, 2);
insert into domain_test values (1, 2);
alter table domain_test add column c str_domain;
create domain str_domain2 as text check (value <> 'foo') default 'foo';
alter table domain_test add column d str_domain2;
create domain pos_int as int4 check (value > 0) not null;
prepare s1 as select  1::pos_int = 10 as "is_ten";
execute s1(10);
execute s1(0);
 execute s1(NULL);
 create function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int;
 create function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int;
begin    return p1;
end language plpgsql;
select doubledecrement(3);
 create or replace function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int := 0;
 create or replace function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int := 0;
begin    return p1;
end language plpgsql;
select doubledecrement(3);
 create or replace function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int := 1;
 create or replace function doubledecrement(p1 pos_int) returns pos_int as declare v pos_int := 1;
begin    v := p1 - 1;
    return v - 1;
end language plpgsql;
select doubledecrement(null);
 select doubledecrement(0);
 select doubledecrement(1);
 select doubledecrement(2);
 select doubledecrement(3);
 create domain posint as int4;
 create domain posint as int4;
create type ddtest1 as (f1 posint);
create table ddtest2(f1 ddtest1);
insert into ddtest2 values(row(-1));
alter domain posint add constraint c1 check(value >= 0);
drop table ddtest2;
create table ddtest2(f1 ddtest1[]);
insert into ddtest2 values('{(-1)}');
alter domain posint add constraint c1 check(value >= 0);
drop table ddtest2;
create domain ddtest1d as ddtest1;
create table ddtest2(f1 ddtest1d);
insert into ddtest2 values('(-1)');
alter domain posint add constraint c1 check(value >= 0);
drop table ddtest2;
drop domain ddtest1d;
create domain ddtest1d as ddtest1[];
create table ddtest2(f1 ddtest1d);
insert into ddtest2 values('{(-1)}');
alter domain posint add constraint c1 check(value >= 0);
drop table ddtest2;
drop domain ddtest1d;
create type rposint as range (subtype = posint);
create table ddtest2(f1 rposint);
insert into ddtest2 values('(-1,3]');
alter domain posint add constraint c1 check(value >= 0);
drop table ddtest2;
drop type rposint;
alter domain posint add constraint c1 check(value >= 0);
create domain posint2 as posint check (value % 2 = 0);
create table ddtest2(f1 posint2);
insert into ddtest2 values(11);
 insert into ddtest2 values(-2);
 insert into ddtest2 values(2);
 insert into ddtest2 values(2);
alter domain posint add constraint c2 check(value >= 10);
 alter domain posint add constraint c2 check(value > 0);
 drop table ddtest2;
 drop table ddtest2;
drop type ddtest1;
drop domain posint cascade;
create or replace function array_elem_check(numeric) returns numeric as declare  x numeric(4,2)[1];
begin  x[1] :=  1;
  return x[1];
end language plpgsql;
select array_elem_check(121.00);
select array_elem_check(1.23456);
create domain mynums as numeric(4,2)[1];
create or replace function array_elem_check(numeric) returns numeric as declare  x mynums;
begin  x[1] :=  1;
  return x[1];
end language plpgsql;
select array_elem_check(121.00);
select array_elem_check(1.23456);
create domain mynums2 as mynums;
create or replace function array_elem_check(numeric) returns numeric as declare  x mynums2;
begin  x[1] :=  1;
  return x[1];
end language plpgsql;
select array_elem_check(121.00);
select array_elem_check(1.23456);
drop function array_elem_check(numeric);
create domain orderedpair as int[2] check (value[1] < value[2]);
select array[1,2]::orderedpair;
select array[2,1]::orderedpair;
  create temp table op (f1 orderedpair);
  create temp table op (f1 orderedpair);
insert into op values (array[1,2]);
insert into op values (array[2,1]);
  update op set f1[2] = 3;
  update op set f1[2] = 3;
update op set f1[2] = 0;
  select * from op;
  select * from op;
create or replace function array_elem_check(int) returns int as declare  x orderedpair := '{1,2}';
begin  x[2] :=  1;
  return x[2];
end language plpgsql;
select array_elem_check(3);
select array_elem_check(-1);
drop function array_elem_check(int);
create domain di as int;
create function dom_check(int) returns di as declare d di;
begin  d :=  1::di;
  return d;
end language plpgsql immutable;
select dom_check(0);
alter domain di add constraint pos check (value > 0);
select dom_check(0);
 alter domain di drop constraint pos;
 alter domain di drop constraint pos;
select dom_check(0);
create or replace function dom_check(int) returns di as declare d di;
begin  d :=  1;
  return d;
end language plpgsql immutable;
select dom_check(0);
alter domain di add constraint pos check (value > 0);
select dom_check(0);
 alter domain di drop constraint pos;
 alter domain di drop constraint pos;
select dom_check(0);
drop function dom_check(int);
drop domain di;
create function sql_is_distinct_from(anyelement, anyelement)returns boolean language sqlas 'select  1 is distinct from  2 limit 1';
create domain inotnull int  check (sql_is_distinct_from(value, null));
select 1::inotnull;
select null::inotnull;
create table dom_table (x inotnull);
insert into dom_table values ('1');
insert into dom_table values (1);
insert into dom_table values (null);
drop table dom_table;
drop domain inotnull;
drop function sql_is_distinct_from(anyelement, anyelement);
create domain testdomain1 as int;
alter domain testdomain1 rename to testdomain2;
alter type testdomain2 rename to testdomain3;
  drop domain testdomain3;
  drop domain testdomain3;
create domain testdomain1 as int constraint unsigned check (value > 0);
alter domain testdomain1 rename constraint unsigned to unsigned_foo;
alter domain testdomain1 drop constraint unsigned_foo;
drop domain testdomain1;
