#MainStressTester.py
import tkinter as tk
import subprocess
import os

# Get the directory of the current script
script_dir = os.path.dirname(os.path.realpath(__file__))

# Define the functions for button actions
def open_stress_test_config():
    stress_test_config_path = os.path.join(script_dir, 'StressTestConfig.py')  # Path to the StressTestConfig.py
    config_dir_path = os.path.join(script_dir, 'Config')  # Path to the Config directory
    subprocess.Popen(['python', stress_test_config_path], cwd=config_dir_path)



def open_saturation_test():
    subprocess.Popen(['python', os.path.join(script_dir, 'SaturationTest.py')])

def launch_store_scu_panel():
    scu_panel = tk.Toplevel(root)
    scu_panel.title("StoreSCU Scripts")
    scu_panel.geometry('400x400')
    scu_panel.configure(bg='#024930')

    def close_scu_panel():
        scu_panel.destroy()

    # Assuming TestScripts directory is relative to this script's directory
    test_scripts_dir = os.path.join(script_dir, 'TestScripts')

    for file in os.listdir(test_scripts_dir):
        if file.startswith("StoreSCU") and file.endswith(".cmd"):
            button_text = file.replace('.cmd', '')
            cmd_path = os.path.join(test_scripts_dir, file)
            
            def run_script(script_path=cmd_path):
                subprocess.Popen(['cmd', '/c', script_path], cwd=test_scripts_dir, shell=True)
            
            button = tk.Button(scu_panel, text=button_text, command=lambda p=cmd_path: run_script(p), **button_config)
            button.pack(pady=10)

    close_button = tk.Button(scu_panel, text="Close", command=close_scu_panel, **button_config)
    close_button.pack(side=tk.BOTTOM, pady=20)

def close_app():
    root.destroy()

def run_simple_connectivity_test():
    batch_file_path = os.path.join(script_dir, 'TestScripts', 'SimpleConnectivityTest.bat')
    subprocess.Popen(['cmd', '/c', batch_file_path], cwd=os.path.join(script_dir, 'TestScripts'), shell=True)

# Main window setup
root = tk.Tk()
root.title("The Great DICOM Stress Tester")
root.geometry('800x200')
root.configure(bg='#024930')

frame = tk.Frame(root, bg='#024930')
frame.pack(pady=50)

button_config = {
    'activebackground': '#af2324',
    'bg': '#af2324',
    'fg': 'white',
    'padx': 20,
    'pady': 10
}

test_config_button = tk.Button(frame, text="Test Config", command=open_stress_test_config, **button_config)
test_config_button.pack(side=tk.LEFT, padx=10)

simple_validation_test_button = tk.Button(frame, text="Simple Validation Test", command=run_simple_connectivity_test, **button_config)
simple_validation_test_button.pack(side=tk.LEFT, padx=10)

store_scu_panel_button = tk.Button(frame, text="Launch StoreSCU Panel", command=launch_store_scu_panel, **button_config)
store_scu_panel_button.pack(side=tk.LEFT, padx=10)

saturation_test_button = tk.Button(frame, text="Saturation Testing", command=open_saturation_test, **button_config)
saturation_test_button.pack(side=tk.LEFT, padx=10)

close_button = tk.Button(frame, text="Close", command=close_app, **button_config)
close_button.pack(side=tk.LEFT, padx=10)

root.mainloop()
