SET NAMES utf8mb4;
SET collation_connection='gb18030_unicode_520_ci';
CREATE TABLE t1(C CHAR(10) CHARACTER SET gb18030 COLLATE gb18030_unicode_520_ci, UNIQUE KEY(c));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x0149 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x01F0 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x0390 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x03B0 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x0587 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1E96 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1E97 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1E98 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1E99 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1E9A USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FB2 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FC2 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FE4 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FF2 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB00 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB01 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB02 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB03 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB04 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB05 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB13 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB14 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB15 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB16 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0xFB17 USING gb18030));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x00DF USING gb18030));
SELECT * FROM t1;
SELECT COUNT(*) FROM t1;
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x02BC USING gb18030), CONVERT(_ucs2 0x004E USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x02BC USING gb18030), CONVERT(_ucs2 0x006E USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x004A USING gb18030), CONVERT(_ucs2 0x030C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x006A USING gb18030), CONVERT(_ucs2 0x030C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0399 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03B9 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FD3 USING gb18030));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONVERT(_ucs2 0x1FE3 USING gb18030));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0535 USING gb18030), CONVERT(_ucs2 0x0552 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0565 USING gb18030), CONVERT(_ucs2 0x0552 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0535 USING gb18030), CONVERT(_ucs2 0x0582 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0565 USING gb18030), CONVERT(_ucs2 0x0582 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0048 USING gb18030), CONVERT(_ucs2 0x0331 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0068 USING gb18030), CONVERT(_ucs2 0x0331 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0054 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0074 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0057 USING gb18030), CONVERT(_ucs2 0x030A USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0077 USING gb18030), CONVERT(_ucs2 0x030A USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0059 USING gb18030), CONVERT(_ucs2 0x030A USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0079 USING gb18030), CONVERT(_ucs2 0x030A USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0041 USING gb18030), CONVERT(_ucs2 0x02BE USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0061 USING gb18030), CONVERT(_ucs2 0x02BE USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x1F50 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x1F50 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x1F50 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0399 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03B9 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0399 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03B9 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0399 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03B9 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0399 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03B9 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0300 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0301 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A1 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C1 USING gb18030), CONVERT(_ucs2 0x0313 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03A5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x03C5 USING gb18030), CONVERT(_ucs2 0x0308 USING gb18030), CONVERT(_ucs2 0x0342 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0xFB00 USING gb18030), CONVERT(_ucs2 0x0049 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0xFB00 USING gb18030), CONVERT(_ucs2 0x0069 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0xFB01 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0xFB01 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0xFB00 USING gb18030), CONVERT(_ucs2 0x004C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0xFB00 USING gb18030), CONVERT(_ucs2 0x006C USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0046 USING gb18030), CONVERT(_ucs2 0xFB02 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0066 USING gb18030), CONVERT(_ucs2 0xFB02 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0053 USING gb18030), CONVERT(_ucs2 0x0054 USING gb18030)));
INSERT INTO t1 VALUES(CONCAT(CONVERT(_ucs2 0x0053 USING gb18030), CONVERT(_ucs2 0x0074 USING gb18030)));
