import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
from matplotlib.pyplot import MultipleLocator
import datetime
import numpy as np
import shutil
import paramiko
import matplotlib.ticker as mtick

pd.set_option('display.max_columns', None)

# print(plt.rcParams)
plt.figure(figsize=(6.2, 4))

plt.grid(True, which="major", ls="-")

plt.xticks(fontsize=20)
plt.yticks(fontsize=20)

ax = plt.gca()
ax.set_facecolor('#F6F5F5')

def download_plot_files(server_name, server_file_loc, local_file_loc, is_replace=False):
    server_ip = "localhost"
    port = 22
    if server_name == "BayFront":
        port = 8028
    elif server_name == "LakeSide":
        port = 8029
    else:
        port = 22

    if not os.path.isdir(local_file_loc):
        os.mkdir(local_file_loc)
    elif is_replace:
        shutil.rmtree(local_file_loc)
        os.mkdir(local_file_loc)
    else:
        print("Download file exists! Skipped. ")
        return

    if server_name == "BayFront" and server_file_loc == "":
        server_file_loc = "/home/luy70/Desktop/SQLRight/mysql_test/sqlright_NoREC/fuzz_root"
    if server_name == "LakeSide"  and server_file_loc == "":
        server_file_loc = "/home/luy70/Desktop/SQLRight/mysql_test/sqlright_drop_all/fuzz_root"

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    client.connect(server_ip, username="luy70", key_filename="/Users/sly/.ssh/sly-psu", port = port)

    sftp = client.open_sftp()

    for i in range(6):
        server_file_fd = os.path.join(server_file_loc, "outputs_" + str(i) + "/plot_data")
        local_file_fd =  os.path.join(local_file_loc, "plot_data_" + str(i))
        try:
            sftp.stat(server_file_fd)
        except IOError:
            break
        sftp.get(server_file_fd, local_file_fd)

    sftp.close()

def plot_with_style(x, y, style_id = 0, markevery=100):
    if style_id == 0:
        plt.plot(x, y, linestyle = (0, (3, 1, 1, 1, 1, 1)), marker = 'o', markevery=markevery, linewidth=4.0, markersize=10, color = 'r')
    elif style_id == 1:
        plt.plot(x, y, linestyle = 'dashed', marker = 'p', markevery=markevery, linewidth=4.0, markersize=10, color='darkorange')
    elif style_id == 2:
        plt.plot(x, y, linestyle = 'dotted', marker = '^', markevery=markevery, linewidth=4.0, markersize=10, color='tab:blue')
    elif style_id == 3:
        plt.plot(x, y, linestyle = 'dashed', marker = '*', markevery=markevery, linewidth=4.0, markersize=10, color = 'c')
    elif style_id == 4:
        plt.plot(x, y, linestyle = "dashdot", marker = "v", markevery=markevery, linewidth=4.0, markersize=10, color = 'tab:olive')
    else:
        plt.plot(x, y, linestyle = (0, (3, 1, 1, 1, 1, 1)), marker = 'o', markevery=markevery, linewidth=4.0, markersize=10)
    return


def plot_sql_bugs(file_dir, markevery, line_style):

    if not os.path.isdir(file_dir):
        print("Warning: Bug folder %s not exists. " % (file_dir))
        exit(1)

    file_dir = os.path.join(file_dir, "time.txt")

    # If the time.txt file not exists. Treat it as no bugs. 
    if not os.path.isfile(file_dir):
        print("time.txt file: %s not exists.  It could due to no active True Positive bugs being found after bisecting and filtering. Or the bisecting algorithm is not called. " % (file_dir))
        time_l = list(np.arange(0, 72.2, 0.2))
        bug_num_l = [0] * len(time_l)
        plot_with_style(time_l, bug_num_l, style_id=line_style, markevery=markevery)
        return
    
    file_fd = open(file_dir, 'r')
    all_file_lines = file_fd.readlines()

    all_bug_time = []
    for cur_line in all_file_lines:
        cur_line = cur_line.split(" ")[1]
        cur_line = float(cur_line)
        all_bug_time.append(cur_line)
    all_bug_time.sort()
    all_bug_time = [x / 3600.0 for x in all_bug_time]

    time_l = []
    bug_num_l = []
    bug_num = 0
    for i in np.arange(0, 72.2, 0.2):
        if len(all_bug_time) == 0:
            time_l.append(i)
            bug_num_l.append(bug_num)
            continue
        if i >= all_bug_time[0]:
            time_l.append(i)
            bug_num_l.append(bug_num)
            bug_num += 1
            time_l.append(i)
            bug_num_l.append(bug_num)

            if len(all_bug_time) > 1:
                all_bug_time = all_bug_time[1:]
            else:
                all_bug_time = []
        else:
            time_l.append(i)
            bug_num_l.append(bug_num)
        continue

    plot_with_style(time_l, bug_num_l, style_id=line_style, markevery=markevery)

