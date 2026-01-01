PREV_CPU_STATS = None

def read_cpu_stats() -> list[list[int]]:
    try:
        all_stats = []
        with open("/proc/stat") as f:
            lines = f.readlines()
        for line in lines:
            if line.startswith("cpu"):
                parts = line.split()
                stats = list(map(int, parts[1:]))
                all_stats.append(stats)
        return all_stats
    except OSError as e:
        raise RuntimeError("failed to read /proc/stat") from e

def get_cpu_usage() -> list[float]:
    global PREV_CPU_STATS
    usages = []
    current_stats = read_cpu_stats()

    if PREV_CPU_STATS is None:
        PREV_CPU_STATS = current_stats
        return [0.0] * len(current_stats)

    for stats1, stats2 in zip(PREV_CPU_STATS, current_stats):
        diff = [(x-y) for x, y in zip(stats2, stats1)]
        # print(*diff)
        total = sum(diff)
        idle = diff[3] + diff[4]
        active_time = total - idle
        usage = (active_time / total) * 100
        usages.append(usage)

    PREV_CPU_STATS = current_stats
    return usages

def get_ram_stats() -> float:
    with open("/proc/meminfo") as f:
        info = {}
        for line in f:
            key, value, *_ = line.split()
            info[key.rstrip(":")] = int(value)
    total = info["MemTotal"]
    avail = info["MemAvailable"]
    used_mem = total- avail
    usage = (used_mem / total) * 100
    return usage

def get_loadavg() -> tuple:
    with open("/proc/loadavg") as f:
        one, five, fifteen, *_ = f.read().split()
    return float(one), float(five), float(fifteen)

def get_uptime() -> str:
    with open("/proc/uptime") as f:
        line = f.read()
    data = line.split()
    total_seconds = int(float(data[0]))
    days = total_seconds // (3600 * 24)
    rem = total_seconds % (3600 * 24)
    hours = rem // 3600
    remainder = rem % 3600
    minutes = remainder // 60
    seconds = remainder % 60
    uptime = f"{days}d {hours}h {minutes}m {seconds}s"
    return uptime
