import matplotlib.pyplot as plt
import os
import pandas as pd
import sys
from matplotlib.pyplot import MultipleLocator
import datetime
import numpy as np
import shutil
import paramiko

from matplotlib.ticker import FuncFormatter


sys.path.insert(1, '../../Shared_Plots_Code')
from plot_funcs import *


plot_sql_correct_rate("../SQLRight_NoREC/", markevery = 30, line_style = 0)
plot_sqlancer_correct_rate("./SQLancer/logs_0", markevery = 30, line_style = 2)
plot_sql_correct_rate("./Squirrel_with_oracle/", markevery = 30, line_style = 1)


plt.xlim(0, 72)
plt.ylim(-2, 33)

plt.legend([r'SQLRight', r'SQLancer', r'Squirrel$_{+oracle}$'])

x_major_locator=MultipleLocator(12)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)


# ax.set_yscale('log')

#ax.yaxis.set_major_formatter(FuncFormatter(lambda y, _: '{:.0%}'.format(y/100)))

# plt.title("Postgres NoREC Query Validity (%) (diff tools)", fontsize=14)
# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)

# plt.legend(['SQLRight', 'Squirrel with oracle', 'SQLancer'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/correct-rate.pdf', dpi = 200)
plt.savefig('./plots/correct-rate.png', dpi = 200)
