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

plot_sql_bugs("../SQLRight_MySQL_NoREC/", markevery = 10, line_style = 4)
plot_sql_bugs("./SQLRight_with_squ_valid/", markevery = 10, line_style = 2)
plot_sql_bugs("./SQLRight_with_squ_parser/", markevery = 10, line_style = 3)
plot_sql_bugs("../SQLRight_MySQL_NoREC/", markevery = 10, line_style = 0)
plot_sql_bugs("../Comp_diff_tools/squirrel/", markevery = 10, line_style = 1)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 24)

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# plt.title("MySQL TLP Code Coverage (Valid Parts)", fontsize=15)

# plt.legend(['SQLRight', 'SQLRight with squ valid', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

    
plt.savefig('./plots/bug-num.pdf', dpi = 200)
plt.savefig('./plots/bug_num.png', dpi = 200)
