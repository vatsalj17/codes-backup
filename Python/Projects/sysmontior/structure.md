## Phase 1: The Data Acquisition Layer (Units 1 & 2)

**Goal:** Interface with the Linux Kernel via the virtual filesystem.

* **Logic (Unit 2):** Create an infinite `while` loop that acts as your "Heartbeat." Use a `try-except` block (bonus logic) or `if-else` to handle potential file-read errors.
* **Variables (Unit 1):** Initialize global variables for `CPU_USAGE_THRESHOLD = 80` (Constant logic) and counters.
* **Action:** 1.  Open `/proc/stat` and `/proc/meminfo`.
2.  Read the first line (String basics).
3.  Use `if` statements to check if the data returned is valid before processing.

---

## Phase 2: Data Parsing & Storage (Unit 3)

**Goal:** Transform raw strings into structured, manageable data.

* **Strings:** Use `.split()`, `.strip()`, and **Slicing** to extract the numbers from the text strings returned by the kernel files.
* **Lists:** Maintain a `history_list` of the last 10 CPU readings. Use `.append()` to add new data and `pop(0)` to keep the list size fixed (Implementing a sliding window/queue).
* **Dictionaries:** Create a `system_state` dictionary.
* *Keys:* `'cpu'`, `'mem'`, `'swap'`.
* *Values:* The current integer values.


* **Tuples:** Store your hardware specs (e.g., `TOTAL_RAM = (16, 'GB')`) as an immutable tuple since they won't change during runtime.
* **Functions:** Wrap the parsing logic into a `def parse_kernel_data():` function. Remember **Scope**: local variables inside vs. global variables outside.

---

## Phase 3: Persistent Logging (Unit 4)

**Goal:** Move data from volatile RAM to the non-volatile SSD.

* **File Modes:** 1.  Open a file `system_log.csv` in **'a' (append)** mode so you don't overwrite previous exam practice data.
2.  Write the dictionary values into the file as a comma-separated string.
* **File Pointer (`seek`/`tell`):** * Implement a "Sanity Check" function.
* Use `f.tell()` to check the file size.
* If the file gets too large, use `f.seek(0)` and overwrite, or print a warning. This is crucial for Unit 4 exam questions.



---

## Phase 4: Analytics & Visualization (Unit 5)

**Goal:** Use high-level libraries to interpret the logs.

* **NumPy:** Convert your `history_list` into a NumPy array to calculate the **Mean** and **Standard Deviation** of CPU spikes.
* **Pandas:** Load the `system_log.csv` into a **DataFrame**. Practice selecting a specific column (e.g., `df['CPU']`) and using `.tail(5)` to see the latest entries.
* **Matplotlib:** Plot the DataFrame.
* *X-axis:* Time/Index.
* *Y-axis:* Usage %.
* Label your axes—this is a common "GUI/Viz" exam requirement.



---

## Phase 5: The Interface (Unit 5 - Tkinter)

**Goal:** Wrap the engine in a Graphical User Interface.

* **The Window:** Create a `root = Tk()` object.
* **Widgets:** * `Label`: To display "Real-time CPU: 15%".
* `Button`: To trigger the Matplotlib graph window.
* `Entry`: (Optional) To let the user set a custom "Logging Interval."


* **The Event Loop:** Use `root.after(1000, update_function)` to call your data-grabbing function every second without freezing the GUI.

---

### **The "Exam Ready" Checklist (Verify these as you build):**

1. **Mutability:** Did you try to change a Tuple? (Make sure you know why you can't).
2. **File Closing:** Are you using `with open(...)`? (The "Pythonic" way to ensure `close()` is called).
3. **List vs. Dict:** When should you use which? (Lists for ordered history, Dicts for named attributes).
4. **Indexing:** Remember Python is **0-indexed**. `list[0]` is the first element.

### **Bonus Fact for your Exam:**

You might see a question about **List Comprehensions**. In your project, instead of a loop to convert strings to ints, you can use:
`int_data = [int(x) for x in raw_list]`.
It’s faster and more "Pythonic" than a standard `for` loop because it's optimized at the C-level inside the interpreter.

**Would you like me to clarify the specific logic behind `seek()` and `tell()` with an example, as that's a very common "Unit 4" trick question?**
