#PythonMonitoring.py
import psutil
import time
import csv
import os
from datetime import datetime

# Define the output folder path relative to the script directory
script_dir = os.path.dirname(os.path.realpath(__file__))
output_dir = os.path.join(script_dir, "Outputs")

# Ensure the Outputs directory exists; create it if it doesn't
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Get the current timestamp in a file-friendly format (e.g., "2024-03-07_12-30-45")
current_timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

# Append the timestamp to the output file name
output_file_name = f"performance_log_{current_timestamp}.csv"
output_file_path = os.path.join(output_dir, output_file_name)


# Define the performance counters to monitor (using psutil)
def get_performance_data():
    # Conversion constants
    bytes_in_megabyte = 1024 ** 2
    bytes_in_gigabyte = 1024 ** 3

    # Current performance data
    cpu_percent = psutil.cpu_percent(interval=None)
    available_memory_mb = psutil.virtual_memory().available / bytes_in_megabyte
    disk_read_bytes_per_sec = psutil.disk_io_counters().read_bytes / bytes_in_megabyte  # Convert to MB
    disk_write_bytes_per_sec = psutil.disk_io_counters().write_bytes / bytes_in_megabyte  # Convert to MB
    bytes_received_per_sec = psutil.net_io_counters().bytes_recv / bytes_in_megabyte  # Convert to MB
    bytes_sent_per_sec = psutil.net_io_counters().bytes_sent / bytes_in_megabyte  # Convert to MB

    return {
        "Timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "CPU %": round(cpu_percent, 1),
        "Available Memory (MB)": round(available_memory_mb, 2),
        "Disk Read (MB/sec)": round(disk_read_bytes_per_sec, 2),
        "Disk Write (MB/sec)": round(disk_write_bytes_per_sec, 2),
        "Network Received (MB/sec)": round(bytes_received_per_sec, 2),
        "Network Sent (MB/sec)": round(bytes_sent_per_sec, 2)
    }

# Define the duration and interval for monitoring (in seconds)
duration = 3600  # 1 hour
interval = 5     # 5 seconds

end_time = time.time() + duration

# Start the monitoring loop
results = []

try:
    while time.time() < end_time:
        # Collect performance data
        result = get_performance_data()
        results.append(result)
        
        # Wait for the specified interval before collecting the next set of data
        time.sleep(interval)
except KeyboardInterrupt:
    print("Script interrupted. Saving collected data...")

# Export the results to a CSV file
with open(output_file_path, 'w', newline='') as csvfile:
    fieldnames = results[0].keys()
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for row in results:
        writer.writerow(row)

print(f"Performance data collected and saved to {output_file_path}")
