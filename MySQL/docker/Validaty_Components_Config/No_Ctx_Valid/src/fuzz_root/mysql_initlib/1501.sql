CREATE USER mysqltest_1@'127.0.0.1/255.255.255.255';
GRANT ALL ON test.* TO mysqltest_1@'127.0.0.1/255.255.255.255';
SHOW GRANTS FOR mysqltest_1@'127.0.0.1/255.255.255.255';
REVOKE ALL ON test.* FROM mysqltest_1@'127.0.0.1/255.255.255.255';
DROP USER mysqltest_1@'127.0.0.1/255.255.255.255';
SELECT USER();
SHOW PROCESSLIST;
SHOW VARIABLES LIKE 'skip_name_resolve';
SHOW GLOBAL VARIABLES LIKE 'skip_name_resolve';
SHOW SESSION VARIABLES LIKE 'skip_name_resolve';
SELECT @@skip_name_resolve;
SELECT @@LOCAL.skip_name_resolve;
SELECT @@GLOBAL.skip_name_resolve;
SET @@skip_name_resolve=0;
SET @@LOCAL.skip_name_resolve=0;
SET @@GLOBAL.skip_name_resolve=0;
CREATE USER b20438524@'%' IDENTIFIED BY 'pwd';
FLUSH PRIVILEGES;
FLUSH PRIVILEGES;
CREATE USER b20438524@'%' IDENTIFIED BY 'pwd';
FLUSH PRIVILEGES;
