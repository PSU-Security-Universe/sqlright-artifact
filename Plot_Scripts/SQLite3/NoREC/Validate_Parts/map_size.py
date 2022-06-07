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

plot_sql_mapsize("./non-deter/", markevery = 10, line_style = 4)
plot_sql_mapsize("./SQLRight_with_squ_valid/", markevery = 10, line_style = 2)
plot_sql_mapsize("./SQLRight_with_squ_parser_and_valid/", markevery = 10, line_style = 3)
plot_sql_mapsize("../SQLRight_NoREC/", markevery = 10, line_style = 0)
plot_sql_mapsize("../Comp_diff_tools_NoREC/Squirrel_with_oracle/", markevery = 10, line_style = 1)



# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 24)
plt.ylim(25, 44)

x_major_locator=MultipleLocator(4) 
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")
plt.savefig('./plots/map-size.pdf', dpi = 200)


plt.close()

def export_legend(legend, filename="./plots/legend.pdf"):
    fig  = legend.figure
    fig.canvas.draw()
    bbox  = legend.get_window_extent().transformed(fig.dpi_scale_trans.inverted())
    fig.savefig(filename, dpi=200, bbox_inches=bbox)

x = [0, 0]
y = [0, 0]

ax = plt.gca()

plot_with_style(x, y, style_id = 0)
plot_with_style(x, y, style_id = 4)
plot_with_style(x, y, style_id = 2)
plot_with_style(x, y, style_id = 3)
plot_with_style(x, y, style_id = 1)

ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_visible(False)
ax.spines['left'].set_visible(False)

ax.get_xaxis().set_ticks([])
ax.get_yaxis().set_ticks([])

legend = plt.legend([r'SQLRight', r'SQLRight$_{-deter}$', r'SQLRight$_{-ctx}$$_{-}$$_{valid}$', r'SQLRight$_{-db}$$_{-}$$_{par}$$_{&}$$_{ctx}$$_{-}$$_{valid}$', r'Squirrel$_{+oracle}$'], fontsize=14, handlelength=4, loc = 0)
plt.gca().grid(False)
export_legend(legend)
