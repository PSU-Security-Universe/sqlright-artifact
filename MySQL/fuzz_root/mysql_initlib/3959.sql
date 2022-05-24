drop table if exists t1;
create table t1  ( id     INTEGER AUTO_INCREMENT PRIMARY KEY, emp    CHAR(10) NOT NULL, salary DECIMAL(6,2) NOT NULL, l INTEGER NOT NULL, r INTEGER NOT NULL);
prepare st_ins from 'insert into t1 set emp = ?, salary = ?, l = ?, r = ?';
set @arg_nam= 'Jerry';
set @arg_sal= 1000;
set @arg_l= 1;
set @arg_r= 12;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
set @arg_nam= 'Bert';
set @arg_sal=  900;
set @arg_l= 2;
set @arg_r=  3;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
set @arg_nam= 'Chuck';
set @arg_sal=  900;
set @arg_l= 4;
set @arg_r= 11;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
set @arg_nam= 'Donna';
set @arg_sal=  800;
set @arg_l= 5;
set @arg_r=  6;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
set @arg_nam= 'Eddie';
set @arg_sal=  700;
set @arg_l= 7;
set @arg_r=  8;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
set @arg_nam= 'Fred';
set @arg_sal=  600;
set @arg_l= 9;
set @arg_r= 10;
execute st_ins using @arg_nam, @arg_sal, @arg_l, @arg_r ;
select * from t1;
prepare st_raise_base from 'update t1 set salary = salary * ( 1 + ? ) where r - l = 1';
prepare st_raise_mgr  from 'update t1 set salary = salary + ? where r - l > 1';
set @arg_percent= .10;
set @arg_amount= 100;
execute st_raise_base using @arg_percent;
execute st_raise_mgr  using @arg_amount;
execute st_raise_base using @arg_percent;
execute st_raise_mgr  using @arg_amount;
execute st_raise_base using @arg_percent;
execute st_raise_mgr  using @arg_amount;
select * from t1;
prepare st_round from 'update t1 set salary = salary + ? - ( salary MOD ? )';
set @arg_round= 50;
execute st_round using @arg_round, @arg_round;
select * from t1;
drop table t1;
