CREATE ROLE role;
DROP ROLE role;
CREATE ROLE `ident with space`;
CREATE ROLE 'text string';
CREATE ROLE role@host;
DROP ROLE role@host;
CREATE ROLE 'role'@`host`;
CREATE ROLE IF NOT EXISTS 'role'@'host';
DROP ROLE 'role'@`host`;
CREATE ROLE `role`@host;
DROP ROLE `role`@host;
CREATE ROLE `role`@`host`;
DROP ROLE `role`@`host`;
CREATE ROLE role, role1, role2;
CREATE ROLE r1 IDENTIFIED BY 'test';
CREATE ROLE IF NOT EXISTS role1, role2;
GRANT 'role' TO role1;
SHOW STATUS LIKE '%acl_cache%';
SELECT count_alloc - count_free FROM performance_schema.memory_summary_global_by_event_name WHERE event_name LIKE '%acl_map_cache';
CREATE USER user1, user2, user3@host3;
GRANT role1 TO user1;
CREATE ROLE role2@host2;
CREATE ROLE role3;
GRANT role1, `role2`@`host2`, role3 TO user1, user2, `user3`@`host3`;
GRANT sys_role TO peter@clickhost.net;
GRANT role1 TO peter@clickhost.net;
GRANT sys_role TO user1;
CREATE USER joan;
CREATE USER sally;
CREATE ROLE engineering;
CREATE ROLE consultants;
CREATE ROLE qa;
GRANT engineering TO joan;
GRANT engineering TO sally;
GRANT engineering, consultants TO joan, sally;
GRANT qa TO consultants;
CREATE ROLE `engineering`@`US`;
CREATE ROLE `engineering`@`INDIA`;
GRANT `engineering`@`US` TO `engineering`@`INDIA`;
CREATE ROLE `wp_administrators`;
CREATE USER `joe`@`localhost`;
GRANT SELECT ON test.* TO wp_administrators;
GRANT SUPER, engineering ON *.* TO joan, sally;
GRANT engineering,SELECT ON *.* TO joan;
REVOKE engineering ON *.* FROM joan, sally;
REVOKE wp_administrators, engineering ON *.* FROM joan, sally;
GRANT 'role',engineering TO current_user();
SET ROLE 'role';
SELECT CURRENT_ROLE();
SET ROLE role1, role2;
SELECT CURRENT_ROLE();
SET ROLE `role`;
SELECT CURRENT_ROLE();
SET ROLE role1, role2;
SELECT CURRENT_ROLE();
SET ROLE NONE;
SELECT CURRENT_ROLE();
SET ROLE none;
SELECT CURRENT_ROLE();
SET ROLE engineering, 'role';
SELECT CURRENT_ROLE();
SET ROLE DEFAULT;
SELECT CURRENT_ROLE();
SET ROLE ALL;
SELECT CURRENT_ROLE();
SET ROLE ALL EXCEPT role1;
SELECT CURRENT_ROLE();
SHOW GRANTS FOR current_user() USING `engineering`@`%`,`role`@`%`;
GRANT role1 TO current_user();
SET ROLE ALL EXCEPT role1;
SELECT CURRENT_ROLE();
SET ROLE ALL;
SELECT CURRENT_ROLE();
SHOW STATUS LIKE '%acl_cache%';
REVOKE 'role' FROM role1;
REVOKE role1, `role2`@`host2`, role3 FROM user1, user2, `user3`@`host3`;
REVOKE engineering FROM managers;
REVOKE engineering FROM joan;
SELECT ExtractValue(ROLES_GRAPHML(),'count(//node)') as num_nodes;
SELECT ExtractValue(ROLES_GRAPHML(),'count(//edge)') as num_edges;
DROP ROLE 'role';
DROP ROLE IF EXISTS 'role';
DROP ROLE IF EXISTS role1, role2;
DROP ROLE IF EXISTS `role`, `role`@`host`;
DROP ROLE 'role';
SELECT ExtractValue(ROLES_GRAPHML(),'count(//node)') as num_nodes;
SELECT ExtractValue(ROLES_GRAPHML(),'count(//edge)') as num_edges;
ALTER USER `joe`@`localhost` DEFAULT ROLE wp_administrators;
ALTER USER `joe`@`localhost` DEFAULT ROLE wp_administrators,engineering;
ALTER USER `joe`@`localhost` DEFAULT ROLE wp_administrators;
ALTER USER CURRENT_USER() DEFAULT ROLE NONE;
FLUSH PRIVILEGES;
SHOW GRANTS FOR `wp_administrators`;
SHOW GRANTS FOR `joe`@`localhost`;
