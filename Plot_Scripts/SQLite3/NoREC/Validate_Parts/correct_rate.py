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

plot_sql_correct_rate("./non-deter/plot_data_1", markevery = 10, line_style = 4)
plot_sql_correct_rate("./SQLRight_with_squ_valid/plot_data_0", markevery = 10, line_style = 2)
plot_sql_correct_rate("./SQLRight_with_squ_parser_and_valid/plot_data_0", markevery = 10, line_style = 3)
plot_sql_correct_rate("../SQLRight_NoREC/plot_data_0", markevery = 10, line_style = 0)
plot_sql_correct_rate("../Comp_diff_tools_NoREC/Squirrel_with_oracle/first_run_unknown_config/plot_data_0", markevery = 10, line_style = 1)
 
plt.xlim(0, 24) 

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
# ax.set_yscale('log')

# ax.yaxis.set_major_formatter(mtick.PercentFormatter())

# plt.title("SQLite3 NoREC Query Validity (%) (Valid Parts)", fontsize=15)
# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)

# plt.legend(['SQLRight', 'SQLRight use Squirrel dep graph', 'SQLRight with Squirrel parser & dep graph', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/correct-rate.pdf', dpi = 200)