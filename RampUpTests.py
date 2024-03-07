import tkinter as tk
import subprocess
import os
from tkinter import messagebox
from threading import Thread

# Assuming RampUpTests.py is in the root folder and TestScripts is a subfolder within the same directory
root_dir = os.path.dirname(os.path.abspath(__file__))
test_scripts_dir = os.path.join(root_dir, 'TestScripts')

# Function to run the ramp-up test batch files
def run_ramp_up_test(batch_file):
    batch_file_path = os.path.join(test_scripts_dir, batch_file)  # Full path to the batch file

    # Debugging: Print the path to verify it's correct
    print(f"Attempting to run batch file at path: {batch_file_path}")

    if not os.path.exists(batch_file_path):
        messagebox.showerror("Error", f"Batch file not found: {batch_file_path}")
        return  # Exit the function if the batch file does not exist

    # Execute the batch file within the TestScripts directory
    subprocess.Popen(['cmd', '/c', batch_file_path], cwd=test_scripts_dir, shell=True)

# Create the main dialog window, replicating the style and structure of Master.py
def create_ramp_up_test_panel():
    ramp_up_test_dialog = tk.Tk()
    ramp_up_test_dialog.title("Ramp Up Testing")  # Updated title here

    # Set the initial size of the dialog box to make it wider. For example, 300x400.
    ramp_up_test_dialog.geometry("300x300")

    # Create the main frame, similar to Master.py
    main_frame = tk.Frame(ramp_up_test_dialog)
    main_frame.pack(fill='both', expand=True)

    # More vivid blue color for the buttons
    vivid_blue = '#007FFF'

    # Buttons to launch ramp-up tests, using the structure from Master.py
    buttons = [
        {"text": "StoreSCU 32KB", "command": lambda: run_ramp_up_test('StoreSCU-Folder-1 32KB.cmd')},
        {"text": "StoreSCU 128KB", "command": lambda: run_ramp_up_test('StoreSCU-Folder-2 128.cmd')},
        {"text": "StoreSCU 512KB", "command": lambda: run_ramp_up_test('StoreSCU-Folder-3 512 KB.cmd')},
        {"text": "StoreSCU 128KB Profiler", "command": lambda: run_ramp_up_test('StoreSCU-Folder-4 128KB_Profiler.cmd')},
        {"text": "StoreSCU ALL", "command": lambda: run_ramp_up_test('StoreSCU-Folder-6 ALL.cmd')}
    ]

    for button in buttons:
        tk.Button(main_frame, text=button["text"], command=button["command"], bg=vivid_blue, fg='white').pack(pady=10)

    # Close button to exit the application, matching the style from Master.py
    tk.Button(main_frame, text="Exit", command=ramp_up_test_dialog.destroy, bg=vivid_blue, fg='white').pack(pady=10)

    ramp_up_test_dialog.mainloop()


if __name__ == "__main__":
    create_ramp_up_test_panel()
