import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
from matplotlib.pyplot import MultipleLocator
import datetime
import numpy as np
import shutil
import paramiko
from matplotlib.ticker import MaxNLocator
from matplotlib.ticker import FuncFormatter


sys.path.insert(1, '../../Shared_Plots_Code')
from plot_funcs import *


plot_sql_correct_rate("../SQLRight_NoREC", markevery = 10, line_style = 4)
plot_sql_correct_rate("./SQLRight_with_squ_valid", markevery = 10, line_style = 2)
plot_sql_correct_rate("./SQLRight_with_squ_parser", markevery = 10, line_style = 3)
plot_sql_correct_rate("../SQLRight_NoREC", markevery = 10, line_style = 0)
plot_sql_correct_rate("../Comp_diff_tools_NoREC/Squirrel_with_oracle", markevery = 10, line_style = 1)
 
plt.xlim(0, 24) 
plt.ylim(-2, 30)

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
# ax.set_yscale('log')

#ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: '{:.0%}'.format(y/100)))

# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)


plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/correct-rate.pdf', dpi = 200)
plt.savefig('./plots/correct-rate.png', dpi = 200)
