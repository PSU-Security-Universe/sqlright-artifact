drop table if exists t1,t2;
select 0=0,1>0,1>=1,1<0,1<=0,1!=0,strcmp("abc","abcd"),strcmp("b","a"),strcmp("a","a") ;
select "a"<"b","a"<="b","b">="a","b">"a","a"="A","a"<>"b";
select "a "="A", "A "="a", "a  " <= "A b";
select "abc" like "a%", "abc" not like "%d%", "a%" like "a\%","abc%" like "a%\%","abcd" like "a%b_%d", "a" like "%%a","abcde" like "a%_e","abc" like "abc%";
select "a" like "%%b","a" like "%%ab","ab" like "a\%", "ab" like "_", "ab" like "ab_", "abc" like "%_d", "abc" like "abc%d";
select '?' like '|%', '?' like '|%' ESCAPE '|', '%' like '|%', '%' like '|%' ESCAPE '|', '%' like '%';
select 'abc' like '%c','abcabc' like '%c',  "ab" like "", "ab" like "a", "ab" like "ab";
select "Det här är svenska" regexp "h[[:alpha:]]+r", "aba" regexp "^(a|b)*$";
select "aba" regexp concat("^","a");
select !0,NOT 0=1,!(0=0),1 AND 1,1 && 0,0 OR 1,1 || NULL, 1=1 or 1=1 and 1=0;
select 2 between 1 and 3, "monty" between "max" and "my",2=2 and "monty" between "max" and "my" and 3=3;
select 'b' between 'a' and 'c', 'B' between 'a' and 'c';
select 2 in (3,2,5,9,5,1),"monty" in ("david","monty","allan"), 1.2 in (1.4,1.2,1.0);
select -1.49 or -1.49,0.6 or 0.6;
select 3 ^ 11, 1 ^ 1, 1 ^ 0, 1 ^ NULL, NULL ^ 1;
explain select 3 ^ 11, 1 ^ 1, 1 ^ 0, 1 ^ NULL, NULL ^ 1;
select 1 XOR 1, 1 XOR 0, 0 XOR 1, 0 XOR 0, NULL XOR 1, 1 XOR NULL, 0 XOR NULL;
select 1 like 2 xor 2 like 1;
select 10 % 7, 10 mod 7, 10 div 3;
explain select 10 % 7, 10 mod 7, 10 div 3;
select 18446744073709551615, 18446744073709551615 DIV 1, 18446744073709551615 DIV 2;
explain select (1 << 64)-1, ((1 << 64)-1) DIV 1, ((1 << 64)-1) DIV 2;
create table t1 (a int);
insert t1 values (1);
analyze table t1;
select * from t1 where 1 xor 1;
explain select * from t1 where 1 xor 1;
select - a from t1;
explain select - a from t1;
drop table t1;
select 5 between 0 and 10 between 0 and 1,(5 between 0 and 10) between 0 and 1;
select 1 and 2 between 2 and 10, 2 between 2 and 10 and 1;
select 1 and 0 or 2, 2 or 1 and 0;
select _koi8r'a' = _koi8r'A';
select _koi8r'a' = _koi8r'A' COLLATE koi8r_general_ci;
explain select _koi8r'a' = _koi8r'A' COLLATE koi8r_general_ci;
select _koi8r'a' = _koi8r'A' COLLATE koi8r_bin;
select _koi8r'a' COLLATE koi8r_general_ci = _koi8r'A';
select _koi8r'a' COLLATE koi8r_bin = _koi8r'A';
select _koi8r'a' COLLATE koi8r_bin = _koi8r'A' COLLATE koi8r_general_ci;
select _koi8r'a' = _latin1'A';
select strcmp(_koi8r'a', _koi8r'A');
select strcmp(_koi8r'a', _koi8r'A' COLLATE koi8r_general_ci);
select strcmp(_koi8r'a', _koi8r'A' COLLATE koi8r_bin);
select strcmp(_koi8r'a' COLLATE koi8r_general_ci, _koi8r'A');
select strcmp(_koi8r'a' COLLATE koi8r_bin, _koi8r'A');
select strcmp(_koi8r'a' COLLATE koi8r_general_ci, _koi8r'A' COLLATE koi8r_bin);
select strcmp(_koi8r'a', _latin1'A');
select _koi8r'a' LIKE _koi8r'A';
select _koi8r'a' LIKE _koi8r'A' COLLATE koi8r_general_ci;
select _koi8r'a' LIKE _koi8r'A' COLLATE koi8r_bin;
select _koi8r'a' COLLATE koi8r_general_ci LIKE _koi8r'A';
select _koi8r'a' COLLATE koi8r_bin LIKE _koi8r'A';
select _koi8r'a' COLLATE koi8r_general_ci LIKE _koi8r'A' COLLATE koi8r_bin;
select _koi8r'a' LIKE _latin1'A';
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t2 (  access_id smallint(6) NOT NULL default '0',   name varchar(20) binary default NULL,   `rank` smallint(6) NOT NULL default '0',   KEY t2$access_id (access_id) ) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1,'Everyone',2),(2,'Help',3),(3,'Customer Support',1);
SELECT f_acc.`rank`, a1.`rank`, a2.`rank`  FROM t1 LEFT JOIN t1 f1 ON  (f1.access_id=1 AND f1.faq_group_id = t1.faq_group_id) LEFT JOIN t2 a1 ON (a1.access_id =  f1.access_id) LEFT JOIN t1 f2 ON (f2.access_id=3 AND  f2.faq_group_id = t1.faq_group_id) LEFT  JOIN t2 a2 ON (a2.access_id = f2.access_id), t2 f_acc WHERE LEAST(a1.`rank`,a2.`rank`) =  f_acc.`rank`;
DROP TABLE t1,t2;
SET sql_mode = default;
CREATE TABLE t1 (d varchar(6), k int);
INSERT INTO t1 VALUES (NULL, 2);
SELECT GREATEST(d,d) FROM t1 WHERE k=2;
DROP TABLE t1;
select 1197.90 mod 50;
select 5.1 mod 3, 5.1 mod -3, -5.1 mod 3, -5.1 mod -3;
select 5 mod 3, 5 mod -3, -5 mod 3, -5 mod -3;
select (12%0) <=> null      as '1';
select (12%0) is null       as '1';
select 12%0                 as 'NULL';
select 12%2                 as '0';
select 12%NULL              as 'NULL';
select 12 % null            as 'NULL';
select null % 12            as 'NULL';
select null % 0             as 'NULL';
select 0 % null             as 'NULL';
select null % null          as 'NULL';
select (12 mod 0) <=> null  as '1';
select (12 mod 0) is null   as '1';
select 12 mod 0             as 'NULL';
select 12 mod 2             as '0';
select 12 mod null          as 'NULL';
select null mod 12          as 'NULL';
select null mod 0           as 'NULL';
select 0 mod null           as 'NULL';
select null mod null        as 'NULL';
select mod(12.0, 0)         as 'NULL';
select mod(12, 0.0)         as 'NULL';
select mod(12, NULL)        as 'NULL';
select mod(12.0, NULL)      as 'NULL';
select mod(NULL, 2)         as 'NULL';
select mod(NULL, 2.0)       as 'NULL';
create table t1 (a int, b int);
insert into t1 values (1,2), (2,3), (3,4), (4,5);
select * from t1 where a not between 1 and 2;
select * from t1 where a not between 1 and 2 and b not between 3 and 4;
drop table t1;
SELECT GREATEST(1,NULL) FROM DUAL;
SELECT LEAST('xxx','aaa',NULL,'yyy') FROM DUAL;
SELECT LEAST(1.1,1.2,NULL,1.0) FROM DUAL;
SELECT GREATEST(1.5E+2,1.3E+2,NULL) FROM DUAL;
SELECT greatest( 9223372036854775807 , 9223372036854775808 ) as g;
SELECT least   ( 9223372036854775807 , 9223372036854775808 ) as l;
SELECT greatest (9223372036854775808, -1, 18446744073709551615 ) as g;
SELECT least    (9223372036854775808, -1, 18446744073709551615 ) as l;
SELECT greatest (9223372036854775808, 18446744073709551615) as g;
SELECT least    (9223372036854775808, 18446744073709551615) as l;
CREATE TABLE t1 AS SELECT greatest(-1, 9223372036854775808);
CREATE TABLE t2 AS SELECT greatest(9223372036854775808, 9223372036854775808);
SHOW CREATE TABLE t1;
SHOW CREATE TABLE t2;
DROP TABLE t1, t2;
select greatest(1,_utf16'.',_utf8'');
SET sql_mode='';
SET sql_mode=default;
SHOW CREATE TABLE t1;
SHOW CREATE TABLE t2;
SHOW CREATE TABLE t3;
DROP TABLE t1, t2, t3;
SELECT GREATEST('11', '5', '2');
