import os
import pandas as pd

src_file = "./sql_save_all_tlp_map.txt"

fd = pd.read_csv(src_file)

depth = fd.groupby('depth').count()

print(depth)
