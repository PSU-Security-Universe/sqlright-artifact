CREATE USER 'kristofer' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer';
CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
CREATE USER 'kristofer2'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY 'secret2';
ALTER USER 'kristofer2'@'localhost' IDENTIFIED BY 'secret2';
SELECT USER(),CURRENT_USER();
SHOW CREATE USER 'kristofer'@'localhost';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';
DROP USER 'kristofer2'@'localhost';
CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY '';
SELECT USER(),CURRENT_USER();
SHOW CREATE USER 'kristofer'@'localhost';
DROP USER 'kristofer'@'localhost';
CREATE USER 'kristofer'@'33.33.33.33' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'33.33.33.33' IDENTIFIED BY '';
DROP USER 'kristofer'@'33.33.33.33';
CREATE USER 'kristofer' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
SELECT USER(),CURRENT_USER();
FLUSH PRIVILEGES;
FLUSH PRIVILEGES;
DROP USER kristofer;
