SET NAMES utf8mb4;
SET CHARACTER_SET_DATABASE = utf8mb4;
CREATE DATABASE `中文`;
CREATE DATABASE `数据库`;
SELECT schema_name, HEX(schema_name) FROM information_schema.schemata WHERE schema_name NOT IN ('mtr', 'sys') ORDER BY schema_name;
USE `数据库`;
USE `中文`;
DROP DATABASE `数据库`;
DROP DATABASE `中文`;
USE test;
CREATE TABLE `表格` (`字段一` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `模式` (`列列列` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `隞嗷㐁` (`列㐄㐅` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `表格`(`字段一` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `模式` (`列列列` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `隞嗷㐁` (`列㐄㐅` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `㐅㐅㐅` (`㐄㐄㐄` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TEMPORARY TABLE `㐇㐈㐉` (`㐐㐐㐐` CHAR(1)) DEFAULT CHARSET = utf8mb4;
DESC `表格`;
DESC `模式`;
DESC `隞嗷㐁`;
DESC `㐅㐅㐅`;
DESC `㐇㐈㐉`;
SHOW CREATE TABLE `表格`;
SHOW CREATE TABLE `模式`;
SHOW CREATE TABLE `隞嗷㐁`;
SHOW CREATE TABLE `㐅㐅㐅`;
SHOW CREATE TABLE `㐇㐈㐉`;
DROP TABLE `表格`, `模式`, `隞嗷㐁`, `㐅㐅㐅`, `㐇㐈㐉`;
CREATE TABLE `表格` (`字段一` CHAR(5)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `隞嗷㐁` (`㐂㐃㐄` CHAR(5)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表格` VALUES ('一二三四五'), ('六七八九十'), ('㐅㐆㐇㐈㐉');
INSERT INTO `隞嗷㐁` VALUES ('焊䏷菡釬'), ('漢汉漢汉漢'), ('㐃㐄㐇㐈㐀');
ALTER TABLE `表格` ADD `新字段一` CHAR(1) FIRST;
ALTER TABLE `表格` ADD `新字段二` CHAR(1) AFTER `字段一`;
ALTER TABLE `表格` ADD `新字段三` CHAR(1);
ALTER TABLE `表格` ADD INDEX (`新字段二`);
ALTER TABLE `表格` ADD PRIMARY KEY (`字段一`);
ALTER TABLE `表格` ADD UNIQUE (`新字段三`);
ALTER TABLE `表格` CHANGE `新字段二` `䑃䑃一` CHAR(1);
ALTER TABLE `表格` MODIFY `新字段三` CHAR(6);
SELECT * FROM `表格`;
DESC `表格`;
SHOW CREATE TABLE `表格`;
ALTER TABLE `表格` DROP INDEX `新字段二`;
ALTER TABLE `表格` DROP PRIMARY KEY;
ALTER TABLE `表格` DROP INDEX `新字段三`;
ALTER TABLE `表格` DROP `䑃䑃一`;
ALTER TABLE `表格` DROP `新字段一`;
ALTER TABLE `表格` DROP `新字段三`;
SELECT * FROM `表格`;
DESC `表格`;
SHOW CREATE TABLE `表格`;
DROP TABLE `表格`, `隞嗷㐁`;
CREATE TABLE `表一` (`字段一` char(5)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表一` VALUES ('繓𠻟作𤈼阼');
SELECT INSERT(`字段一`, 1, 1, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 4, 1, '𠻠') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '𠻠') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, '𠻠') FROM `表一`;
SELECT INSERT(`字段一`, 1, 1, ' ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '  ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '   ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '    ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '     ') FROM `表一`;
SELECT INSERT(`字段一`, 4, 1, ' ') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '  ') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, ' ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 1, '岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '岝岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '岝岝岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '岝岝岝岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 4, 1, '𠀂') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '𠀂𠀂') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, '𠀂') FROM `表一`;
UPDATE `表一` SET `字段一` = ('坐阼座岝𠀂');
SELECT * FROM `表一`;
DELETE FROM `表一` WHERE `字段一` = '繓𠻟作𤈼阼';
SELECT * FROM `表一`;
DELETE FROM `表一`;
SELECT * FROM `表一`;
CREATE TABLE `表二` (c CHAR(5), v VARCHAR(10), t TEXT) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表二` VALUES ('定长𤈼𠻜字', '变长𠀂𨡃𤈼字符串字段', '文本大对象𠻞𠻟𠻠字段');
SELECT * FROM `表二`;
TRUNCATE `表二`;
DROP TABLE `表一`, `表二`;
CREATE TABLE `表二` (e ENUM('口', '日', '目', '田', '晶'), INDEX(e)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表二` VALUES('田'), ('日'), ('目'), ('晶'), ('口');
SELECT * FROM `表二`;
ALTER TABLE `表二` ADD c CHAR(1) NOT NULL FIRST;
SHOW CREATE TABLE `表二`;
DESC `表二`;
DROP TABLE `表二`;
CREATE TABLE `表一` (c1 CHAR(20), INDEX(c1)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・・ºª©®™');
INSERT INTO `表一` VALUES ('¤№・・・・・・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・ΆΈΉΊΪ・Ό・ΎΫ・Ώ・・・');
INSERT INTO `表一` VALUES ('・άέήίϊΐόςύϋΰώ・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・ЂЃЄЅІЇ');
INSERT INTO `表一` VALUES ('ЈЉЊЋЌЎЏ・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES (' !"#$%&\'()*+,-./');
INSERT INTO `表一` VALUES ('0123456789:;<=>?');
INSERT INTO `表一` VALUES ('@ABCDEFGHIJKLMNO');
INSERT INTO `表一` VALUES ('PQRSTUVWXYZ[\\]^_');
INSERT INTO `表一` VALUES ('abcdefghijklmno');
INSERT INTO `表一` VALUES ('pqrstuvwxyz{|}~');
INSERT INTO `表一` VALUES ('・ÁÀÄÂĂǍĀĄÅÃĆĈČÇĊĎÉÈË');
INSERT INTO `表一` VALUES ('ÊĚĖĒĘ・ĜĞĢĠĤÍÌÏÎǏİĪĮĨ');
INSERT INTO `表一` VALUES ('ĴĶĹĽĻŃŇŅÑÓÒÖÔǑŐŌÕŔŘŖ');
INSERT INTO `表一` VALUES ('ŚŜŠŞŤŢÚÙÜÛŬǓŰŪŲŮŨǗǛǙ');
INSERT INTO `表一` VALUES ('ǕŴÝŸŶŹŽŻ・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・áàäâăǎāąåãćĉčçċďéèë');
INSERT INTO `表一` VALUES ('êěėēęǵĝğ・ġĥíìïîǐ・īįĩ');
INSERT INTO `表一` VALUES ('ĵķĺľļńňņñóòöôǒőōõŕřŗ');
INSERT INTO `表一` VALUES ('śŝšşťţúùüûŭǔűūųůũǘǜǚ');
INSERT INTO `表一` VALUES ('ǖŵýÿŷźžż・・・・・・・・・・・・');
