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

plot_sql_corr_over_time("../SQLRight_MySQL_TLP/", markevery = 10, line_style = 0)
plot_sql_corr_over_time("./non_deter/", markevery = 10, line_style = 4)
plot_sql_corr_over_time("./SQLRight_with_squ_valid/", markevery = 10, line_style = 2)
x = list(np.arange(0, 72.2, 0.2))
y = [1] * len(x)
# for squirrel parser.
plot_with_style(x, y, style_id = 3, markevery=10)
# for squirrel oracle.
plot_with_style(x, y, style_id = 1, markevery=10)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('valid statements per hour', fontsize = 20)

plt.xlim(0, 24)
# plt.ylim(90, 130)

plt.legend([r'SQLRight', r'SQLRight$_{-deter}$', r'SQLRight$_{-ctx}$$_{-}$$_{valid}$', r'SQLRight$_{-db}$$_{-}$$_{par}$$_{&}$$_{ctx}$$_{-}$$_{valid}$', r'Squirrel$_{+oracle}$'])

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)
ax.set_yscale('log')

# plt.title("MySQL TLP Valid Statements over time (diff tools)", fontsize=15)

# plt.legend(['SQLRight', 'SQLRight with squ valid', 'Squirrel'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/valid-stmts-over-time.pdf', dpi = 200)
plt.savefig('./plots/valid-stmts-over-time.png', dpi = 200)

