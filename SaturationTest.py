import tkinter as tk
from subprocess import Popen
import os

# Function to run the saturation test batch files
def run_saturation_test(batch_file):
    Popen(['start', 'cmd', '/c', batch_file], shell=True)

# Create the saturation test dialog window with the specified color scheme
saturation_test_dialog = tk.Tk()
saturation_test_dialog.title("Saturation Test")
saturation_test_dialog.configure(bg='#024930')  # Dark green background

# Frame for buttons with the same color as the main box
button_frame = tk.Frame(saturation_test_dialog, bg='#024930')
button_frame.pack(pady=50)

# Button configuration with the specified colors
button_config = {
    'activebackground': '#af2324',
    'bg': '#af2324',  # Dark red background
    'fg': 'white',
    'padx': 20,
    'pady': 10
}

# Function to run the saturation test batch files
def run_saturation_test(batch_file):
    # Define the path to the TestScripts folder based on the current script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))  # Gets the directory where the script is located
    batch_file_path = os.path.join(script_dir, 'TestScripts', batch_file)  # Adds the TestScripts folder to the path
    Popen(['start', 'cmd', '/c', batch_file_path], shell=True)

# Buttons to launch saturation tests
buttons = [
    {"text": "Saturate - 5 Threads", "command": lambda: run_saturation_test('saturate - 5.bat')},
    {"text": "Saturate - 10 Threads", "command": lambda: run_saturation_test('saturate-10.bat')},
    {"text": "Saturate - 15 Threads", "command": lambda: run_saturation_test('saturate-15.bat')},
    {"text": "Saturate - 20 Threads", "command": lambda: run_saturation_test('saturate-20.bat')}
]

for button in buttons:
    tk.Button(button_frame, text=button["text"], command=button["command"], **button_config).pack(side=tk.LEFT, padx=10)

# Close button
tk.Button(button_frame, text="Close", command=saturation_test_dialog.destroy, **button_config).pack(side=tk.LEFT, padx=10)

# Start the main loop
saturation_test_dialog.mainloop()