def plot_sql_mapsize(file_dir, markevery, line_style, is_downsampling = True):
    # For SQLRight. Our main tool.
    all_time_delta = []
    all_map_size = []
    time_avg = []
    map_size_avg = []
    min_size = sys.maxsize

    """
        Find the longest run plot_data.
        In some rare cases, the fuzzing could stop in the middle, and cause the plot_data output incomplete.
        In order to get the latest and longest stable run,
        we pick the longest run plot_data available.
    """

    latest_time = 0
    file_name = ""
    for cur_file_name in os.listdir(file_dir):
        if "plot_data_" not in cur_file_name:
            continue
        cur_file_fd = pd.read_csv(os.path.join(file_dir, cur_file_name), error_bad_lines=False)
        last_idx = cur_file_fd['unix_time'].size - 1
        if last_idx < 10:
            print("For file: %s, too few entries are available. Skipped. " % (cur_file_name))
            continue
        cur_file_fd = cur_file_fd['unix_time'][last_idx] - cur_file_fd['unix_time'][0]
        if cur_file_fd > latest_time:
            latest_time = cur_file_fd
            file_name = os.path.join(file_dir, cur_file_name)

    if file_name == "":
        print("\n\n\nError: Cannot find plot_data_* file in dir %s, or all plot_data_* files are being skipped. Did you finish all the fuzzing and bisecting scripts? \n\n\n" % (cur_file_name))
        exit(1)
    
    for i in [0]:
        file = pd.read_csv(file_name, error_bad_lines=False)
        file['time'] = pd.to_datetime(file['unix_time'], unit='s')
        time_delta = []
        time_delta.append(0)
        time_start = file['time'][0]
        for cur_time in file['time'][1:]:
            tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
            tmp += pd.Timedelta(cur_time - time_start).days * 24
            time_delta.append(tmp)
    
        map_size = []
        map_size.append(0)
        for cur_map in file['map_size']:
            cur_map = cur_map.strip('%')
            cur_map = float(cur_map)
            map_size.append(cur_map)
    
        all_time_delta.append(time_delta)
        all_map_size.append(map_size)
        if len(time_delta) < min_size:
            min_size = len(time_delta)
    
    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)
    
        cur_map = 0
        for j in range(1):
            cur_map += all_map_size[j][i]
        cur_map = cur_map / 1
        map_size_avg.append(cur_map)
    
    
    map_size_avg = [x * 262 / 100 for x in map_size_avg]
    
    if is_downsampling:
        time_avg, map_size_avg = sample_plots(time_avg, map_size_avg, time_avg[-1], True)
    
    plot_with_style(time_avg, map_size_avg, style_id=line_style, markevery=markevery)
    return


def plot_sqlancer_mapsize(file_name, markevery=2600, line_style = 2, is_downsampling=True):
    # # SQLance
    all_time_delta = []
    all_map_size = []
    time_avg = []
    map_size_avg = []
    min_size = sys.maxsize
    
    for i in [0]:
        file = pd.read_csv(file_name, error_bad_lines=False)
        file['time'] = pd.to_datetime(file['unix_time'], unit='s')
        time_delta = []
        time_delta.append(0)
        time_start = file['time'][0]
        for cur_time in file['time'][1:]:
            tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
            tmp += pd.Timedelta(cur_time - time_start).days * 24
            time_delta.append(tmp)
    
        map_size = []
        map_size.append(0)
        for cur_map in file['map_size']:
            cur_map = cur_map.strip('%')
            cur_map = float(cur_map)
            map_size.append(cur_map)
    
        all_time_delta.append(time_delta)
        all_map_size.append(map_size)
        if len(time_delta) < min_size:
            min_size = len(time_delta)
    
    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)
    
        cur_map = 0
        for j in range(1):
            cur_map += all_map_size[j][i]
        cur_map = cur_map / 1
        map_size_avg.append(cur_map)
    
    # for i in range(len(all_time_delta)):
    #     plt.plot(all_time_delta[i], all_map_size[i], alpha = 0.3)

