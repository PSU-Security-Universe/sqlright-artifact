DROP TABLE IF EXISTS t1;
select * from t1;
BINLOG ' SVtYRxMBAAAAKQAAADQBAAAAABAAAAAAAAAABHRlc3QAAnQxAAEDAAE= SVtYRxcBAAAAIgAAAFYBAAAQABAAAAAAAAEAAf/+AgAAAA== ';
select * from t1;
BINLOG ' ODdYRw8BAAAAZgAAAGoAAAABAAQANS4xLjIzLXJjLWRlYnVnLWxvZwAAAAAAAAAAAAAAAAAAAAAA AAAAAAAAAAAAAAAAAAA4N1hHEzgNAAgAEgAEBAQEEgAAUwAEGggAAAAICAgC ';
BINLOG ' TFtYRxMBAAAAKQAAAH8BAAAAABAAAAAAAAAABHRlc3QAAnQxAAEDAAE= TFtYRxcBAAAAIgAAAKEBAAAQABAAAAAAAAEAAf/+AwAAAA== ';
select * from t1;
BINLOG ' 4CdYRw8BAAAAYgAAAGYAAAAAAAQANS4xLjE1LW5kYi02LjEuMjQtZGVidWctbG9nAAAAAAAAAAAA AAAAAAAAAAAAAAAAAADgJ1hHEzgNAAgAEgAEBAQEEgAATwAEGggICAg= ';
BINLOG ' Dl1YRxMBAAAAKQAAADQBAAAAABAAAAAAAAAABHRlc3QAAnQxAAEDAAE= Dl1YRxcBAAAAIgAAAFYBAAAQABAAAAAAAAEAAf/+BQAAAA== ';
select * from t1;
CREATE TABLE char128_utf8 ( i1 INT NOT NULL, c CHAR(128) CHARACTER SET utf8 NOT NULL, i2 INT NOT NULL);
CREATE TABLE char63_utf8 ( i1 INT NOT NULL, c CHAR(63) CHARACTER SET utf8 NOT NULL, i2 INT NOT NULL);
BINLOG ' MuNkSA8BAAAAZgAAAGoAAAAAAAQANS4xLjI1LXJjLWRlYnVnLWxvZwAAAAAAAAAAAAAAAAAAAAAA AAAAAAAAAAAAAAAAAAAy42RIEzgNAAgAEgAEBAQEEgAAUwAEGggAAAAICAgC ';
BINLOG ' 3u9kSBMBAAAANgAAAJYBAAAAABAAAAAAAAAABHRlc3QAC2NoYXI2M191dGY4AAMD/gMC/r0A 3u9kSBcBAAAAKgAAAMABAAAQABAAAAAAAAEAA//4AQAAAAMxMjMBAAAA ';
SELECT * FROM char63_utf8;
BINLOG ' iONkSBMBAAAANwAAAJkBAAAAABAAAAAAAAAABHRlc3QADGNoYXIxMjhfdXRmOAADA/4DAv6AAA== iONkSBcBAAAAKwAAAMQBAAAQABAAAAAAAAEAA//4AQAAAAMAMTIzAQAAAA== ';
drop table t1, char63_utf8, char128_utf8;
BINLOG '';
BINLOG '123';
BINLOG '-2079193929';
BINLOG 'xç↓%~∙D╒ƒ╡';