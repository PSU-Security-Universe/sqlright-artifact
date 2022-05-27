import os

src_dir = "new_inputs"
dest_dir = "new_inputs_reformatted"

if not os.path.isdir(dest_dir):
    os.mkdir(dest_dir)

for cur_file_path in os.listdir(src_dir):
    cur_dest_path = os.path.join(dest_dir, cur_file_path)
    cur_file_path = os.path.join(src_dir, cur_file_path)
    with open(cur_file_path, 'r', errors="ignore", encoding="utf-8") as cur_file_fd, open(cur_dest_path, 'w', errors="ignore", encoding="utf-8") as cur_dest_fd:
        new_line = ""
        for cur_line in cur_file_fd.read().splitlines(): 
            if cur_line[:2] == "--":
                continue           
            new_line += cur_line
            if new_line != "" and new_line[-1] == ";":
                new_line.replace("\t", " ")
                new_line += "\n"
                cur_dest_fd.write(new_line)
                # print(new_line)
                new_line = ""
