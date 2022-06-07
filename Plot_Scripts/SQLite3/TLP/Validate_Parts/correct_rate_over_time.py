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


plot_sql_corr_over_time("../SQLRight_TLP/", markevery = 10, line_style = 4)
plot_sql_corr_over_time("./SQLRight_with_squ_valid/", markevery = 10, line_style = 2)
plot_sql_corr_over_time("./SQLRight_with_squ_parser/", markevery = 10, line_style = 3)
plot_sql_corr_over_time("../SQLRight_TLP/", markevery = 10, line_style = 0)
plot_sql_corr_over_time("../Comp_diff_tools/Squirrel_with_oracle/", markevery = 10, line_style = 1)
# plot_sqlancer_corr_over_time("./SQLancer/SQLancer_3/plot_data_30",  markevery = 100, line_style = 2)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 24)
# plt.ylim(90, 130)

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
ax.set_yscale('log')

# plt.title("SQLite3 TLP Valid Statements over time (Valid Parts)", fontsize=15)

# plt.legend(['SQLRight', 'SQLRight_use_squ_parser', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/valid-stmts-over-time.pdf', dpi = 200)
plt.savefig('./plots/valid-stmts-over-time.png', dpi = 200)
