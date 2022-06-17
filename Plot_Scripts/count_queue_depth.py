import os
import sys
import getopt

def count_queue_depth(src_dir: str):

    all_files_in_dir = os.listdir(src_dir)

    id2depth = dict()
    depth_file_list = []
    depth_file_count = []

    # Remove not queue files, sort the files. 
    all_files_in_dir = [x for x in all_files_in_dir if x[:3] == "id:"]
    all_ids_in_dir = [x.split("id:")[1] for x in all_files_in_dir]
    all_ids_in_dir = [x.split(",")[0] for x in all_ids_in_dir]
    all_files_in_dir = [x for _,x in sorted(zip(all_ids_in_dir, all_files_in_dir))]


    for cur_file in all_files_in_dir:
        # print("Getting file: %s" % (cur_file))
        if ",orig:" in cur_file:
            # depth = 1
            id_num = cur_file.split("id:")[1]
            id_num = id_num.split(",orig")[0]
            id_num = int(id_num)
            id2depth[id_num] = 1
            depth = 1
#            print("depth: %d, file: %s\n" % (depth, cur_file))

            if depth > len(depth_file_list):
                depth_file_list.append([])
            depth_file_list[depth-1].append(id_num)

            continue

        prev_id = cur_file.split("src:")[1]
        prev_id = prev_id.split(",op")[0]
        prev_id = int(prev_id)
        id_num = cur_file.split("id:")[1]
        id_num = id_num.split(",src")[0]
        id_num = int(id_num)
        id2depth[id_num] = id2depth[prev_id] + 1
        depth = id2depth[id_num]
#        print("depth: %d, file: %s\n" % (depth, cur_file))

        if depth > len(depth_file_list):
            depth_file_list.append([])
        depth_file_list[depth-1].append(id_num)

    for depth_file in depth_file_list:
        depth_file_count.append(len(depth_file))

    if len(depth_file_count) > 0:
        print("Depth: 0: %d" % (24738))
    else:
        print("Depth file empty!")
        print("Max depth: %d" % (len(depth_file_count)))
        return

    if len(depth_file_count) >= 4:
        print("Depth: 1~3: %d" % sum(depth_file_count[1:4]))
    else:
        print("Depth: 1~3: %d" % sum(depth_file_count[1:]))
        print("Max depth: %d" % (len(depth_file_count)))
        return

    if len(depth_file_count) >= 8:
        print("Depth: 4~7: %d" % sum(depth_file_count[4:8]))
    else:
        print("Depth: 4~7: %d" % sum(depth_file_count[4:]))
        print("Max depth: %d" % (len(depth_file_count)))
        return

    if len(depth_file_count) > 8:
        print("Depth: 7+: %d" % sum(depth_file_count[9:]))

    print("Max depth: %d" % (len(depth_file_count)))

    return
        
oracle_str_l = ["NOREC", "TLP"]
feedback_str_l = ["", "drop_all", "random_save", "save_all"]

for oracle_str in oracle_str_l:
    for feedback_str in feedback_str_l:
        if feedback_str != "":
            print("\n\n\nRunning with Configuration: SQLRight with oracle: %s and with feedback: %s. " % (oracle_str, feedback_str))
        else:
            print("\n\n\nRunning with Configuration: SQLRight with oracle: %s and with feedback: Normal. " % (oracle_str))
        src_dir = "../SQLite/Results/"
        if not os.path.isdir(src_dir):
            print("Error: The SQLite3 Results dir is not exist. Please run the fuzzing first in order to generate the output folder. ")
            exit(1)

        src_dir += "sqlright_sqlite"

        if feedback_str != "":
            src_dir += "_" + feedback_str

        src_dir += "_" + oracle_str

        src_dir += "/outputs_0/queue"

        if not os.path.isdir(src_dir):
            print("Error: The SQLite3 Results dir: %s is not exist. Please run the fuzzing first in order to generate the output folder. " % (src_dir))
            continue


        count_queue_depth(src_dir)

