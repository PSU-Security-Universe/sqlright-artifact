set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
CREATE USER 'kristofer';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer';
CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password';
CREATE USER 'kristofer2'@'localhost' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY 'secret2';
ALTER USER 'kristofer2'@'localhost' IDENTIFIED BY 'secret2';
SELECT USER(),CURRENT_USER();
SHOW GRANTS FOR 'kristofer'@'localhost';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';
DROP USER 'kristofer2'@'localhost';
CREATE USER 'kristofer'@'localhost';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY '';
SELECT USER(),CURRENT_USER();
SHOW GRANTS FOR 'kristofer'@'localhost';
DROP USER 'kristofer'@'localhost';
CREATE USER 'kristofer'@'33.33.33.33';
ALTER USER 'kristofer'@'33.33.33.33' IDENTIFIED BY '';
DROP USER 'kristofer'@'33.33.33.33';
CREATE USER 'kristofer'@'localhost' IDENTIFIED BY 'awesomeness';
SELECT USER(),CURRENT_USER();
SHOW GRANTS FOR 'kristofer'@'localhost';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY '';
DROP USER 'kristofer'@'localhost';
set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;