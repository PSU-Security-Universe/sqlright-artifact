select @@GLOBAL.relay_log_info_repository into @save_relay_log_info_repository;
select @@GLOBAL.expire_logs_days into @save_expire_logs_days;
set @@GLOBAL.relay_log_info_repository = 'FILE';
flush logs;
set global expire_logs_days = 3;
show variables like 'log_bin%';
show variables like 'relay_log%';
flush logs;
show variables like 'log_bin%';
show variables like 'relay_log%';
set @@GLOBAL.relay_log_info_repository = @save_relay_log_info_repository;
set @@GLOBAL.expire_logs_days = @save_expire_logs_days;
