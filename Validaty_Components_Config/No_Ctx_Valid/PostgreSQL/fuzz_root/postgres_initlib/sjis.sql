drop table vZ@p;
create table vZ@p (p text, ރR[h varchar, l1A char(16));
create index vZ@pindex1 on vZ@p using btree (p);
create index vZ@pindex2 on vZ@p using hash (ރR[h);
insert into vZ@p values('Rs[^fBXvC','@A01');
insert into vZ@p values('Rs[^OtBbNX','B10');
insert into vZ@p values('Rs[^vO}[','lZ01');
vacuum vZ@p;
select * from vZ@p;
select * from vZ@p where ރR[h = 'lZ01';
select * from vZ@p where ރR[h ~* 'lz01';
select * from vZ@p where ރR[h like '_Z01_';
select * from vZ@p where ރR[h like '_Z%';
select * from vZ@p where p ~ 'Rs[^[fO]';
select * from vZ@p where p ~* 'Rs[^[fO]';
select *,character_length(p) from vZ@p;
select *,octet_length(p) from vZ@p;
select *,position('f' in p) from vZ@p;
select *,substring(p from 10 for 4) from vZ@p;
copy vZ@p to stdout;
