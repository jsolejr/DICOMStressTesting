# Test Explanations for DICOM Stress Testing Toolkit

This document outlines the various tests included in the DICOM Stress Testing Toolkit, detailing the purpose and usage of each script. The toolkit aims to evaluate the robustness, performance, and reliability of DICOM servers under various operational scenarios.

## Echo Test

### Purpose
Validates basic connectivity and communication between a Service Class User (SCU) and a Service Class Provider (SCP).

### Script
- `EchoTest.bat`: Performs a DICOM Echo Request (C-ECHO) to verify the connection between the SCU and SCP.

## Simple Connectivity Test

### Purpose
Ensures the server can correctly receive and store individual DICOM files, maintaining data integrity.

### Script
- `SimpleConnectivityTest.bat`: Sends a single DICOM file from predefined folders (e.g., KB005, KB032) to the server and checks for successful transfer.

## Repetitive Transfer Tests

### Purpose
Evaluates the server's handling of repetitive transfers of files of the same size, testing performance stability under sustained load.

### Scripts
- `StoreSCU-Folder-1 32KB.cmd`
- `StoreSCU-Folder-2 128.cmd`
- `StoreSCU-Folder-3 512 KB.cmd`: These scripts are used to send multiple DICOM files of fixed sizes (e.g., 32KB, 128KB, 512KB) to the server in a sequence.

## Concurrent Transfer Test

### Purpose
Simulates realistic scenarios with multiple sources sending data simultaneously to test the server's concurrency handling capabilities.

### Script
- `LOADER_PART10.bat`: Opens multiple concurrent connections and sends DICOM files to the server, simulating a real-world operational condition.

## Stress Testing

### Purpose
Puts the server under high demand to test its limits and endurance, identifying potential bottlenecks and performance ceilings.

### Script
- `STRESS_TEST.bat`: Executes high-volume repetitive transfers to stress-test the server beyond typical operational loads.

## Saturation Tests

### Purpose
Evaluates the server's performance under extreme conditions, with a high number of concurrent threads sending data.

### Scripts
- `saturate - 5.bat`
- `saturate - 10.bat`
- `saturate - 15.bat`
- `saturate - 20.bat`: These scripts vary the number of concurrent threads (e.g., 5, 10, 15, 20) to saturate the server, testing its handling of simultaneous data streams.
