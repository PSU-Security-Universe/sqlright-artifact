CREATE DATABASE test_user_db;
CREATE USER qa_test_1_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_1_dest';
CREATE USER qa_test_1_dest IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_1_dest;
GRANT PROXY ON qa_test_1_dest TO qa_test_1_user;
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_1_user;
SELECT @@proxy_user;
SELECT @@external_user;
DROP USER qa_test_1_user;
DROP USER qa_test_1_dest;
CREATE USER qa_test_2_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_2_dest';
CREATE USER qa_test_2_dest IDENTIFIED BY 'dest_passwd';
CREATE USER authenticated_as IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_2_dest;
GRANT ALL PRIVILEGES ON test_user_db.* TO authenticated_as;
GRANT PROXY ON qa_test_2_dest TO qa_test_2_user;
GRANT PROXY ON authenticated_as TO qa_test_2_user;
SELECT @@proxy_user;
SELECT @@external_user;
DROP USER qa_test_2_user;
DROP USER qa_test_2_dest;
DROP USER authenticated_as;
CREATE USER qa_test_3_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_3_dest';
CREATE USER qa_test_3_dest IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_3_dest;
GRANT PROXY ON qa_test_3_dest TO qa_test_3_user;
DROP USER qa_test_3_user;
DROP USER qa_test_3_dest;
CREATE USER qa_test_4_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_4_dest';
CREATE USER qa_test_4_dest IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_4_dest;
GRANT PROXY ON qa_test_4_dest TO qa_test_4_user;
DROP USER qa_test_4_user;
DROP USER qa_test_4_dest;
CREATE USER qa_test_5_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_5_dest';
CREATE USER qa_test_5_dest IDENTIFIED BY 'dest_passwd';
CREATE USER ''@'localhost' IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_5_dest;
GRANT ALL PRIVILEGES ON test_user_db.* TO ''@'localhost';
GRANT PROXY ON qa_test_5_dest TO qa_test_5_user;
GRANT PROXY ON qa_test_5_dest TO ''@'localhost';
DROP USER qa_test_5_user;
DROP USER qa_test_5_dest;
DROP USER ''@'localhost';
CREATE USER qa_test_6_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_6_dest';
CREATE USER qa_test_6_dest IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_6_dest;
GRANT PROXY ON qa_test_6_dest TO qa_test_6_user;
DROP USER qa_test_6_user;
DROP USER qa_test_6_dest;
CREATE USER qa_test_11_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_11_dest';
CREATE USER qa_test_11_dest IDENTIFIED BY 'dest_passwd';
GRANT ALL PRIVILEGES ON test_user_db.* TO qa_test_11_dest;
GRANT PROXY ON qa_test_11_dest TO qa_test_11_user;
DROP USER qa_test_11_user, qa_test_11_dest;
DROP DATABASE test_user_db;
