# StressTestConfig.py
import tkinter as tk
from tkinter import messagebox
import subprocess
import os

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
        messagebox.showerror("Error", f"An error occurred: {e}")
    return current_settings

# Function to perform a ping and DICOM echo
def ping_and_echo():
    ae = ae_entry.get()
    scp = scp_entry.get()
    port = port_entry.get()

    # Define the path to echoscu.exe based on the current script directory and the new location
    script_dir = os.path.dirname(os.path.abspath(__file__))  # Gets the directory where the script is located
    echoscu_exe = os.path.join(script_dir, 'TestScripts', 'echoscu.exe')  # Update the path to the new location

        # Ping test
    response = subprocess.run(["ping", scp, "-n", "1"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    ping_result = response.stdout + response.stderr
    if response.returncode == 0:
        messagebox.showinfo("Ping Test", "Ping successful!\n" + ping_result)
    else:
        messagebox.showerror("Ping Test", "Ping failed.\n" + ping_result)
        return
    
         # Perform a DICOM echo test
    echoscu_command = [echoscu_exe, '-aec', ae, scp, port]
    echo_response = subprocess.run(echoscu_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    
    # Prepare a message with the parameters used for the echo test
    parameters_info = f"AETitle: {ae}\nSCP Address: {scp}\nPort: {port}"
    if echo_response.returncode == 0:
        messagebox.showinfo("DICOM Echo Test", f"C-ECHO successful!\nParameters:\n{parameters_info}")
    else:
        messagebox.showerror("DICOM Echo Test", f"C-ECHO failed.\n{echo_response.stderr}\nParameters:\n{parameters_info}")



# Function to save the configurations to Config.bat
def save_config():
    ae = ae_entry.get()
    scp = scp_entry.get()
    port = port_entry.get()
    imgsz = image_size_var.get()
    ccnts = ccnts_entry.get()

    config_script_dir = os.path.dirname(os.path.abspath(__file__))
    config_path = os.path.join(config_script_dir, 'Config', 'Config.bat')

    # Prepare the lines to write back
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
root.geometry("350x300")  # Set the initial size of the dialog box

# More vivid blue color for the buttons
vivid_blue = '#007FFF'

# Load current settings
current_settings = load_config()

# Creating a Frame for input fields
frame = tk.Frame(root)
frame.pack(padx=10, pady=10)

# AE Title Label and Entry
tk.Label(frame, text="AE Title").grid(row=0, column=0, sticky='w')
ae_entry = tk.Entry(frame)  # Define the ae_entry variable here
ae_entry.grid(row=0, column=1)
ae_entry.insert(0, current_settings.get('AE', ''))

# SCP/IP Address Label and Entry
tk.Label(frame, text="SCP/IP Address").grid(row=1, column=0, sticky='w')
scp_entry = tk.Entry(frame)  # Define the scp_entry variable here
scp_entry.grid(row=1, column=1)
scp_entry.insert(0, current_settings.get('SCP', ''))

# Port Label and Entry
tk.Label(frame, text="Port").grid(row=2, column=0, sticky='w')
port_entry = tk.Entry(frame)  # Define the port_entry variable here
port_entry.grid(row=2, column=1)
port_entry.insert(0, current_settings.get('PORT', ''))

# Image Size Variable
image_size_var = tk.StringVar(value=current_settings.get('IMGSZ', 'KB128'))  # Define image_size_var here

# Concurrent Connections Entry
tk.Label(frame, text="Concurrent Connections").grid(row=3, column=0, sticky='w')
ccnts_entry = tk.Entry(frame)  # Define the ccnts_entry variable here
ccnts_entry.grid(row=3, column=1)
ccnts_entry.insert(0, current_settings.get('CCNTS', ''))

# Example Buttons for actions
tk.Button(frame, text="Ping and DICOM Echo", command=ping_and_echo, bg=vivid_blue, fg='white').grid(row=12, column=0, columnspan=2, pady=5, sticky='ew')
tk.Button(frame, text="Save Config", command=save_config, bg=vivid_blue, fg='white').grid(row=13, column=0, pady=5, sticky='ew')
tk.Button(frame, text="Close", command=close_application, bg=vivid_blue, fg='white').grid(row=13, column=1, pady=5, sticky='ew')

root.mainloop()
