# StressTestConfig.py
import tkinter as tk
from tkinter import messagebox
import subprocess
import os

# Initialize the dictionary that will hold the entry widgets
entry_widgets = {}

# Function to load current settings from Config.bat
def load_config():
    config_script_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = os.path.join(config_script_dir, 'Config', 'Config.bat')
    current_settings = {}
    try:
        with open(config_path, 'r') as file:
            lines = file.readlines()
        for line in lines:
            if line.startswith('SET'):
                key, value = line[4:].strip().split('=')
                current_settings[key.strip()] = value.strip()
    except FileNotFoundError:
        messagebox.showerror("Error", "The config.bat file does not exist.")
    except Exception as e:
        messagebox.showerror("Error", str(e))
    return current_settings

# Function to perform a ping and DICOM echo
def ping_and_echo():
    ae = entry_widgets['AE'].get()
    scp = entry_widgets['SCP'].get()
    port = entry_widgets['PORT'].get()

    script_dir = os.path.dirname(os.path.abspath(__file__))
    echoscu_exe = os.path.join(script_dir, 'TestScripts', 'echoscu.exe')

    response = subprocess.run(["ping", scp, "-n", "1"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    ping_result = response.stdout + response.stderr
    if response.returncode == 0:
        messagebox.showinfo("Ping Test", "Ping successful!\n" + ping_result)
    else:
        messagebox.showerror("Ping Test", "Ping failed.\n" + ping_result)
        return
    
    echoscu_command = [echoscu_exe, '-aec', ae, scp, port]
    echo_response = subprocess.run(echoscu_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    
    parameters_info = f"AETitle: {ae}\nSCP Address: {scp}\nPort: {port}"
    if echo_response.returncode == 0:
        messagebox.showinfo("DICOM Echo Test", f"C-ECHO successful!\nParameters:\n{parameters_info}")
    else:
        messagebox.showerror("DICOM Echo Test", f"C-ECHO failed.\n{echo_response.stderr}\nParameters:\n{parameters_info}")

# Function to save the configurations to Config.bat
def save_config():
    ae = entry_widgets['AE'].get()
    scp = entry_widgets['SCP'].get()
    port = entry_widgets['PORT'].get()
    imgsz = image_size_var.get()
    ccnts = entry_widgets['CCNTS'].get()

    config_script_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = os.path.join(config_script_dir, 'Config', 'Config.bat')

    new_config_lines = {
        'AE': ae,
        'SCP': scp,
        'PORT': port,
        'IMGSZ': imgsz,
        'CCNTS': ccnts
    }

    try:
        with open(config_path, 'r') as file:
            lines = file.readlines()

        with open(config_path, 'w') as file:
            for line in lines:
                if line.startswith('SET'):
                    key = line[4:].strip().split('=')[0]
                    if key in new_config_lines:
                        line = f"SET {key}={new_config_lines[key]}\n"
                file.write(line)

        messagebox.showinfo("Success", "Configuration saved successfully!")
    except FileNotFoundError:
        messagebox.showerror("Error", "The config.bat file does not exist.")
    except Exception as e:
        messagebox.showerror("Error", f"An error occurred: {e}")

# Function to close the application
def close_application():
    root.destroy()

# Creating the main window
root = tk.Tk()
root.title("DICOM Stress Testing - Configuration Editor")
root.geometry("400x400")  

# Load current settings
current_settings = load_config()

# Styling for the labels and buttons
label_style = {'bg': 'white', 'fg': 'black'}
button_style = {'bg': '#007FFF', 'fg': 'white'}

frame = tk.Frame(root, bg='white')
frame.pack(padx=10, pady=10, expand=True)

# Entry labels and fields
entries = {
    "AE Title": 'AE',
    "SCP/IP Address": 'SCP',
    "Port": 'PORT',
    "Concurrent Connections": 'CCNTS'
}

row_counter = 0
for text, key in entries.items():
    tk.Label(frame, text=text, **label_style).grid(row=row_counter, column=0, sticky='w')
    entry = tk.Entry(frame)
    entry.grid(row=row_counter, column=1, sticky='ew')
    entry.insert(0, current_settings.get(key, ''))
    entry_widgets[key] = entry
    row_counter += 1

# Image Size radio buttons
tk.Label(frame, text="Image Size", **label_style).grid(row=row_counter, column=0, pady=(10, 0), sticky='w')
image_size_var = tk.StringVar(value=current_settings.get('IMGSZ', 'KB128'))
image_sizes = ["KB005", "KB032", "KB128", "KB256", "KB512", "MB01"]
for size in image_sizes:
    tk.Radiobutton(frame, text=size, variable=image_size_var, value=size, **label_style).grid(row=row_counter, column=1, sticky='w')
    row_counter += 1

# Action buttons
actions = {
    "Ping and DICOM Echo": ping_and_echo,
    "Save Config": save_config,
    "Close": close_application
}

for text, command in actions.items():
    tk.Button(frame, text=text, command=command, **button_style).grid(row=row_counter, column=0, columnspan=2, pady=5, sticky='ew')
    row_counter += 1

root.mainloop()
