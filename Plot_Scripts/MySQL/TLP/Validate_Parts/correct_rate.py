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

plot_sql_correct_rate("../SQLRight_MySQL_TLP/plot_data_1", markevery = 10, line_style = 4)
plot_sql_correct_rate("./SQLRight_with_squ_valid/plot_data_1", markevery = 10, line_style = 2)
# sqlright with squ parser
x = list(np.arange(0, 24.2, 0.2))
y = [0] * len(x)
plot_with_style(x, y, style_id = 3, markevery=13)

plot_sql_correct_rate("../SQLRight_MySQL_TLP/plot_data_0", markevery = 10, line_style = 0)

# squirrel
x = list(np.arange(0, 24.2, 0.2))
y = [0] * len(x)
plot_with_style(x, y, style_id = 1, markevery=10)

plt.xlim(0, 24)
plt.ylim(-2, 49)

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
# ax.set_yscale('log')

# ax.yaxis.set_major_formatter(mtick.PercentFormatter())

# plt.title("MySQL TLP Query Validity (%) (Valid Parts)", fontsize=15)
# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)

# plt.legend(['SQLRight', 'SQLRight with squ valid', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/correct-rate.pdf', dpi = 200)
plt.savefig('./plots/correct-rate.png', dpi = 200)
