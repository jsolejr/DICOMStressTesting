import tkinter as tk
import subprocess
import os
import psutil
import time
import csv
from datetime import datetime
from threading import Thread, Event

# Define script directory globally
script_dir = os.path.dirname(os.path.realpath(__file__))

# Helper function to open subprocesses correctly depending on the script's requirements
def run_subprocess(command, cwd=None, shell=False):
    subprocess.Popen(command, cwd=cwd, shell=shell)

# Define output_dir, duration, and interval globally
output_dir = os.path.join(script_dir, "Outputs")
duration = 3600  # 1 hour
interval = 5     # 5 seconds

# Make sure to create the output directory if it does not exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

def open_stress_test_config():
    script_path = os.path.join(script_dir, 'StressTestConfig.py')
    run_subprocess(['python', script_path])

def RampUpTests():
    script_path = os.path.join(script_dir, 'RampUpTests.py')
    run_subprocess(['python', script_path])

def saturation_test():
    script_path = os.path.join(script_dir, 'SaturationTest.py')
    run_subprocess(['python', script_path])

# Function to get the performance data
def get_performance_data():
    bytes_in_megabyte = 1024 ** 2

    cpu_percent = psutil.cpu_percent(interval=None)
    available_memory_mb = psutil.virtual_memory().available / bytes_in_megabyte
    disk_read_bytes_per_sec = psutil.disk_io_counters().read_bytes / bytes_in_megabyte
    disk_write_bytes_per_sec = psutil.disk_io_counters().write_bytes / bytes_in_megabyte
    bytes_received_per_sec = psutil.net_io_counters().bytes_recv / bytes_in_megabyte
    bytes_sent_per_sec = psutil.net_io_counters().bytes_sent / bytes_in_megabyte

    return {
        "Timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "CPU %": round(cpu_percent, 1),
        "Available Memory (MB)": round(available_memory_mb, 2),
        "Disk Read (MB/sec)": round(disk_read_bytes_per_sec, 2),
        "Disk Write (MB/sec)": round(disk_write_bytes_per_sec, 2),
        "Network Received (MB/sec)": round(bytes_received_per_sec, 2),
        "Network Sent (MB/sec)": round(bytes_sent_per_sec, 2)
    }

stop_monitoring = Event()

# Performance Monitoring
def performance_monitoring(output_dir, duration=3600, interval=5):
    current_timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    output_file_name = f"performance_log_{current_timestamp}.csv"
    output_file_path = os.path.join(output_dir, output_file_name)

    results = []
    end_time = time.time() + duration
    try:
        while time.time() < end_time and not stop_monitoring.is_set():
            result = get_performance_data()
            results.append(result)
            time.sleep(interval)
    except Exception as e:
        print(f"Monitoring stopped due to: {e}")
    finally:
        with open(output_file_path, 'w', newline='') as csvfile:
            fieldnames = results[0].keys()
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            for row in results:
                writer.writerow(row)
        print(f"Performance data collected and saved to {output_file_path}")

def stop_performance_monitoring():
    stop_monitoring.set()

# GUI Code
def create_main_panel():
    root = tk.Tk()
    root.title("DICOM Stress Testing Suite")
    root.geometry("350x300")  # Set the initial size of the dialog box

    # Create the main frame
    main_frame = tk.Frame(root)
    main_frame.pack(fill='both', expand=True)

    # More vivid blue color for the buttons
    vivid_blue = '#007FFF'

    # Add buttons that will show sub-frames for each functionality, with vivid blue color
    tk.Button(main_frame, text="Open Stress Test Config", command=open_stress_test_config, bg=vivid_blue, fg='white').pack(pady=10)
    tk.Button(main_frame, text="Open RampUp Tests", command=RampUpTests, bg=vivid_blue, fg='white').pack(pady=10)
    tk.Button(main_frame, text="Open Saturation Test", command=saturation_test, bg=vivid_blue, fg='white').pack(pady=10)

    # Button to start performance monitoring
    tk.Button(main_frame, text="Start Performance Monitoring", command=lambda: Thread(target=performance_monitoring, args=(output_dir, duration, interval)).start(), bg=vivid_blue, fg='white').pack(pady=10)

    # Button to stop performance monitoring
    tk.Button(main_frame, text="Stop Performance Monitoring", command=stop_performance_monitoring, bg=vivid_blue, fg='white').pack(pady=10)

    # Close button to exit the application
    tk.Button(main_frame, text="Exit", command=root.destroy, bg=vivid_blue, fg='white').pack(pady=10)

    root.mainloop()

if __name__ == "__main__":
    create_main_panel()
