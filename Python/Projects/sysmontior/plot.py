import matplotlib.pyplot as plt
import pandas as pd

plt.ion() # interactive
fig, axes = plt.subplots()

cpu, = axes.plot([], [], label="CPU")
ram, = axes.plot([], [], label="RAM")
axes.set_title("CPU & RAM monitoring")
axes.set_xlabel("Time(s)")
axes.set_ylabel("Usage%")
axes.legend()

def plot_graph():
    try:
        df = pd.read_csv("log.csv")
        if df.empty:
            print("filelog file empty")

        # plt.plot(df['CPU'], label='CPU%', color="b")
        # plt.plot(df['RAM'], label='RAM%', color="r")
        cpu.set_data(range(len(df)), df["CPU"])
        ram.set_data(range(len(df)), df["RAM"])
        axes.relim()
        axes.autoscale_view() # refresh
        plt.pause(0.01)

    except FileNotFoundError:
        print("File not found")
    except Exception as e:
        print("Exception:", e)
