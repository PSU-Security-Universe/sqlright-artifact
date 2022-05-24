USE test;
RESET MASTER;
RESET REPLICA ALL FOR CHANNEL '';
USE test;
RESET MASTER;
RESET REPLICA ALL FOR CHANNEL '';
START REPLICA ;
SELECT ATTR_NAME, ATTR_VALUE FROM performance_schema.session_connect_attrs WHERE PROCESSLIST_ID = 12 AND ATTR_NAME IN ('program_name', '_client_replication_channel_name', '_client_role');
STOP REPLICA ;
KILL 12;
SELECT ATTR_NAME, ATTR_VALUE FROM performance_schema.session_connect_attrs WHERE PROCESSLIST_ID = 15 AND ATTR_NAME IN ('program_name', '_client_replication_channel_name', '_client_role');
KILL 15;
SELECT asynchronous_connection_failover_reset();
SELECT asynchronous_connection_failover_reset();
