drop table ;
create table ( text,  varchar, ע1A char(16));
create index index1 on  using btree();
create index index2 on  using btree();
insert into  values('ʾ','A01');
insert into  values('ͼ','B01');
insert into  values('ԳԱ','Z01');
vacuum ;
select * from ;
select * from  where  = 'Z01';
select * from  where  ~* 'z01';
select * from  where  like '_Z01_';
select * from  where  like '_Z%';
select * from  where  ~ '[ͼ]';
select * from  where  ~* '[ͼ]';
select *,character_length() from ;
select *,octet_length() from ;
select *,position('' in ) from ;
select *,substring( from 3 for 4) from ;