#    if time_avg[-1] < 72:
#        time_avg.append(72)
#        map_size_avg.append(map_size_avg[-1])
    
    map_size_avg = [x * 262 / 100 for x in map_size_avg]
    
    if is_downsampling:
        time_avg, map_size_avg = sample_plots(time_avg, map_size_avg, time_avg[-1])

    plot_with_style(time_avg, map_size_avg, style_id=2, markevery=markevery)
    # plt.plot(time_avg, map_size_avg, linestyle = 'dashed', marker = '*', markevery=2600, linewidth=4.0, markersize=14)

    return


def plot_sqlancer_correct_rate(file_name, markevery=2600, line_style = 2, is_downsampling=True):
    all_time_delta = []
    all_corr_rate = []
    time_avg = []
    corr_rate_avg = []
    min_size = sys.maxsize

    for i in [0]:
        file = open(file_name)
        lines = file.readlines()

        time_start = datetime.datetime.now()
        time_delta = []
        curr_rate_list = []
        for line in lines:
            if "Executed" in line:
                cur_time_str = line.split(']')[0]
                cur_time_str = cur_time_str[1:]

                cur_valid_str = line.split('%')[0]
                cur_valid_str = cur_valid_str.split(' ')[-1]
                cur_valid_f = float(cur_valid_str) / 100.0

                cur_time = 0
                try:
                    cur_time = datetime.datetime.strptime(cur_time_str, "%Y/%m/%d %H:%M:%S")
                except ValueError:
                    continue
                if len(time_delta) == 0:
                    time_start = cur_time
                    time_delta.append(0)
                    curr_rate_list.append(cur_valid_f)
                    continue
                # if pd.Timedelta(cur_time - time_start).days == 1:
                #     break
                tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
                tmp += pd.Timedelta(cur_time - time_start).days * 24
                time_delta.append(tmp)
                curr_rate_list.append(cur_valid_f)

        all_time_delta.append(time_delta)
        all_corr_rate.append(curr_rate_list)
        if len(time_delta) < min_size:
            min_size = len(time_delta)

    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)

        cur_curr_rate = 0
        for j in range(1):
            cur_curr_rate += all_corr_rate[j][i]
        cur_curr_rate = cur_curr_rate / 1
        corr_rate_avg.append(cur_curr_rate)

    if is_downsampling:
        time_avg, corr_rate_avg = sample_plots(time_avg, corr_rate_avg, time_avg[-1])

    corr_rate_avg = [x*100 for x in corr_rate_avg]

    plot_with_style(time_avg, corr_rate_avg, style_id=line_style, markevery=markevery)



def plot_sql_correct_rate(file_dir, markevery, line_style, is_downsampling = True):
    # For SQLRight. Our main tool.
    all_time_delta = []
    all_corr_rate = []
    time_avg = []
    corr_rate_avg = []
    min_size = sys.maxsize

    """
        Find the longest run plot_data.
        In some rare cases, the fuzzing could stop in the middle, and cause the plot_data output incomplete.
        In order to get the latest and longest stable run,
        we pick the longest run plot_data available.
    """

    latest_time = 0
    file_name = ""
    for cur_file_name in os.listdir(file_dir):
        if "plot_data_" not in cur_file_name:
            continue
        cur_file_fd = pd.read_csv(os.path.join(file_dir, cur_file_name), error_bad_lines=False)
        last_idx = cur_file_fd['unix_time'].size - 1
        if last_idx < 10:
            print("For file: %s, too few entries are available. Skipped. " % (cur_file_name))
            continue
        cur_file_fd = cur_file_fd['unix_time'][last_idx] - cur_file_fd['unix_time'][0]
        if cur_file_fd > latest_time:
            latest_time = cur_file_fd
            file_name = os.path.join(file_dir, cur_file_name)

    if file_name == "":
        print("\n\n\nError: Cannot find plot_data_* file in dir %s, or all plot_data_* files are being skipped. Did you finish all the fuzzing and bisecting scripts? \n\n\n" % (cur_file_name))
        exit(1)
    
    
    for i in [0]:
        file = pd.read_csv(file_name, error_bad_lines=False)
        file['time'] = pd.to_datetime(file['unix_time'], unit='s')
        time_delta = []
        time_delta.append(0)
        time_start = file['time'][0]
        for cur_time in file['time'][1:]:
            tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
            tmp += pd.Timedelta(cur_time - time_start).days * 24
            time_delta.append(tmp)
    
        curr_rate_list = []
        for cur_curr_rate in file['total_good_rate']:
            cur_curr_rate = cur_curr_rate.strip('%')
            cur_curr_rate = float(cur_curr_rate)
            curr_rate_list.append(cur_curr_rate)

        all_time_delta.append(time_delta)
        all_corr_rate.append(curr_rate_list)
        if len(time_delta) < min_size:
            min_size = len(time_delta)
    
    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)
    
        cur_curr_rate = 0
        for j in range(1):
            cur_curr_rate += all_corr_rate[j][i]
        cur_curr_rate = cur_curr_rate / 1
        corr_rate_avg.append(cur_curr_rate)
    
    if is_downsampling:
        time_avg, corr_rate_avg = sample_plots(time_avg, corr_rate_avg, time_avg[-1])
    

    corr_rate_avg = [x*100 for x in corr_rate_avg]
    
    plot_with_style(time_avg, corr_rate_avg, style_id=line_style, markevery=markevery)


