import time
import os
import sys
from data import get_loadavg, get_uptime, get_ram_stats, get_cpu_usage
from log import log_data
from plot import plot_graph

def print_sys_data() -> None:
    cpuusage = get_cpu_usage()
    if 0.0 == cpuusage[0]:
        return
    os.system("clear")
    for i, cores in enumerate(cpuusage):
        if i == 0:
            print(f"Total CPU utilized: {cores:.2f}%")
        else:
            print(f"  core{i-1:<2d}: {cores:.2f}%")
    ramusage = get_ram_stats()
    print(f"RAM utilized: {ramusage:.2f}%")
    load = get_loadavg()
    print(f"Load: {load}")
    uptime = get_uptime()
    print(f"Uptime: {uptime}")
    log_data(cpuusage[0], ramusage, load)
    plot_graph()

if __name__=="__main__" and os.name == "posix":
    print("Loading...")
    try:
        while True:
            print_sys_data()
            time.sleep(2)
    except KeyboardInterrupt:
        print("Exiting.. ")
        sys.exit(0)
    except Exception as e:
        print(f"Exception occured: {e}")
        sys.exit(1)
