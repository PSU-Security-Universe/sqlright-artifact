CREATE TABLE t(id int, vbin1 varbinary(32), vbin2 varbinary(32));
INSERT INTO t VALUES (1, x'59', x'6a'), (2, x'5939', x'6ac3'), (3, x'5939a998', x'6ac35d2a'), (4, x'5939a99861154f35', x'6ac35d2a3ab34bda'), (5, x'5939a99861154f3587d5440618e9b28b', x'6ac35d2a3ab34bda8ac412ea0141852c'), (6, x'5939a99861154f3587d5440618e9b28b166181c5ca514ab1b8e9c970ae5e421a', x'6ac35d2a3ab34bda8ac412ea0141852c3c8e38bb19934a7092a40bb19db13a80'), (7, x'5939a99861154f3587d5440618e9b28b', x'8ac412ea0141852c'), (8, x'5939a99861154f35', x'6ac35d2a3ab34bda8ac412ea0141852c');
SELECT HEX(vbin1 & vbin2), HEX(vbin1 | vbin2), HEX(vbin1 ^ vbin2), HEX(~vbin1), HEX(vbin1 << 3), HEX(vbin2 >> 3), BIT_COUNT(vbin1) FROM t WHERE id in(1,2,3,4,5,6);
SELECT vbin1 & vbin2, vbin1 | vbin2, vbin1 ^ vbin2, ~vbin1, vbin1 << 3, vbin2 >> 3 FROM t WHERE id in(1,2,3,4,5,6);
SELECT (vbin1 & vbin2)=0x4801090820114B1082C40002004180081400008108114A3090A009308C100200, (vbin1 | vbin2)=0x7BFBFDBA7BB74FFF8FD556EE19E9B7AF3EEFB9FFDBD34AF1BAEDCBF1BFFF7A9A, (vbin1 ^ vbin2)=0x33FAF4B25BA604EF0D1156EC19A837A72AEFB97ED3C200C12A4DC2C133EF789A, (~vbin1)=0xA6C656679EEAB0CA782ABBF9E7164D74E99E7E3A35AEB54E4716368F51A1BDE5, (vbin1 << 3)=0xC9CD4CC308AA79AC3EAA2030C74D9458B30C0E2E528A558DC74E4B8572F210D0, (vbin2 >> 3)=0x0D586BA54756697B5158825D402830A58791C7176332694E1254817633B62750 FROM t WHERE id in(1,2,3,4,5,6);
select HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 | _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2), HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 ^ _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2), HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 & _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2), HEX(~ _binary 0x19c9bbcce9e0a88f5212572b0c5b9e6d0), HEX(~ _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2);
SELECT HEX(vbin1 << 3), HEX(vbin2 << 3) FROM t WHERE id=7;
SELECT HEX(vbin1 >> 3), HEX(vbin2 >> 3) FROM t WHERE id=7;
SELECT HEX(~vbin1), HEX(~vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 << 3), HEX(vbin2 << 3) FROM t WHERE id=8;
SELECT HEX(vbin1 >> 3), HEX(vbin2 >> 3) FROM t WHERE id=8;
SELECT HEX(~vbin1), HEX(~vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 & vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 | vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 ^ vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 & vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 | vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 ^ vbin2) FROM t WHERE id=8;
CREATE TABLE t0(vbin VARBINARY(6), bin BINARY(6));
CREATE TABLE t1  charset utf8mb4 AS SELECT vbin & vbin, vbin & bin, bin & vbin, bin & bin FROM t0;
SHOW CREATE TABLE t1;
DROP TABLE t0;
DROP TABLE t1;
PREPARE s1 FROM "SELECT HEX(vbin1 & vbin2), HEX(vbin1 | vbin2), HEX(vbin1 ^ vbin2),   HEX(~vbin1), HEX(vbin1 << 3), HEX(vbin2 >> 3), BIT_COUNT(vbin1) FROM t WHERE id in(1, 2, 3, 4, 5, 6)";
EXECUTE s1;
EXECUTE s1;
PREPARE s2 FROM "SELECT HEX(vbin1 & vbin2), HEX(vbin1 | vbin2), HEX(vbin1 ^ vbin2),   HEX(~vbin1), HEX(vbin1 << 3), HEX(vbin2 >> 3), BIT_COUNT(vbin1) FROM t WHERE id in(7)";
EXECUTE s2;
EXECUTE s2;
DROP TABLE t;
CREATE TABLE networks ( id int(10) unsigned NOT NULL AUTO_INCREMENT, start varbinary(16) NOT NULL, end varbinary(16) NOT NULL, country_code varchar(2) NOT NULL, country varchar(255) NOT NULL, PRIMARY KEY (id), KEY start (start), KEY end (end) );
INSERT INTO networks(start, end, country_code, country) VALUES (INET6_ATON('2c0f:fff0::'),INET6_ATON('2c0f:fff0:ffff:ffff:ffff:ffff:ffff:ffff'),'NG','Nigeria'), (INET6_ATON('2405:1d00::'),INET6_ATON('2405:1d00:ffff:ffff:ffff:ffff:ffff:ffff'),'GR','Greenland'), (INET6_ATON('2c0f:ffe8::'),INET6_ATON('2c0f:ffe8:ffff:ffff:ffff:ffff:ffff:ffff'),'NG','Nigeria');
SELECT id, HEX(start), HEX(end), country_code, country FROM networks WHERE INET6_ATON('2c0f:fff0:1234:5678:9101:1123::') & start = INET6_ATON('2c0f:fff0::');
SELECT id, HEX(start), HEX(end), country_code, country FROM networks WHERE INET6_ATON('2c0f:ffe8:1234:5678:9101:1123::') & start = INET6_ATON('2c0f:ffe8::');
SELECT id, HEX(start), HEX(end), country_code, country FROM networks WHERE INET6_ATON('2c0f:fff0::') | start = INET6_ATON('2c0f:fff0::');
SELECT id, HEX(start), HEX(end), country_code, country FROM  networks WHERE INET6_ATON('2c0f:ffe8::') | start = INET6_ATON('2c0f:ffe8::');
SELECT id, HEX(start), HEX(end), country_code, country FROM networks WHERE INET6_ATON('2c0f:fff0::') ^ start = INET6_ATON('::');
SELECT id, HEX(start), HEX(end), country_code, country FROM networks WHERE INET6_ATON('2c0f:ffe8::') ^ start = INET6_ATON('::');
DROP TABLE networks;
SELECT _bit | 2147483647 FROM at;
SELECT _tin | 2147483647 FROM at;
SELECT _boo | 2147483647 FROM at;
SELECT _sms | 2147483647 FROM at;
SELECT _smu | 2147483647 FROM at;
SELECT _mes | 2147483647 FROM at;
SELECT _meu | 2147483647 FROM at;
SELECT _ins | 2147483647 FROM at;
SELECT _inu | 2147483647 FROM at;
SELECT _bis | 2147483647 FROM at;
SELECT _biu | 2147483647 FROM at;
SELECT _dec | 2147483647 FROM at;
SELECT _flo | 2147483647 FROM at;
SELECT _dou | 2147483647 FROM at;
SELECT _yea | 2147483647 FROM at;
SELECT _jsn | 2147483647 FROM at;
SELECT _chr | 2147483647 FROM at;
SELECT _vch | 2147483647 FROM at;
SELECT _bin | 2147483647 FROM at;
SELECT _vbn | 2147483647 FROM at;
SELECT _tbl | 2147483647 FROM at;
SELECT _ttx | 2147483647 FROM at;
SELECT _blb | 2147483647 FROM at;
SELECT _txt | 2147483647 FROM at;
SELECT _mbb | 2147483647 FROM at;
SELECT _mtx | 2147483647 FROM at;
SELECT _lbb | 2147483647 FROM at;
SELECT _ltx | 2147483647 FROM at;
SELECT _pnt | 2147483647 FROM at;
SELECT _dat | 2147483647 FROM at;
SELECT _dtt | 2147483647 FROM at;
SELECT _smp | 2147483647 FROM at;
SELECT _tim | 2147483647 FROM at;
SELECT _enu | 2147483647 FROM at;
SELECT _set | 2147483647 FROM at;
SELECT _bit & 2147483647 FROM at;
SELECT _tin & 2147483647 FROM at;
SELECT _boo & 2147483647 FROM at;
SELECT _sms & 2147483647 FROM at;
SELECT _smu & 2147483647 FROM at;
SELECT _mes & 2147483647 FROM at;
SELECT _meu & 2147483647 FROM at;
SELECT _ins & 2147483647 FROM at;
SELECT _inu & 2147483647 FROM at;
SELECT _bis & 2147483647 FROM at;
SELECT _biu & 2147483647 FROM at;
SELECT _dec & 2147483647 FROM at;
SELECT _flo & 2147483647 FROM at;
SELECT _dou & 2147483647 FROM at;
SELECT _yea & 2147483647 FROM at;
SELECT _jsn & 2147483647 FROM at;
SELECT _chr & 2147483647 FROM at;
SELECT _vch & 2147483647 FROM at;
SELECT _bin & 2147483647 FROM at;
SELECT _vbn & 2147483647 FROM at;
SELECT _tbl & 2147483647 FROM at;
SELECT _ttx & 2147483647 FROM at;
SELECT _blb & 2147483647 FROM at;
SELECT _txt & 2147483647 FROM at;
SELECT _mbb & 2147483647 FROM at;
SELECT _mtx & 2147483647 FROM at;
SELECT _lbb & 2147483647 FROM at;
SELECT _ltx & 2147483647 FROM at;
SELECT _pnt & 2147483647 FROM at;
SELECT _dat & 2147483647 FROM at;
SELECT _dtt & 2147483647 FROM at;
SELECT _smp & 2147483647 FROM at;
SELECT _tim & 2147483647 FROM at;
SELECT _enu & 2147483647 FROM at;
SELECT _set & 2147483647 FROM at;
SELECT _bit ^ 2147483647 FROM at;
SELECT _tin ^ 2147483647 FROM at;
SELECT _boo ^ 2147483647 FROM at;
SELECT _sms ^ 2147483647 FROM at;
SELECT _smu ^ 2147483647 FROM at;
SELECT _mes ^ 2147483647 FROM at;
SELECT _meu ^ 2147483647 FROM at;
SELECT _ins ^ 2147483647 FROM at;
SELECT _inu ^ 2147483647 FROM at;
SELECT _bis ^ 2147483647 FROM at;
SELECT _biu ^ 2147483647 FROM at;
SELECT _dec ^ 2147483647 FROM at;
SELECT _flo ^ 2147483647 FROM at;