def plot_sqlancer_corr_over_time(file_name, markevery=2600, line_style = 2, is_downsampling=True):
    # # For SQLancer
    all_time_delta = []
    all_corr_rate = []
    time_avg = []
    corr_rate_avg = []
    min_size = sys.maxsize
    
    for i in range(1):
        file = open(file_name)
        lines = file.readlines()
    
        time_start = datetime.datetime.now()
        time_delta = []
        curr_rate_list = []
        for line in lines:
            if "Executed" in line:
                cur_time_str = line.split(']')[0]
                cur_time_str = cur_time_str[1:]
    
                cur_valid_str = line.split('successful statements:')[1]
                cur_valid_str = cur_valid_str.split('/')[0]
                cur_valid_int = int(cur_valid_str)
    
                cur_time = 0
                try:
                    cur_time = datetime.datetime.strptime(cur_time_str, "%Y/%m/%d %H:%M:%S")
                except ValueError:
                    continue
                if len(time_delta) == 0:
                    time_start = cur_time
                    time_delta.append(0)
                    curr_rate_list.append(cur_valid_int)
                    continue
                # if pd.Timedelta(cur_time - time_start).days == 1:
                #     break
                tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
                tmp += pd.Timedelta(cur_time - time_start).days * 24
                time_delta.append(tmp)
                curr_rate_list.append(cur_valid_int)
    
        all_time_delta.append(time_delta)
        all_corr_rate.append(curr_rate_list)
        if len(time_delta) < min_size:
            min_size = len(time_delta)
    
    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)
    
        cur_curr_rate = 0
        for j in range(1):
            cur_curr_rate += all_corr_rate[j][i]
        cur_curr_rate = cur_curr_rate / 1
        corr_rate_avg.append(cur_curr_rate)
    
    # for i in range(len(all_time_delta)):
    #     plt.plot(all_time_delta[i], all_corr_rate[i], alpha = 0.3)
    
    # Avoid time 0.
    time_avg = time_avg[1:]
    
    corr_rate_avg = corr_rate_avg[1:]
    
    for i in range(len(time_avg)):
        corr_rate_avg[i] = corr_rate_avg[i] / time_avg[i]
    
    if is_downsampling:
        time_avg, corr_rate_avg = sample_plots(time_avg, corr_rate_avg, time_avg[-1])
    
    plot_with_style(time_avg, corr_rate_avg, style_id=line_style, markevery=markevery)


