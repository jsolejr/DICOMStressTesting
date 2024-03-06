import tkinter as tk
import subprocess
import os

# Define the functions for button actions
def open_stress_test_config():
    subprocess.Popen(['python', 'StressTestConfig.py'])

def open_saturation_test():
    subprocess.Popen(['python', 'SaturationTest.py'])

def launch_store_scu_panel():
    # Create a top-level window for StoreSCU buttons
    scu_panel = tk.Toplevel(root)
    scu_panel.title("StoreSCU Scripts")
    scu_panel.geometry('400x400')  # Adjust the size as needed
    scu_panel.configure(bg='#024930')  # Set background color

    # Function to close the StoreSCU panel
    def close_scu_panel():
        scu_panel.destroy()

    # Find all StoreSCU*.cmd scripts in the TestScripts folder
    for file in os.listdir(test_scripts_dir):
        if file.startswith("StoreSCU") and file.endswith(".cmd"):
            button_text = file.replace('.cmd', '')  # Button text is the file name without the extension
            cmd_path = os.path.join(test_scripts_dir, file)  # Full path to the cmd script
            
            # Function to run the cmd script
            def run_script(script_path=cmd_path):
                subprocess.Popen(['cmd', '/c', script_path], cwd=test_scripts_dir, shell=True)
            
            # Create a button for each script
            button = tk.Button(scu_panel, text=button_text, command=lambda p=cmd_path: run_script(p), **button_config)
            button.pack(pady=10)

    # Add a Close button at the bottom
    close_button = tk.Button(scu_panel, text="Close", command=close_scu_panel, **button_config)
    close_button.pack(side=tk.BOTTOM, pady=20)


def close_app():
    root.destroy()

# Add this function to run the SimpleConnectivityTest.bat
def run_simple_connectivity_test():
    batch_file_path = os.path.join(test_scripts_dir, 'SimpleConnectivityTest.bat')  # Full path to the batch file
    subprocess.Popen(['cmd', '/c', batch_file_path], cwd=test_scripts_dir, shell=True)  # Set the working directory

# Assuming this script is in the root folder
test_scripts_dir = os.path.join(os.getcwd(), 'TestScripts')

# Main window
root = tk.Tk()
root.title("The Great DICOM Stress Tester")
root.geometry('800x200')  # Set the size of the main window
root.configure(bg='#024930')  # Main box color

# Frame for buttons with the same color as the main box
frame = tk.Frame(root, bg='#024930')
frame.pack(pady=50)

# Button configuration
button_config = {
    'activebackground': '#af2324',
    'bg': '#af2324',  # Button color
    'fg': 'white',
    'padx': 20,
    'pady': 10
}

# Test Config Button
test_config_button = tk.Button(frame, text="Test Config", command=open_stress_test_config, **button_config)
test_config_button.pack(side=tk.LEFT, padx=10)

# Simple Validation Test Button
simple_validation_test_button = tk.Button(frame, text="Simple Validation Test", command=run_simple_connectivity_test, **button_config)
simple_validation_test_button.pack(side=tk.LEFT, padx=10)

# StoreSCU panel launch button
store_scu_panel_button = tk.Button(frame, text="Launch StoreSCU Panel", command=launch_store_scu_panel, **button_config)
store_scu_panel_button.pack(side=tk.LEFT, padx=10)

# Saturation Testing Button
saturation_test_button = tk.Button(frame, text="Saturation Testing", command=open_saturation_test, **button_config)
saturation_test_button.pack(side=tk.LEFT, padx=10)

# Close Button
close_button = tk.Button(frame, text="Close", command=close_app, **button_config)
close_button.pack(side=tk.LEFT, padx=10)

# Start the GUI event loop
root.mainloop()
