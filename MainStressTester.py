import tkinter as tk
from subprocess import Popen

# Define the functions for button actions
def open_stress_test_config():
    Popen(['python', 'StressTestConfig.py'])

def close_app():
    root.destroy()

# Main window
root = tk.Tk()
root.title("The Great DICOM Stress Tester")
root.geometry('500x200')  # Set the size of the main window
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

# Saturation Testing Button
saturation_test_button = tk.Button(frame, text="Saturation Testing", command=open_saturation_test, **button_config)
saturation_test_button.pack(side=tk.LEFT, padx=10)


# Test 2 Button
test2_button = tk.Button(frame, text="Test 2", **button_config)
test2_button.pack(side=tk.LEFT, padx=10)

# Close Button
close_button = tk.Button(frame, text="Close", command=close_app, **button_config)
close_button.pack(side=tk.LEFT, padx=10)

# Run the application
root.mainloop()
