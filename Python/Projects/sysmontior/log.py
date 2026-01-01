import pandas as pd
import time
import os

def log_data(cpu_usage: float, ram_usage: float, load_avg: tuple):
    data = {
        "Timestamp": [time.strftime("%H:%M:%S")],
        "CPU": [f"{cpu_usage:.2f}"], 
        "RAM": [f"{ram_usage:.2f}"],
        "Load_1m": [load_avg[0]]
    }
    df = pd.DataFrame(data)
    file = "log.csv"
    if os.path.isfile(file):
        df.to_csv(file, mode='a', header= False, index=False)
    else:
        df.to_csv(file, mode='a', index=False)
