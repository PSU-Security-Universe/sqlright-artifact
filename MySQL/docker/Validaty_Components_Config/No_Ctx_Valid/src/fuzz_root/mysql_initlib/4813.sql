drop table if exists t1,t2;
set @a := foo;
set @a := connection_id() + 3;
select @a - connection_id();
set @b := 1;
select @b;
CREATE TABLE t1 ( i int not null, v int not null,index (i));
insert into t1 values (1,1),(1,3),(2,1);
create table t2 (i int not null, unique (i));
insert into t2 select distinct i from t1;
select * from t2;
select distinct t2.i,@vv1:=if(sv1.i,1,0),@vv2:=if(sv2.i,1,0),@vv3:=if(sv3.i,1,0), @vv1+@vv2+@vv3 from t2 left join t1 as sv1 on sv1.i=t2.i and sv1.v=1 left join t1 as sv2 on sv2.i=t2.i and sv2.v=2 left join t1 as sv3 on sv3.i=t2.i and sv3.v=3;
analyze table t1;
explain select * from t1 where i=@vv1;
select @vv1,i,v from t1 where i=@vv1;
explain select * from t1 where @vv1:=@vv1+1 and i=@vv1;
explain select @vv1:=i from t1 where i=@vv1;
explain select * from t1 where i=@vv1;
drop table t1,t2;
set @a=0,@b=0;
select @a:=10,   @b:=1,   @a > @b, @a < @b;
select @a:="10", @b:="1", @a > @b, @a < @b;
select @a:=10,   @b:=2,   @a > @b, @a < @b;
select @a:="10", @b:="2", @a > @b, @a < @b;
select @a:=1;
select @a, @a:=1;
create table t1 (id int, d double, c char(10));
insert into t1 values (1,2.0, "test");
select @c:=0;
update t1 SET id=(@c:=@c+1);
select @c;
select @c:=0;
update t1 set id=(@c:=@c+1);
select @c;
select @c:=0;
select @c:=@c+1;
select @d,(@d:=id),@d from t1;
select @e,(@e:=d),@e from t1;
select @f,(@f:=c),@f from t1;
set @g=1;
select @g,(@g:=c),@g from t1;
select @c, @d, @e, @f;
select @d:=id, @e:=id, @f:=id, @g:=@id from t1;
select @c, @d, @e, @f, @g;
drop table t1;
select @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b, @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b;
create table t1 (i int not null);
insert t1 values (1),(2),(2),(3),(3),(3);
select @a:=0;
select @a, @a:=@a+count(*), count(*), @a from t1 group by i;
select @a:=0;
select @a+0, @a:=@a+0+count(*), count(*), @a+0 from t1 group by i;
set @a=0;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
drop table t1;
set @a=_latin2'test';
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select @a=_latin2'TEST' collate latin2_bin;
set @a=_latin2'test' collate latin2_general_ci;
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select @a=_latin2'TEST' collate latin2_bin;
select charset(@a:=_latin2'test');
select collation(@a:=_latin2'test');
select coercibility(@a:=_latin2'test');
select collation(@a:=_latin2'test' collate latin2_bin);
select coercibility(@a:=_latin2'test' collate latin2_bin);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST';
select charset(@a),collation(@a),coercibility(@a);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST' collate latin2_general_ci;
set @var= NULL ;
select FIELD( @var,'1it','Hit') as my_column;
select @v, coercibility(@v);
set @v1=null, @v2=1, @v3=1.1, @v4=now();
select coercibility(@v1),coercibility(@v2),coercibility(@v3),coercibility(@v4);
set session @honk=99;
select @@local.max_allowed_packet;
select @@session.max_allowed_packet;
select @@global.max_allowed_packet;
select @@max_allowed_packet;
select @@Max_Allowed_Packet;
select @@version;
select @@global.version;
set @first_var= NULL;
create table t1 select @first_var;
show create table t1;
drop table t1;
set @first_var= cast(NULL as signed integer);
create table t1 select @first_var;
show create table t1;
drop table t1;
set @first_var= NULL;
create table t1 select @first_var;
show create table t1;
drop table t1;
set @first_var= concat(NULL);
create table t1 select @first_var;
show create table t1;
drop table t1;
set @first_var=1;
set @first_var= cast(NULL as CHAR);
create table t1 select @first_var;
show create table t1;
drop table t1;
set @a=18446744071710965857;
select @a;
CREATE TABLE `bigfailure` ( `afield` BIGINT UNSIGNED NOT NULL );
INSERT INTO `bigfailure` VALUES (18446744071710965857);
SELECT * FROM bigfailure;
select * from (SELECT afield FROM bigfailure) as b;
select * from bigfailure where afield = (SELECT afield FROM bigfailure);
select * from bigfailure where afield = 18446744071710965857;
select * from bigfailure where afield = 18446744071710965856+1;
SET @a := (SELECT afield FROM bigfailure);
SELECT @a;
SET @a := (select afield from (SELECT afield FROM bigfailure) as b);
SELECT @a;
SET @a := (select * from bigfailure where afield = (SELECT afield FROM bigfailure));
SELECT @a;
drop table bigfailure;
