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

plot_sql_corr_over_time("../SQLRight_TLP/", markevery = 30, line_style = 0)
plot_sqlancer_corr_over_time("./SQLancer_TLP/logs_0", markevery = 30, line_style = 2)
plot_sql_corr_over_time("./Squirrel_with_oracle/", markevery = 30, line_style = 1)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Valid Queries per Hour', fontsize = 20)

plt.xlim(0, 72)
# plt.ylim(90, 130)

plt.legend([r'SQLRight', r'SQLancer', r'Squirrel$_{+oracle}$'])

x_major_locator=MultipleLocator(12)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)
ax.set_yscale('log')

# plt.title("SQLite3 TLP Valid Statements over time (diff tools)", fontsize=15)
# plt.legend(['SQLRight', 'SQLRight_use_squ_parser', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/valid-stmts-over-time.pdf', dpi = 200)
plt.savefig('./plots/valid-stmts-over-time.png', dpi = 200)
