### **1. CPU Utilization (The "Calculated" Metric)**

**File:** `/proc/stat`

**Why:** It doesn't give you a percentage; it gives you raw "jiffies" (time units) spent in different states since boot.

* **What to monitor:** `user`, `nice`, `system`, `idle`, `iowait`, etc.
* **The Math:** You need to take two snapshots ( and ) and calculate:


* **Exam Prep:** This tests your ability to use **Lists** to store values and **Loops** to calculate deltas.

### **2. Memory Statistics (The "Parsing" Metric)**

**File:** `/proc/meminfo`

**Why:** This file is a goldmine for **String Slicing (Unit 3)**.

* **What to monitor:** * `MemTotal`: Total physical RAM.
* `MemAvailable`: Memory available for starting new applications without swapping.
* `SwapTotal` & `SwapFree`: To see if the system is under memory pressure.


* **Exam Prep:** You’ll use `.split(':')` and `.strip()` to clean the labels and convert values like `'16384224 kB'` into integers.

### **3. System Load Average**

**File:** `/proc/loadavg`

**Why:** It’s the easiest file to parse—just five numbers separated by spaces.

* **What to monitor:** The 1-minute, 5-minute, and 15-minute load averages.
* **Logic (Unit 2):** Use an `if` statement to trigger a "High Load" warning in your **Tkinter GUI** if the 1-min average exceeds your CPU core count.

### **4. Uptime & Idle Time**

**File:** `/proc/uptime`

**Why:** It contains two floats: total seconds since boot and total idle seconds.

* **Engineering Challenge:** Use **Math Operators (Unit 1)** to convert seconds into a human-readable format like `HH:MM:SS`.

### **5. Top Processes (The "Directory" Metric)**

**Path:** `/proc/[PID]/status`

**Why:** This involves **File Iteration (Unit 4)**.

* **The Logic:** Use `os.listdir('/proc')` to find all numeric folders (PIDs).
* **What to monitor:** Read the `Name:` and `VmRSS:` (physical memory used) from each process's `status` file.
* **Data Structure:** Store this in a **List of Dictionaries** (Unit 3):
`[{'pid': 1, 'name': 'systemd', 'mem': '12MB'}, ...]`

---

### **Quick Table for your Revision**

| Feature | Syllabus Unit | Python Method to Use |
| --- | --- | --- |
| **Parsing Labels** | Unit 3 (Strings) | `line.split(':')` |
| **Live Stats** | Unit 2 (Loops) | `while True:` with `time.sleep()` |
| **History Log** | Unit 4 (File I/O) | `open('log.txt', 'a')` |
| **GUI Alerts** | Unit 5 (Tkinter) | `label.config(fg='red')` |
| **Calculations** | Unit 1 (Operators) | `(used / total) * 100` |

### **Final Pro-Tip for the Exam:**

If they ask about **File Modes**, remember that `/proc` files are "virtual." You should always open them in **Read-only mode (`'r'`)**. Attempting to write (`'w'`) to most files in `/proc` will result in a `PermissionError` or an `OSError` because they are kernel-generated interfaces.

**Next Step for You:**
Would you like me to write a small **String-to-Int conversion snippet** that handles the "kB" units in `/proc/meminfo`? This is a very common task in both projects and exams.
