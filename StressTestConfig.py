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

#Define function to close app
def close_application():
    root.destroy()  # This will close the application



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


# Creating the main window
root = tk.Tk()
root.title("Config.bat Editor")

# Load current settings
current_settings = load_config()

# Internal panel configuration
internal_panel_config = {'bg': '#024930'}  # Dark green background
label_config = {'bg': '#024930', 'fg': 'white'}  # Dark green background, white text
entry_config = {'bg': '#eda700'}  # Yellow background
radio_button_config = {'bg': '#024930', 'fg': 'white', 'selectcolor': '#024930'}  # Dark green background, white text
button_config = {'bg': '#af2324', 'fg': 'white'}  # Dark red background, white text

# Creating a Frame for input fields with the internal panel color
frame = tk.Frame(root, **internal_panel_config)
frame.pack(padx=10, pady=10)

# Labels and Entry widgets with the specified colors
tk.Label(frame, text="AE Title", **label_config).grid(row=0, column=0, sticky='w')
ae_entry = tk.Entry(frame, **entry_config)
ae_entry.grid(row=0, column=1)
ae_entry.insert(0, current_settings.get('AE', ''))

tk.Label(frame, text="SCP Address", **label_config).grid(row=1, column=0, sticky='w')
scp_entry = tk.Entry(frame, **entry_config)
scp_entry.grid(row=1, column=1)
scp_entry.insert(0, current_settings.get('SCP', ''))

tk.Label(frame, text="Port", **label_config).grid(row=2, column=0, sticky='w')
port_entry = tk.Entry(frame, **entry_config)
port_entry.grid(row=2, column=1)
port_entry.insert(0, current_settings.get('PORT', ''))

# Image Size Radio Buttons
image_size_var = tk.StringVar()
image_size_var.set(current_settings.get('IMGSZ', 'KB128'))  # default value

image_sizes = ["KB005", "KB032", "KB128", "KB256", "KB512", "MB01"]
tk.Label(frame, text="Image Size", **label_config).grid(row=3, column=0, sticky='w', columnspan=2)

for index, size in enumerate(image_sizes, start=4):
    rb = tk.Radiobutton(frame, text=size, variable=image_size_var, value=size, **radio_button_config)
    rb.grid(row=index, column=0, sticky='w')

# Concurrent Connections
tk.Label(frame, text="Concurrent Connections", **label_config).grid(row=10, column=0, sticky='w')
ccnts_entry = tk.Entry(frame, **entry_config)
ccnts_entry.grid(row=10, column=1)
ccnts_entry.insert(0, current_settings.get('CCNTS', ''))



# Create a button for PING and DICOM Echo 
ping_echo_button = tk.Button(frame, text="Ping and DICOM Echo", command=ping_and_echo, **button_config)
ping_echo_button.grid(row=11, column=0, sticky='ew')  # Set the column to 1 and make it stick to east and west

# Save button
save_button = tk.Button(frame, text="Save Config", command=save_config, **button_config)
save_button.grid(row=11, column=1, sticky='ew')  # Set the column to 0 and make it stick to east and west

# Close button
close_button = tk.Button(frame, text="Close", command=close_application, **button_config)
close_button.grid(row=11, column=2, sticky='ew')  # Set the column to 2 and make it stick to east and west

# Configure the columns within the frame to have the same weight
# This makes them expand equally within the grid
frame.grid_columnconfigure(0, weight=1)
frame.grid_columnconfigure(1, weight=1)
frame.grid_columnconfigure(2, weight=1)

root.mainloop()
