RESET MASTER;
CREATE RESOURCE GROUP u1 TYPE=USER VCPU=0-2;
ALTER RESOURCE GROUP u1 VCPU=3;
SET RESOURCE GROUP u1;
SELECT RESOURCE_GROUP_NAME FROM INFORMATION_SCHEMA.RESOURCE_GROUPS;
DROP RESOURCE GROUP u1 FORCE;
SELECT RESOURCE_GROUP_NAME FROM INFORMATION_SCHEMA.RESOURCE_GROUPS;
