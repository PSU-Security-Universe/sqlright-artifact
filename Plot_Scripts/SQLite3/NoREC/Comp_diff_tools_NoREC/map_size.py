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

plot_sql_mapsize("../SQLRight_NoREC/", markevery = 30, line_style = 0)
plot_sql_mapsize("./Squirrel_with_oracle/", markevery = 30, line_style = 1)
plot_sql_mapsize("./SQLancer/plot_data_0", markevery = 30, line_style = 2)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 72)
plt.ylim(20, 44) 

x_major_locator=MultipleLocator(12)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)

# plt.title("SQLite3 NoREC Code Coverage (diff tools)", fontsize=15)



plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/map-size.pdf', dpi = 200)
plt.savefig('./plots/map_size.png', dpi = 200)


plt.gca().grid(False)

def export_legend(legend, filename="./plots/legend.pdf"):
    fig  = legend.figure
    fig.canvas.draw()
    bbox = legend.get_window_extent().transformed(fig.dpi_scale_trans.inverted())
    bbox = Bbox.from_bounds(bbox.x0-0.01, bbox.y0, bbox.width+0.085, bbox.height)
    fig.savefig(filename, dpi=200, bbox_inches=bbox)

legend = plt.legend([r'SQLRight', r'Squirrel$_{+oracle}$         ', r'SQLancer'], fontsize=14, handlelength=4)
export_legend(legend)
