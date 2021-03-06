SELECT LENGTH(VARIABLE_VALUE) > 0 FROM performance_schema.session_status WHERE VARIABLE_NAME='Ssl_cipher';
ALTER INSTANCE RELOAD TLS;
SELECT LENGTH(VARIABLE_VALUE) > 0 FROM performance_schema.session_status WHERE VARIABLE_NAME='Ssl_cipher';
SET @must_be_present= 'present';
ALTER INSTANCE RELOAD TLS;
SELECT @must_be_present;
SET @orig_ssl_cipher = @@global.ssl_cipher;
SET @orig_tls_version = @@global.tls_version;
SHOW STATUS LIKE 'Ssl_cipher';
SET GLOBAL ssl_cipher = "DHE-RSA-AES256-SHA256";
SET GLOBAL tls_version = "TLSv1.2";
ALTER INSTANCE RELOAD TLS;
SHOW STATUS LIKE 'Ssl_cipher';
SET GLOBAL ssl_cipher = @orig_ssl_cipher;
SET GLOBAL tls_version = @orig_tls_version;
ALTER INSTANCE RELOAD TLS;
SET @orig_ssl_cipher = @@global.ssl_cipher;
SET GLOBAL ssl_cipher = "DHE-RSA-AES256-SHA256";
SET GLOBAL ssl_cipher = @orig_ssl_cipher;
ALTER INSTANCE RELOAD TLS;
ALTER INSTANCE RELOAD TLS;
ALTER INSTANCE RELOAD TLS;
SET @orig_ssl_ca= @@global.ssl_ca;
SET GLOBAL ssl_ca = 'gizmo';
ALTER INSTANCE RELOAD TLS;
SELECT COUNT(*) FROM performance_schema.session_status WHERE VARIABLE_NAME = 'Current_tls_ca' AND VARIABLE_VALUE = @orig_ssl_ca;
SELECT @@global.ssl_ca;
ALTER INSTANCE RELOAD TLS NO ROLLBACK ON ERROR;
SELECT COUNT(*) FROM performance_schema.session_status WHERE VARIABLE_NAME = 'Current_tls_ca' AND VARIABLE_VALUE = 'gizmo';
SET GLOBAL ssl_ca = @orig_ssl_ca;
ALTER INSTANCE RELOAD TLS;
SET @orig_ssl_ca= @@global.ssl_ca;
SET @orig_ssl_cert= @@global.ssl_cert;
SET @orig_ssl_key= @@global.ssl_key;
SET @orig_ssl_capath= @@global.ssl_capath;
SET @orig_ssl_crl= @@global.ssl_crl;
SET @orig_ssl_crlpath= @@global.ssl_crlpath;
SET @orig_ssl_cipher= @@global.ssl_cipher;
SET @orig_tls_cipher= @@global.tls_ciphersuites;
SET @orig_tls_version= @@global.tls_version;
SET GLOBAL ssl_ca = 'gizmo';
SET GLOBAL ssl_cert = 'gizmo';
SET GLOBAL ssl_key = 'gizmo';
SET GLOBAL ssl_capath = 'gizmo';
SET GLOBAL ssl_crl = 'gizmo';
SET GLOBAL ssl_crlpath = 'gizmo';
SET GLOBAL ssl_cipher = 'gizmo';
SET GLOBAL tls_ciphersuites = 'gizmo';
SET GLOBAL tls_version = 'gizmo';
SET SESSION ssl_ca = 'gizmo';
SET SESSION ssl_cert = 'gizmo';
SET SESSION ssl_key = 'gizmo';
SET SESSION ssl_capath = 'gizmo';
SET SESSION ssl_crl = 'gizmo';
SET SESSION ssl_crlpath = 'gizmo';
SET SESSION ssl_cipher = 'gizmo';
SET SESSION tls_ciphersuites = 'gizmo';
SET SESSION tls_version = 'gizmo';
SELECT VARIABLE_NAME FROM performance_schema.session_status WHERE VARIABLE_NAME IN ('Current_tls_ca', 'Current_tls_capath', 'Current_tls_cert', 'Current_tls_key', 'Current_tls_version', 'Current_tls_cipher', 'Current_tls_ciphersuites', 'Current_tls_crl', 'Current_tls_crlpath') AND VARIABLE_VALUE != 'gizmo'   ORDER BY VARIABLE_NAME;
SET GLOBAL ssl_ca = @orig_ssl_ca;
SET GLOBAL ssl_cert = @orig_ssl_cert;
SET GLOBAL ssl_key = @orig_ssl_key;
SET GLOBAL ssl_capath = @orig_ssl_capath;
SET GLOBAL ssl_crl = @orig_ssl_crl;
SET GLOBAL ssl_crlpath = @orig_ssl_crlpath;
SET GLOBAL ssl_cipher = @orig_ssl_cipher;
SET GLOBAL tls_ciphersuites = @orig_tls_ciphersuites;
SET GLOBAL tls_version = @orig_tls_version;
SET @orig_ssl_ca= @@global.ssl_ca;
SET @orig_ssl_cert= @@global.ssl_cert;
SET @orig_ssl_key= @@global.ssl_key;
SET @orig_mysqlx_ssl_ca= @@global.mysqlx_ssl_ca;
SET @orig_mysqlx_ssl_cert= @@global.mysqlx_ssl_cert;
SET @orig_mysqlx_ssl_key= @@global.mysqlx_ssl_key;
SET GLOBAL ssl_cert = "/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/mysql-test/std_data/server-cert-sha512.pem";
SET GLOBAL ssl_key = "/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/mysql-test/std_data/server-key-sha512.pem";
SET GLOBAL ssl_ca = "/data/yu/Squirrel_DBMS_Fuzzing/MySQL_source/mysql-server-inst/mysql-test/std_data/ca-sha512.pem";
ALTER INSTANCE RELOAD TLS;
SELECT @@global.mysqlx_ssl_ca = @orig_mysqlx_ssl_ca, @@global.mysqlx_ssl_cert = @orig_mysqlx_ssl_cert, @@global.mysqlx_ssl_key = @orig_mysqlx_ssl_key;
SET GLOBAL ssl_cert = @orig_ssl_cert;
SET GLOBAL ssl_key = @orig_ssl_key;
SET GLOBAL ssl_ca = @orig_ssl_ca;
ALTER INSTANCE RELOAD TLS;
