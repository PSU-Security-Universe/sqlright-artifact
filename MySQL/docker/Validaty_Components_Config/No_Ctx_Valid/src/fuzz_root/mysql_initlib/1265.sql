SELECT CURRENT_USER();
SELECT CURRENT_USER();
FLUSH PRIVILEGES;
SELECT CURRENT_USER();
FLUSH PRIVILEGES;
SELECT CURRENT_USER();
SELECT CURRENT_USER();
SELECT CURRENT_USER();
SELECT CURRENT_USER();
SELECT CURRENT_USER();
SELECT CURRENT_USER();
SELECT CURRENT_USER();
CREATE TABLE mysql.t1(counter INT);
INSERT INTO mysql.t1 VALUES(0);
CALL mysql.p1();
SELECT CURRENT_USER();
CALL mysql.p1();
FLUSH STATUS;
SHOW STATUS LIKE 'Locked_connects';
SHOW STATUS LIKE 'Locked_connects';
FLUSH STATUS;
