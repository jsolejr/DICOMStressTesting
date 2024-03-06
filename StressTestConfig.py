import tkinter as tk
from tkinter import messagebox

# Function to load current settings from Config.bat
def load_config():
    with open('Config.bat', 'r') as file:
        lines = file.readlines()
    
    current_settings = {}
    for line in lines:
        if line.startswith('SET'):
            key, value = line[4:].strip().split('=')
            current_settings[key] = value
            
    return current_settings

# Function to save the configurations to Config.bat
def save_config():
    ae = ae_entry.get()
    scp = scp_entry.get()
    port = port_entry.get()
    imgsz = image_size_var.get()
    ccnts = ccnts_entry.get()

    config_lines = [
        "REM --Put your Connection information here -- \n",
        f"SET AE={ae}\n",
        f"SET SCP={scp}\n",
        f"SET PORT={port}\n",
        "\nREM --Specify your image size to test with --\n",
        "REM --Valid values: KB005,KB032,KB128,KB256,KB512,MB01 --\n",
        f"SET IMGSZ={imgsz}\n",
        "\nREM --Specify the Number of concurrent connections to open--\n",
        f"SET CCNTS={ccnts}\n"
    ]
    
    with open('Config.bat', 'w') as file:
        file.writelines(config_lines)
    messagebox.showinfo("Success", "Configuration saved successfully!")
    root.destroy()

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

# Save button
save_button = tk.Button(frame, text="Save Config", command=save_config, **button_config)
save_button.grid(row=11, column=1)

root.mainloop()
