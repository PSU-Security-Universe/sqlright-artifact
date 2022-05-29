import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
from matplotlib.pyplot import MultipleLocator
import datetime
import numpy as np
import shutil
import paramiko


sys.path.insert(1, '../../Shared_Plots_Code')
from plot_funcs import *

plot_sql_mapsize("../SQLRight_MySQL_TLP/plot_data_4", markevery = 10, line_style = 4)
plot_sql_mapsize("./SQLRight_with_squ_valid/plot_data_1", markevery = 10, line_style = 2)
plot_sql_mapsize("./SQLRight_with_squ_parser/plot_data_0", markevery = 10, line_style = 3)
plot_sql_mapsize("../SQLRight_MySQL_TLP/plot_data_0", markevery = 10, line_style = 0)
plot_sql_mapsize("../Comp_diff_tools/squirrel/second_run/plot_data_0", markevery = 10, line_style = 1)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 24)
plt.ylim(100, 230) 

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# plt.title("MySQL TLP Code Coverage (Valid Parts)", fontsize=15)

# plt.legend(['SQLRight', 'SQLRight with squ valid', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

    
plt.savefig('./plots/map-size.pdf', dpi = 200)
plt.savefig('./plots/map_size.png', dpi = 200)
