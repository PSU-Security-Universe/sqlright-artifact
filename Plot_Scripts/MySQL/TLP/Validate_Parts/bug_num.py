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

# For SQLRight. Our main tool.
# This result is comes from SQLRight Oct 4th run. This is one of the best run available
x = [0, 11.90, 11.90, 72]
y = [0, 0, 1, 1]

x, y = sample_bug_num(x, y)

plot_with_style(x, y, style_id = 0, markevery = 1000)



x, y = sample_bug_num(x, y)

plot_with_style(x, y, style_id = 0, markevery = 10)

# Squirrel + oracle 

x = [0, 72]
y = [0, 0]

x, y = sample_bug_num(x, y)

plot_with_style(x, y, style_id = 1, markevery = 10)


# SQLancer
 
x = [0, 72]
y = [0, 0]

x, y = sample_bug_num(x, y)

plot_with_style(x, y, style_id = 2, markevery = 10)



# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Unique Bug', fontsize = 20)

plt.xlim(0, 24)
plt.ylim(-0.3, 4.3)

ax=plt.gca()
x_major_locator=MultipleLocator(4)
ax.xaxis.set_major_locator(x_major_locator)

y_major_locator=MultipleLocator(1)
ax.yaxis.set_major_locator(y_major_locator)

# plt.title("SQLite3 NoREC Bug Number (diff tools)", fontsize=15)

# plt.legend(['SQLRight', 'Squirrel with oracle', 'SQLancer'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/bug-num.pdf', dpi = 200)
plt.savefig('./plots/bug-num.png', dpi = 200)
