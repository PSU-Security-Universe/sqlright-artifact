drop table if exists t1, t2;
create table t2 (code binary(1));
insert into t2 values (0xA1),(0xA2),(0xA3),(0xA4),(0xA5),(0xA6),(0xA7);
insert into t2 values (0xA8),(0xA9),(0xAA),(0xAB),(0xAC),(0xAD),(0xAE),(0xAF);
insert into t2 values (0xB0),(0xB1),(0xB2),(0xB3),(0xB4),(0xB5),(0xB6),(0xB7);
insert into t2 values (0xB8),(0xB9),(0xBA),(0xBB),(0xBC),(0xBD),(0xBE),(0xBF);
insert into t2 values (0xC0),(0xC1),(0xC2),(0xC3),(0xC4),(0xC5),(0xC6),(0xC7);
insert into t2 values (0xC8),(0xC9),(0xCA),(0xCB),(0xCC),(0xCD),(0xCE),(0xCF);
insert into t2 values (0xD0),(0xD1),(0xD2),(0xD3),(0xD4),(0xD5),(0xD6),(0xD7);
insert into t2 values (0xD8),(0xD9),(0xDA),(0xDB),(0xDC),(0xDD),(0xDE),(0xDF);
insert into t2 values (0xE0),(0xE1),(0xE2),(0xE3),(0xE4),(0xE5),(0xE6),(0xE7);
insert into t2 values (0xE8),(0xE9),(0xEA),(0xEB),(0xEC),(0xED),(0xEE),(0xEF);
insert into t2 values (0xF0),(0xF1),(0xF2),(0xF3),(0xF4),(0xF5),(0xF6),(0xF7);
insert into t2 values (0xF8),(0xF9),(0xFA),(0xFB),(0xFC),(0xFD),(0xFE);
create table t1 ( ujis varchar(1) character set ujis collate ujis_bin primary key, ucs2 varchar(1) character set ucs2 not null default '', ujis2 varchar(1) character set ujis not null default '', name varchar(64) character set ujis not null default '' );
insert into t1 set ujis=0x00, name='U+0000 NULL';
insert into t1 set ujis=0x01, name='U+0001 START OF HEADING';
insert into t1 set ujis=0x02, name='U+0002 START OF TEXT';
insert into t1 set ujis=0x03, name='U+0003 END OF TEXT';
insert into t1 set ujis=0x04, name='U+0004 END OF TRANSMISSION';
insert into t1 set ujis=0x05, name='U+0005 ENQUIRY';
insert into t1 set ujis=0x06, name='U+0006 ACKNOWLEDGE';
insert into t1 set ujis=0x07, name='U+0007 BELL';
insert into t1 set ujis=0x08, name='U+0008 BACKSPACE';
insert into t1 set ujis=0x09, name='U+0009 HORIZONTAL TABULATION';
insert into t1 set ujis=0x0A, name='U+000A LINE FEED';
insert into t1 set ujis=0x0B, name='U+000B VERTICAL TABULATION';
insert into t1 set ujis=0x0C, name='U+000C FORM FEED';
insert into t1 set ujis=0x0D, name='U+000D CARRIAGE RETURN';
insert into t1 set ujis=0x0E, name='U+000E SHIFT OUT';
insert into t1 set ujis=0x0F, name='U+000F SHIFT IN';
insert into t1 set ujis=0x10, name='U+0010 DATA LINK ESCAPE';
insert into t1 set ujis=0x11, name='U+0011 DEVICE CONTROL ONE';
insert into t1 set ujis=0x12, name='U+0012 DEVICE CONTROL TWO';
insert into t1 set ujis=0x13, name='U+0013 DEVICE CONTROL THREE';
insert into t1 set ujis=0x14, name='U+0014 DEVICE CONTROL FOUR';
insert into t1 set ujis=0x15, name='U+0015 NEGATIVE ACKNOWLEDGE';
insert into t1 set ujis=0x16, name='U+0016 SYNCHRONOUS IDLE';
insert into t1 set ujis=0x17, name='U+0017 END OF TRANSMISSION BLOCK';
insert into t1 set ujis=0x18, name='U+0018 CANCEL';
insert into t1 set ujis=0x19, name='U+0019 END OF MEDIUM';
insert into t1 set ujis=0x1A, name='U+001A SUBSTITUTE';
insert into t1 set ujis=0x1B, name='U+001B ESCAPE';
insert into t1 set ujis=0x1C, name='U+001C FILE SEPARATOR';
insert into t1 set ujis=0x1D, name='U+001D GROUP SEPARATOR';
insert into t1 set ujis=0x1E, name='U+001E RECORD SEPARATOR';
insert into t1 set ujis=0x1F, name='U+001F UNIT SEPARATOR';
insert into t1 set ujis=0x20, name='U+0020 SPACE';
insert into t1 set ujis=0x21, name='U+0021 EXCLAMATION MARK';
insert into t1 set ujis=0x22, name='U+0022 QUOTATION MARK';
insert into t1 set ujis=0x23, name='U+0023 NUMBER SIGN';
insert into t1 set ujis=0x24, name='U+0024 DOLLAR SIGN';
insert into t1 set ujis=0x25, name='U+0025 PERCENT SIGN';
insert into t1 set ujis=0x26, name='U+0026 AMPERSAND';
insert into t1 set ujis=0x27, name='U+0027 APOSTROPHE';
insert into t1 set ujis=0x28, name='U+0028 LEFT PARENTHESIS';
insert into t1 set ujis=0x29, name='U+0029 RIGHT PARENTHESIS';
insert into t1 set ujis=0x2A, name='U+002A ASTERISK';
insert into t1 set ujis=0x2B, name='U+002B PLUS SIGN';
insert into t1 set ujis=0x2C, name='U+002C COMMA';
insert into t1 set ujis=0x2D, name='U+002D HYPHEN-MINUS';
insert into t1 set ujis=0x2E, name='U+002E FULL STOP';
insert into t1 set ujis=0x2F, name='U+002F SOLIDUS';
insert into t1 set ujis=0x30, name='U+0030 DIGIT ZERO';
insert into t1 set ujis=0x31, name='U+0031 DIGIT ONE';
insert into t1 set ujis=0x32, name='U+0032 DIGIT TWO';
insert into t1 set ujis=0x33, name='U+0033 DIGIT THREE';
insert into t1 set ujis=0x34, name='U+0034 DIGIT FOUR';
insert into t1 set ujis=0x35, name='U+0035 DIGIT FIVE';
insert into t1 set ujis=0x36, name='U+0036 DIGIT SIX';
insert into t1 set ujis=0x37, name='U+0037 DIGIT SEVEN';
insert into t1 set ujis=0x38, name='U+0038 DIGIT EIGHT';
insert into t1 set ujis=0x39, name='U+0039 DIGIT NINE';
insert into t1 set ujis=0x3A, name='U+003A COLON';
insert into t1 set ujis=0x3B, name='U+003B SEMICOLON';
insert into t1 set ujis=0x3C, name='U+003C LESS-THAN SIGN';
insert into t1 set ujis=0x3D, name='U+003D EQUALS SIGN';
insert into t1 set ujis=0x3E, name='U+003E GREATER-THAN SIGN';
insert into t1 set ujis=0x3F, name='U+003F QUESTION MARK';
insert into t1 set ujis=0x40, name='U+0040 COMMERCIAL AT';
insert into t1 set ujis=0x41, name='U+0041 LATIN CAPITAL LETTER A';
insert into t1 set ujis=0x42, name='U+0042 LATIN CAPITAL LETTER B';
insert into t1 set ujis=0x43, name='U+0043 LATIN CAPITAL LETTER C';
insert into t1 set ujis=0x44, name='U+0044 LATIN CAPITAL LETTER D';
insert into t1 set ujis=0x45, name='U+0045 LATIN CAPITAL LETTER E';
insert into t1 set ujis=0x46, name='U+0046 LATIN CAPITAL LETTER F';
insert into t1 set ujis=0x47, name='U+0047 LATIN CAPITAL LETTER G';
insert into t1 set ujis=0x48, name='U+0048 LATIN CAPITAL LETTER H';
insert into t1 set ujis=0x49, name='U+0049 LATIN CAPITAL LETTER I';
insert into t1 set ujis=0x4A, name='U+004A LATIN CAPITAL LETTER J';
insert into t1 set ujis=0x4B, name='U+004B LATIN CAPITAL LETTER K';
insert into t1 set ujis=0x4C, name='U+004C LATIN CAPITAL LETTER L';
insert into t1 set ujis=0x4D, name='U+004D LATIN CAPITAL LETTER M';
insert into t1 set ujis=0x4E, name='U+004E LATIN CAPITAL LETTER N';
insert into t1 set ujis=0x4F, name='U+004F LATIN CAPITAL LETTER O';
insert into t1 set ujis=0x50, name='U+0050 LATIN CAPITAL LETTER P';
insert into t1 set ujis=0x51, name='U+0051 LATIN CAPITAL LETTER Q';
insert into t1 set ujis=0x52, name='U+0052 LATIN CAPITAL LETTER R';
insert into t1 set ujis=0x53, name='U+0053 LATIN CAPITAL LETTER S';
insert into t1 set ujis=0x54, name='U+0054 LATIN CAPITAL LETTER T';
insert into t1 set ujis=0x55, name='U+0055 LATIN CAPITAL LETTER U';
insert into t1 set ujis=0x56, name='U+0056 LATIN CAPITAL LETTER V';
insert into t1 set ujis=0x57, name='U+0057 LATIN CAPITAL LETTER W';
insert into t1 set ujis=0x58, name='U+0058 LATIN CAPITAL LETTER X';
insert into t1 set ujis=0x59, name='U+0059 LATIN CAPITAL LETTER Y';
insert into t1 set ujis=0x5A, name='U+005A LATIN CAPITAL LETTER Z';
insert into t1 set ujis=0x5B, name='U+005B LEFT SQUARE BRACKET';
insert into t1 set ujis=0x5C, name='U+005C REVERSE SOLIDUS';
insert into t1 set ujis=0x5D, name='U+005D RIGHT SQUARE BRACKET';
insert into t1 set ujis=0x5E, name='U+005E CIRCUMFLEX ACCENT';
insert into t1 set ujis=0x5F, name='U+005F LOW LINE';
insert into t1 set ujis=0x60, name='U+0060 GRAVE ACCENT';
insert into t1 set ujis=0x61, name='U+0061 LATIN SMALL LETTER A';
insert into t1 set ujis=0x62, name='U+0062 LATIN SMALL LETTER B';
insert into t1 set ujis=0x63, name='U+0063 LATIN SMALL LETTER C';
insert into t1 set ujis=0x64, name='U+0064 LATIN SMALL LETTER D';
insert into t1 set ujis=0x65, name='U+0065 LATIN SMALL LETTER E';
insert into t1 set ujis=0x66, name='U+0066 LATIN SMALL LETTER F';
insert into t1 set ujis=0x67, name='U+0067 LATIN SMALL LETTER G';
insert into t1 set ujis=0x68, name='U+0068 LATIN SMALL LETTER H';
insert into t1 set ujis=0x69, name='U+0069 LATIN SMALL LETTER I';
insert into t1 set ujis=0x6A, name='U+006A LATIN SMALL LETTER J';
