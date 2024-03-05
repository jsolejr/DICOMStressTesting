# DICOM Server Testing Progression Guide

This guide outlines an optimal progression for testing your DICOM server using the provided DICOM Server Testing Toolkit. Follow these steps to systematically evaluate server performance, from basic functionality to advanced stress testing.

## 1. Basic Connectivity and Functionality Tests

### Echo Test
- **Purpose**: Verify basic communication between your Service Class User (SCU) and Service Class Provider (SCP).
- **Script**: Use an `EchoTest.bat` script or similar to perform a DICOM Echo test.

### Single File Transfer Test
- **Purpose**: Ensure the server can correctly receive and store individual DICOM files.
- **Script**: Start with a simple transfer script, such as `SimpleConnectivityTest.bat`, to send a sample DICOM file for each file size.

## 2. Single Size, Multiple Transfers

### Fixed Size Repetitive Transfer
- **Purpose**: Test the server's handling of repetitive transfers of files of the same size.
- **Script**: Use scripts like `StoreSCU-Folder-KB128.cmd` to send DICOM files of a fixed size multiple times.

## 3. Varied Size Testing

### Transfer Different File Sizes
- **Purpose**: Assess how well the server handles files of various sizes.
- **Script**: Sequentially use scripts targeting different size categories (`KB032`, `KB256`, `MB01`, etc.) to send images of varying sizes.

## 4. Concurrent Transfer Tests

### Multiple Concurrent Transfers
- **Purpose**: Simulate realistic scenarios with multiple sources sending data simultaneously.
- **Script**: Employ scripts such as `LOADER_PART10.bat` that open multiple concurrent connections.

## 5. Stress and Load Testing

### High-Volume Repetitive Transfer
- **Purpose**: Evaluate server performance under sustained heavy load.
- **Script**: Utilize stress testing scripts like `STRESS_TEST.bat` for high-volume repetitive transfers.

### Looped Testing for Endurance
- **Purpose**: Test the server's long-term reliability and endurance.
- **Script**: Customize the `LoopMe.bat` script to repetitively send DICOM files over extended periods.

## 6. Specialized and Custom Testing

### Custom Loop and Load Testing
- **Purpose**: Address specific testing needs or simulate unique conditions.
- **Script**: Adapt `LoopMe.bat` or create new scripts tailored to your specialized testing scenarios.

## 7. Performance Profiling

### Detailed Performance Analysis
- **Purpose**: Conduct in-depth performance profiling, focusing on detailed metrics.
- **Script**: Use scripts like `StoreSCU-Folder-KB128_Profiler.cmd` for detailed performance metrics.

## Documentation and Review

- **Document Findings**: Keep detailed records of performance metrics, observed anomalies, and server behavior under different test conditions.
- **Review and Adjust**: Based on test outcomes, adjust server configurations or optimizations, and repeat tests as necessary to evaluate changes.

This structured approach ensures a comprehensive evaluation of your DICOM server's capabilities, identifying potential improvements and ensuring optimal performance.
