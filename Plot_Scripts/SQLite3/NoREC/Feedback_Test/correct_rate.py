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


plot_sql_correct_rate("../SQLRight_NoREC", markevery = 10, line_style = 0)
plot_sql_correct_rate("./drop_all", markevery = 10, line_style = 1)
plot_sql_correct_rate("./random_save", markevery = 10, line_style = 2)
plot_sql_correct_rate("./save_all", markevery = 10, line_style = 3)



plt.xlim(0, 24)

plt.legend([r'SQLRight', r'SQLRight$_{drop}$', r'SQLRight$_{rand}$', r'SQLRight$_{save}$'])

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# ax.set_yscale('log')

# ax.yaxis.set_major_formatter(mtick.PercentFormatter())

# plt.title("SQLite3 NoREC Query Validity (%) (Feedback Tests)", fontsize=15)
# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Query Validity (%)', fontsize = 20)

# plt.legend(['SQLRight', 'SQLRight drop all seeds', 'SQLRight random save seeds', 'SQLRight save all seeds'], fontsize=9)


plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/correct-rate.pdf', dpi = 200)
plt.savefig('./plots/correct-rate.png', dpi = 200)
