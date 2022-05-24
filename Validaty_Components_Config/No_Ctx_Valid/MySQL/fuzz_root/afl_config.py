import os

mysql_root_dir = "/home/sly/Desktop/SQLRight/mysql_source/mysql-server-block-inst/mysql-server-mysql-8.0.27/bld_black_list"
mysql_src_data_dir = os.path.join(mysql_root_dir, "data_all/ori_data")
current_workdir = os.getcwd()

starting_core_id = 0
parallel_num = 3
port_starting_num = 9000

MYSQL_REBOOT_TIME_GAP = 60