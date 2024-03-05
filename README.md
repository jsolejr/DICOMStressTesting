# DICOM Server Testing Toolkit Overview

This document provides an overview and usage guide for a comprehensive **DICOM Server Testing Toolkit** designed to evaluate DICOM server performance under various conditions. The toolkit includes a collection of batch scripts and a structured folder setup containing DICOM files of specific sizes.

## Folder Structure

The toolkit comprises several folders, each named according to the size of the DICOM file they contain, facilitating a wide range of tests:

- **Small File Sizes:** `KB005`, `KB032`, `KB128`
- **Medium to Large File Sizes:** `KB256`, `KB512`, `MB01`
- **Special Cases:** `TEST` - This folder's purpose is unspecified but may contain specific test cases or miscellaneous DICOM files.

## Batch Scripts

A variety of batch scripts are included, each tailored for specific testing purposes:

### StoreSCU Scripts
Scripts such as `StoreSCU-Folder-KB128.cmd` are designed to send DICOM images to a server, with names suggesting the intended image size. **Ensure the script's directory paths align with the intended test case.**

### Configuration Script
`Config.bat` initializes environment variables like the AE title, SCP's IP, and port number, ensuring a consistent testing environment across scripts.

### Utility Scripts
- `Loader.bat` and `LOADER_PART10.bat` log and execute file transfers, supporting multiple concurrent connections.
- `LoopMe.bat` offers a template for loop-based testing, allowing for repetitive command execution.

### Stress Testing Scripts
`STRESS_TEST.bat` and similar scripts simulate high-load scenarios by sending DICOM images repeatedly, testing server endurance and capacity.

## Testing Scenarios

The toolkit supports testing from basic functionality with small files to extensive stress testing with large files and high-frequency transfers, providing insights into server performance across a spectrum of conditions.

## Usage Guide

1. **Configure** your testing environment using `Config.bat`, tailoring settings to your DICOM server.
2. **Select Test Cases** appropriate for your testing goals, ensuring script paths correspond to the desired DICOM file sizes.
3. **Execute Tests** using the chosen batch scripts, closely monitoring outputs and logs for performance metrics.
4. **Analyze Results** to gauge server performance, identifying any potential bottlenecks or errors.

## Troubleshooting and Tips

- Confirm server accessibility and correct configuration before testing.
- Ensure alignment between script paths and intended DICOM file sizes.
- Monitor system resources during extensive testing to avoid overloading.

## Extending the Toolkit

The toolkit's modular structure allows for easy addition of new file sizes, test scenarios, or scripts, enabling customization to fit specific testing needs.

---

This README aims to provide a clear understanding of the DICOM Server Testing Toolkit's functionality and application. For specialized testing requirements, consider adapting the scripts and configurations to better suit your testing environment.
