SELECT PLUGIN_NAME, PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS WHERE PLUGIN_NAME IN ('test_plugin_server', 'qa_auth_server') ORDER BY 1;