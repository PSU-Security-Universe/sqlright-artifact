CREATE DATABASE test_zone;
USE test_zone;
CREATE TABLE time_zone as SELECT * FROM mysql.time_zone WHERE 1 = 0;
CREATE TABLE time_zone_leap_second as SELECT * FROM mysql.time_zone_leap_second WHERE 1 = 0;
CREATE TABLE time_zone_name as SELECT * FROM mysql.time_zone_name WHERE 1 = 0;
CREATE TABLE time_zone_transition as SELECT * FROM mysql.time_zone_transition WHERE 1 = 0;
CREATE TABLE time_zone_transition_type as SELECT * FROM mysql.time_zone_transition_type WHERE 1 = 0;
START TRANSACTION;
INSERT INTO time_zone (Use_leap_seconds) VALUES ('N');
SET @time_zone_id= LAST_INSERT_ID();
INSERT INTO time_zone_name (Name, Time_zone_id) VALUES ('test_japan', @time_zone_id);
INSERT INTO time_zone_transition (Time_zone_id, Transition_time, Transition_type_id) VALUES (@time_zone_id, -1009875600, 2) ,(@time_zone_id, -683794800, 1) ,(@time_zone_id, -672393600, 2) ,(@time_zone_id, -654764400, 1) ,(@time_zone_id, -640944000, 2) ,(@time_zone_id, -620290800, 1) ,(@time_zone_id, -609494400, 2) ,(@time_zone_id, -588841200, 1) ,(@time_zone_id, -578044800, 2) ;
INSERT INTO time_zone_transition_type (Time_zone_id, Transition_type_id, Offset, Is_DST, Abbreviation) VALUES (@time_zone_id, 0, 32400, 0, 'CJT') ,(@time_zone_id, 1, 36000, 1, 'JDT') ,(@time_zone_id, 2, 32400, 0, 'JST') ;
COMMIT;
TRUNCATE TABLE time_zone_leap_second;
START TRANSACTION;
INSERT INTO time_zone_leap_second (Transition_time, Correction) VALUES (78796800, 1) ,(94694401, 2) ,(126230402, 3) ,(157766403, 4) ,(189302404, 5) ,(220924805, 6) ,(252460806, 7) ,(283996807, 8) ,(315532808, 9) ,(362793609, 10) ,(394329610, 11) ,(425865611, 12) ,(489024012, 13) ,(567993613, 14) ,(631152014, 15) ,(662688015, 16) ,(709948816, 17) ,(741484817, 18) ,(773020818, 19) ,(820454419, 20) ,(867715220, 21) ,(915148821, 22) ,(1136073622, 23) ,(1230768023, 24) ;
COMMIT;
TRUNCATE TABLE time_zone;
TRUNCATE TABLE time_zone_name;
TRUNCATE TABLE time_zone_transition;
TRUNCATE TABLE time_zone_transition_type;
START TRANSACTION;
INSERT INTO time_zone (Use_leap_seconds) VALUES ('N');
SET @time_zone_id= LAST_INSERT_ID();
INSERT INTO time_zone_name (Name, Time_zone_id) VALUES ('Berlin', @time_zone_id);
INSERT INTO time_zone_transition_type (Time_zone_id, Transition_type_id, Offset, Is_DST, Abbreviation) VALUES (@time_zone_id, 0, 7200, 1, 'CEST') ,(@time_zone_id, 1, 3600, 0, 'CET') ,(@time_zone_id, 2, 7200, 1, 'CEST') ,(@time_zone_id, 3, 3600, 0, 'CET') ,(@time_zone_id, 4, 10800, 1, 'CEMT') ,(@time_zone_id, 5, 10800, 1, 'CEMT') ,(@time_zone_id, 6, 7200, 1, 'CEST') ,(@time_zone_id, 7, 3600, 0, 'CET') ;
INSERT INTO time_zone (Use_leap_seconds) VALUES ('N');
SET @time_zone_id= LAST_INSERT_ID();
INSERT INTO time_zone_name (Name, Time_zone_id) VALUES ('London', @time_zone_id);
INSERT INTO time_zone_transition_type (Time_zone_id, Transition_type_id, Offset, Is_DST, Abbreviation) VALUES (@time_zone_id, 0, 3600, 1, 'BST') ,(@time_zone_id, 1, 0, 0, 'GMT') ,(@time_zone_id, 2, 7200, 1, 'BDST') ,(@time_zone_id, 3, 3600, 0, 'BST') ,(@time_zone_id, 4, 3600, 1, 'BST') ,(@time_zone_id, 5, 0, 0, 'GMT') ,(@time_zone_id, 6, 0, 0, 'GMT') ;
INSERT INTO time_zone (Use_leap_seconds) VALUES ('N');
SET @time_zone_id= LAST_INSERT_ID();
INSERT INTO time_zone_name (Name, Time_zone_id) VALUES ('Paris', @time_zone_id);
INSERT INTO time_zone_transition_type (Time_zone_id, Transition_type_id, Offset, Is_DST, Abbreviation) VALUES (@time_zone_id, 0, 561, 0, 'PMT') ,(@time_zone_id, 1, 3600, 1, 'WEST') ,(@time_zone_id, 2, 0, 0, 'WET') ,(@time_zone_id, 3, 3600, 1, 'WEST') ,(@time_zone_id, 4, 0, 0, 'WET') ,(@time_zone_id, 5, 3600, 0, 'CET') ,(@time_zone_id, 6, 7200, 1, 'CEST') ,(@time_zone_id, 7, 7200, 1, 'CEST') ,(@time_zone_id, 8, 7200, 1, 'WEMT') ,(@time_zone_id, 9, 3600, 0, 'CET') ,(@time_zone_id, 10, 7200, 1, 'CEST') ,(@time_zone_id, 11, 3600, 0, 'CET') ;
COMMIT;
DROP DATABASE test_zone;
