drop table ӋCZ;
create table ӋCZ (Z text, ` varchar, 俼1A char(16));
create index ӋCZindex1 on ӋCZ using btree (Z);
create index ӋCZindex2 on ӋCZ using hash (`);
insert into ӋCZ values('ԥ`ǥץ쥤','CA01');
insert into ӋCZ values('ԥ`եå','B10');
insert into ӋCZ values('ԥ`ץީ`','Z01');
vacuum ӋCZ;
select * from ӋCZ;
select * from ӋCZ where ` = 'Z01';
select * from ӋCZ where ` ~* 'z01';
select * from ӋCZ where ` like '_Z01_';
select * from ӋCZ where ` like '_Z%';
select * from ӋCZ where Z ~ 'ԥ`[ǥ]';
select * from ӋCZ where Z ~* 'ԥ`[ǥ]';
select *,character_length(Z) from ӋCZ;
select *,octet_length(Z) from ӋCZ;
select *,position('' in Z) from ӋCZ;
select *,substring(Z from 10 for 4) from ӋCZ;
