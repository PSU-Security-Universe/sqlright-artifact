set @Default_host_cache_size=(select if(if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))>2000,2000,if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))));
select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT @@GLOBAL.Host_Cache_Size;
set @Default_host_cache_size=(select if(if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))>2000,2000,if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))));
SET @@GLOBAL.Host_Cache_Size=DEFAULT;
select @@global.Host_Cache_Size=@Default_host_cache_size;
SET @@local.Host_Cache_Size=1;
SET @@session.Host_Cache_Size=1;
SET @@GLOBAL.Host_Cache_Size=1;
SET @@GLOBAL.Host_Cache_Size=DEFAULT;
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT @@GLOBAL.Host_Cache_Size = VARIABLE_VALUE FROM performance_schema.global_variables WHERE VARIABLE_NAME='Host_Cache_Size';
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
SELECT COUNT(VARIABLE_VALUE) FROM performance_schema.global_variables  WHERE VARIABLE_NAME='Host_Cache_Size';
SELECT @@Host_Cache_Size = @@GLOBAL.Host_Cache_Size;
SELECT COUNT(@@local.Host_Cache_Size);
SELECT COUNT(@@SESSION.Host_Cache_Size);
SELECT COUNT(@@GLOBAL.Host_Cache_Size);
SELECT Host_Cache_Size = @@SESSION.Host_Cache_Size;
SET @@GLOBAL.Host_Cache_Size=DEFAULT;