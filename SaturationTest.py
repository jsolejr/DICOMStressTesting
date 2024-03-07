#SaturationTest.py
import tkinter as tk
import subprocess
import os
from tkinter import messagebox

# Assuming SaturationTest.py is in the root folder
root_dir = os.path.dirname(os.path.abspath(__file__))
test_scripts_dir = os.path.join(root_dir, 'TestScripts')

# Function to run the saturation test batch files
def run_saturation_test(batch_file):
    batch_file_path = os.path.join(test_scripts_dir, batch_file)  # Full path to the batch file

    # Debugging: Print the path to verify it's correct
    print(f"Attempting to run batch file at path: {batch_file_path}")

    if not os.path.exists(batch_file_path):
        messagebox.showerror("Error", f"Batch file not found: {batch_file_path}")
        return  # Exit the function if the batch file does not exist

    # Execute the batch file within the TestScripts directory
    subprocess.Popen(['cmd', '/c', batch_file_path], cwd=test_scripts_dir, shell=True)

# Create the main dialog window, replicating the style and structure of Master.py
def create_saturation_test_panel():
    saturation_test_dialog = tk.Tk()
    saturation_test_dialog.title("DICOM Saturation Tests")
    saturation_test_dialog.geometry("350x300")  # Set the initial size of the dialog box

    # Create the main frame, similar to Master.py
    main_frame = tk.Frame(saturation_test_dialog)
    main_frame.pack(fill='both', expand=True)

    # More vivid blue color for the buttons
    vivid_blue = '#007FFF'

    # Buttons to launch saturation tests, using the structure from Master.py
    buttons = [
        {"text": "Saturate - 5 Threads", "command": lambda: run_saturation_test('saturate - 5.bat')},
        {"text": "Saturate - 10 Threads", "command": lambda: run_saturation_test('saturate-10.bat')},
        {"text": "Saturate - 15 Threads", "command": lambda: run_saturation_test('saturate-15.bat')},
        {"text": "Saturate - 20 Threads", "command": lambda: run_saturation_test('saturate - 20.bat')}
    ]

    for button in buttons:
        tk.Button(main_frame, text=button["text"], command=button["command"], bg=vivid_blue, fg='white').pack(pady=10)

    # Close button to exit the application, matching the style from Master.py
    tk.Button(main_frame, text="Exit", command=saturation_test_dialog.destroy, bg=vivid_blue, fg='white').pack(pady=10)

    saturation_test_dialog.mainloop()

if __name__ == "__main__":
    create_saturation_test_panel()
