drop table גђ;
create table גђ (ђ text, ʬ varchar, 1A char(16));
create index גђindex1 on גђ using btree (ђ);
create index גђindex2 on גђ using hash (ʬ);
insert into גђ values('Ԓ咡ǒג쒥','A01');
insert into גђ values('Ԓ咡钥ՒÒ','ʬB10');
insert into גђ values('Ԓ咡ג풥钥ޒ','Z01');
vacuum גђ;
select * from גђ;
select * from גђ where ʬ = 'Z01';
select * from גђ where ʬ ~* 'z01';
select * from גђ where ʬ like '_Z01_';
select * from גђ where ʬ like '_Z%';
select * from גђ where ђ ~ 'Ԓ咡[ǒ]';
select * from גђ where ђ ~* 'Ԓ咡[ǒ]';
select *,character_length(ђ) from גђ;
select *,octet_length(ђ) from גђ;
select *,position('' in ђ) from גђ;
select *,substring(ђ from 10 for 4) from גђ;
drop table Ƒ㑻;
create table Ƒ㑻( text, ֑ varchar, ע1A char(16));
create index Ƒ㑻index1 on Ƒ㑻 using btree();
create index Ƒ㑻index2 on Ƒ㑻 using btree(֑);
insert into Ƒ㑻 values('ԑԑʾ','A01');
insert into Ƒ㑻 values('ԑͼ','B01');
insert into Ƒ㑻 values('ԑ̑Ա','Z01');
vacuum Ƒ㑻;
select * from Ƒ㑻;
select * from Ƒ㑻 where ֑ = 'Z01';
select * from Ƒ㑻 where ֑ ~* 'z01';
select * from Ƒ㑻 where ֑ like '_Z01_';
select * from Ƒ㑻 where ֑ like '_Z%';
select * from Ƒ㑻 where  ~ '[ԑͼ]';
select * from Ƒ㑻 where  ~* '[ԑͼ]';
select *,character_length() from Ƒ㑻;
select *,octet_length() from Ƒ㑻;
select *,position('' in ) from Ƒ㑻;
select *,substring( from 3 for 4) from Ƒ㑻;
drop table ͪߩѦ듾;
create table ͪߩѦ듾 (듾 text, ׾ړ varchar, 1A󓱸 char(16));
create index ͪߩѦ듾index1 on ͪߩѦ듾 using btree (듾);
create index ͪߩѦ듾index2 on ͪߩѦ듾 using hash (׾ړ);
insert into ͪߩѦ듾 values('ēǻ͓𓽺Ó', 'ѦA01߾');
insert into ͪߩѦ듾 values('ēǻ͓דȓ', 'B10');
insert into ͪߩѦ듾 values('ēǻ͓Γד', 'Z01');
vacuum ͪߩѦ듾;
select * from ͪߩѦ듾;
select * from ͪߩѦ듾 where ׾ړ = 'Z01';
select * from ͪߩѦ듾 where ׾ړ ~* 'z01';
select * from ͪߩѦ듾 where ׾ړ like '_Z01_';
select * from ͪߩѦ듾 where ׾ړ like '_Z%';
select * from ͪߩѦ듾 where 듾 ~ 'ēǻ[]';
select * from ͪߩѦ듾 where 듾 ~* 'ēǻ[]';
select *,character_length(듾) from ͪߩѦ듾;
select *,octet_length(듾) from ͪߩѦ듾;
select *,position('' in 듾) from ͪߩѦ듾;
select *,substring(듾 from 3 for 4) from ͪߩѦ듾;
drop table test;
create table test (t text);
insert into test values('ENGLISH');
insert into test values('FRANAIS');
insert into test values('ESPAOL');
insert into test values('SLENSKA');
insert into test values('ENGLISH FRANAIS ESPAOL SLENSKA');
vacuum test;
select * from test;
select * from test where t = 'ESPAOL';
select * from test where t ~* 'espaol';
select *,character_length(t) from test;
select *,octet_length(t) from test;
select *,position('L' in t) from test;
select *,substring(t from 3 for 4) from test;
