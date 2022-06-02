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

plot_sql_mapsize("../SQLRight_NoREC/", markevery = 10, line_style = 0)
plot_sql_mapsize("./drop_all/", markevery = 10, line_style = 1)
plot_sql_mapsize("./random_save/", markevery = 10, line_style = 2)
plot_sql_mapsize("./save_all/", markevery = 10, line_style = 3)


# plt.xlabel('Time (hour)', fontsize = 20)
plt.ylabel('Coverage (k)', fontsize = 20)

plt.xlim(0, 24)
plt.ylim(20, 44) 

x_major_locator=MultipleLocator(4)
ax=plt.gca()
ax.xaxis.set_major_locator(x_major_locator)
plt.xticks(fontsize=20)
plt.yticks(fontsize=20)

# plt.title("SQLite3 NoREC Code Coverage (Feedback Tests)", fontsize=15)

# plt.legend(['SQLRight', 'SQLRight drop all seeds', 'SQLRight random save seeds', 'SQLRight save all seeds'], fontsize=9)

plt.tight_layout()

if not os.path.isdir("./plots"):
    os.mkdir("./plots")

plt.savefig('./plots/map-size.pdf', dpi = 200)
plt.savefig('./plots/map_size.png', dpi = 200)

plt.close()

plt.figure()

ax = plt.gca()

ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.spines['bottom'].set_visible(False)
ax.spines['left'].set_visible(False)

x = [0, 0]
y = [0, 0]

ax = plt.gca()

plot_with_style(x, y, style_id = 0)
plot_with_style(x, y, style_id = 1)
plot_with_style(x, y, style_id = 2)
plot_with_style(x, y, style_id = 3)

plt.gca().grid(False)
def export_legend(legend, filename="./plots/legend.pdf"):
    fig  = legend.figure
    fig.canvas.draw()
    bbox  = legend.get_window_extent().transformed(fig.dpi_scale_trans.inverted())
    bbox = Bbox.from_bounds(bbox.x0-0.027 , bbox.y0-0.003, bbox.width+0.03, bbox.height+0.01)
    fig.savefig(filename, dpi=200, bbox_inches=bbox)

plt.axis('off')

legend = plt.legend([r'SQLRight', r'SQLRight$_{drop}$', r'SQLRight$_{rand}$', r'SQLRight$_{save}$'], fontsize=14, handlelength=4, ncol=1)
export_legend(legend)
