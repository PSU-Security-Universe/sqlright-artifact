SET GLOBAL master_info_repository='TABLE';
SET GLOBAL relay_log_info_repository='TABLE';
CHANGE REPLICATION SOURCE TO SOURCE_HOST='127.0.0.1', SOURCE_LOG_FILE='binlog-ch1.000001', SOURCE_LOG_POS=4 FOR CHANNEL 'ch1';
CHANGE REPLICATION SOURCE TO SOURCE_HOST='127.0.0.1', SOURCE_LOG_FILE='binlog-ch2.000001', SOURCE_LOG_POS=4 FOR CHANNEL 'ch2';
STOP REPLICA ;
CHANGE REPLICATION SOURCE TO SOURCE_HOST='127.0.0.1', SOURCE_LOG_FILE="binlog-default.000001", SOURCE_LOG_POS=4 FOR CHANNEL '';
STOP REPLICA ;
RESET SLAVE ALL;
SET @@global.master_info_repository='TABLE';
SET @@global.relay_log_info_repository='TABLE';
