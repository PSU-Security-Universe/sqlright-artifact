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


plot_sql_correct_rate("../SQLRight_MySQL_NoREC/plot_data_0", markevery = 30, line_style = 0)

# For Squirrel
x = list(np.arange(0, 72.2, 0.2))
y = [0] * len(x)
plot_with_style(x, y, style_id = 1, markevery=30)


plt.xlim(0, 72)
# plt.ylim(-1, 105)

x_major_locator=MultipleLocator(12)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# plt.xticks(fontsize=20)
# plt.yticks(fontsize=20)
# ax.set_yscale('log')

# ax.yaxis.set_major_formatter(mtick.PercentFormatter())

# plt.title("MySQL NoREC Query Validity (%) (diff tools)", fontsize=15)
# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)

# plt.legend(['SQLRight', 'Squirrel with oracle', 'SQLancer'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/correct-rate.pdf', dpi = 200)
plt.savefig('./plots/correct-rate.png', dpi = 200)