def plot_sql_corr_over_time(file_dir, markevery, line_style, is_downsampling = True):

    all_time_delta = []
    all_corr_rate = []
    time_avg = []
    corr_rate_avg = []
    min_size = sys.maxsize

    """
        Find the longest run plot_data.
        In some rare cases, the fuzzing could stop in the middle, and cause the plot_data output incomplete.
        In order to get the latest and longest stable run,
        we pick the longest run plot_data available.
    """

    latest_time = 0
    file_name = ""
    for cur_file_name in os.listdir(file_dir):
        if "plot_data_" not in cur_file_name:
            continue
        cur_file_fd = pd.read_csv(os.path.join(file_dir, cur_file_name), error_bad_lines=False)
        last_idx = cur_file_fd['unix_time'].size - 1
        if last_idx < 10:
            print("For file: %s, too few entries are available. Skipped. " % (cur_file_name))
            continue
        cur_file_fd = cur_file_fd['unix_time'][last_idx] - cur_file_fd['unix_time'][0]
        if cur_file_fd > latest_time:
            latest_time = cur_file_fd
            file_name = os.path.join(file_dir, cur_file_name)

    if file_name == "":
        print("\n\n\nError: Cannot find plot_data_* file in dir %s, or all plot_data_* files are being skipped. Did you finish all the fuzzing and bisecting scripts? \n\n\n" % (cur_file_name))
        exit(1)

    for i in [2]:
        file = pd.read_csv(file_name, error_bad_lines=False)
        file['time'] = pd.to_datetime(file['unix_time'], unit='s')
        time_delta = []
        time_delta.append(0)
        time_start = file['time'][0]
        for cur_time in file['time'][1:]:
            tmp = pd.Timedelta(cur_time - time_start).seconds / 3600
            tmp += pd.Timedelta(cur_time - time_start).days * 24
            time_delta.append(tmp)

        curr_rate_list = []
        for cur_curr_rate in file['total_good_stmts']:
            cur_curr_rate = int(cur_curr_rate)
            curr_rate_list.append(cur_curr_rate)

        all_time_delta.append(time_delta)
        all_corr_rate.append(curr_rate_list)
        if len(time_delta) < min_size:
            min_size = len(time_delta)

    for i in range(min_size):
        cur_time = 0
        for j in range(1):
            cur_time += all_time_delta[j][i]
        cur_time = cur_time / 1
        time_avg.append(cur_time)

        cur_curr_rate = 0
        for j in range(1):
            cur_curr_rate += all_corr_rate[j][i]
        cur_curr_rate = cur_curr_rate / 1
        corr_rate_avg.append(cur_curr_rate)

    # for i in range(len(all_time_delta)):
    #     plt.plot(all_time_delta[i], all_corr_rate[i], alpha = 0.3)

    # Avoid time 0.
    time_avg = time_avg[1:]
    corr_rate_avg = corr_rate_avg[1:]

    for i in range(len(time_avg)):
        corr_rate_avg[i] = corr_rate_avg[i] / time_avg[i]

    if is_downsampling:
        time_avg, corr_rate_avg = sample_plots(time_avg, corr_rate_avg, time_avg[-1])

    # plt.plot(time_avg, corr_rate_avg, linestyle = (0, (3, 1, 1, 1, 1, 1)), marker = 'o', markevery=100, linewidth=4.0, markersize=14)
    plot_with_style(time_avg, corr_rate_avg, style_id=line_style, markevery=markevery)


def sample_bug_num(x, y, last_delta=None, start_from_zero = False):
    j = 1 # idx for original x and y. 
    last_delta = last_delta / 3600.0
    if start_from_zero:
        new_x = [0]
        new_y = [0]
    else:
        new_x = [x[0]]
        new_y = [y[0]]
    for i in np.arange(0, 72.2, 0.2):
        if last_delta is not None and last_delta < 20.0 and i > last_delta:
            break
        while j < len(x) and i > x[j]:
            new_x.append(x[j])
            new_y.append(y[j])
            j += 1
        new_x.append(i)
        new_y.append(new_y[-1])
    return new_x, new_y

def sample_plots(x, y, last_delta = None, start_from_zero = False):
    j = 1 # idx for original x and y. 
    prev_x = 0
    if start_from_zero:
        new_x = [0]
        new_y = [0]
    else:
        new_x = [x[0]]
        new_y = [y[0]]
    for i in np.arange(0, 72.2, 0.2):
        if last_delta is not None and last_delta < 20.0 and i > last_delta:
            break
        is_continue = False
        while j < len(x) and (i + 0.2) < x[j]:
            new_x.append(i)
            
            src_x = prev_x
            src_y = new_y[-1]
            dest_x = x[j]
            dest_y = y[j]
            
            new_y_value =  src_y + (dest_y - src_y) * (i - src_x) / (dest_x - src_x)

            new_y.append(new_y_value)
            is_continue = True
            break
        if is_continue:
            continue
        
        # If x still exists, then plot x. 
        if j < len(x):
            new_x.append(x[j])
            new_y.append(y[j])

            prev_x = x[j]

            # Iterate x to the point of ploting
            while j < len(x) and i > x[j]:
                j += 1
        # Otherwise, extend the last x value. 
        else:
            new_x.append(i)
            new_y.append(new_y[-1])
    return new_x, new_y
