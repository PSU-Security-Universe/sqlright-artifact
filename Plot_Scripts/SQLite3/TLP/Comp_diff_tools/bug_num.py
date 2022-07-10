import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
from matplotlib.pyplot import MultipleLocator
from matplotlib.transforms import Bbox
import datetime
import numpy as np
import shutil
import paramiko


sys.path.insert(1, '../../Shared_Plots_Code')
from plot_funcs import *

plot_sql_bugs("../SQLRight_TLP/", markevery = 30, line_style = 0)
plot_sql_bugs("./SQLancer_TLP/", markevery = 30, line_style = 2)
plot_sql_bugs("./Squirrel_with_oracle/", markevery = 30, line_style = 1)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 72)

plt.legend([r'SQLRight', r'SQLancer', r'Squirrel$_{+oracle}$'])

x_major_locator=MultipleLocator(12)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# plt.title("SQLite3 TLP Code Coverage (Valid Parts)", fontsize=15)

# plt.legend(['SQLRight', 'Squirrel', 'SQLancer'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"): 
    os.mkdir("./plots")

plt.savefig('./plots/bug-num.pdf', dpi = 200)
plt.savefig('./plots/bug_num.png', dpi = 200)
