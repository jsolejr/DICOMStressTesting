# DICOM Server Testing Toolkit Overview

This document provides an overview and usage guide for a comprehensive DICOM Server Testing Toolkit designed to evaluate DICOM server performance under various conditions. The toolkit includes a collection of batch scripts and a structured folder setup containing DICOM files of specific sizes.

## Folder Structure

The toolkit comprises several folders named according to the size of the DICOM file they contain:

- `KB005`, `KB032`, `KB128`, `KB256`, `KB512`: Each folder contains a DICOM file corresponding to the folder's name, representing the file size in kilobytes.
- `MB01`: Contains a DICOM file approximately 1 megabyte in size.
- `TEST`: The purpose of this folder is unspecified but may contain specific test cases or miscellaneous DICOM files.

## Batch Scripts

The toolkit includes various batch scripts, each serving a specific testing purpose:

- `StoreSCU.exe` related scripts: Facilitate sending DICOM images to a DICOM server. Scripts are named to suggest the size of the DICOM files they are intended to send, e.g., `StoreSCU-Folder-KB128.cmd`. However, attention should be paid to the actual directory paths specified within each script to ensure consistency with the intended test case.
- `Config.bat`: Sets up essential environment variables such as the AE title for the SCU, the SCP's IP address, and the port number. This script is called at the beginning of most other scripts to ensure a consistent testing environment.
- `Loader.bat`, `LOADER_PART10.bat`: Utility scripts for logging and executing DICOM file transfers under various conditions, including support for multiple concurrent connections.
- `LoopMe.bat`: A template script for executing a set of commands repetitively, allowing for customized loop-based testing.
- `STRESS_TEST.bat`, `Quiet-StoreSCU-Folder-KB512.bat`, and others: Aimed at stress testing the DICOM server with repetitive sends of DICOM images, potentially with varying sizes and configurations.

## Testing Scenarios

The toolkit supports a range of testing scenarios, from basic functionality tests with small DICOM files to stress and capacity testing with larger files and high-frequency transfers. The structured approach allows for systematic evaluation across different file sizes and network conditions.

## Usage Guide

1. **Configuration**: Begin by reviewing and customizing the `Config.bat` file to match your DICOM server settings, including AE titles, IP addresses, and port numbers.
2. **Selecting Test Cases**: Choose the appropriate batch script(s) based on the testing scenario. Ensure that the script's directory paths align with the intended DICOM file sizes.
3. **Running Tests**: Execute the selected batch script(s). Monitor the output and any log files generated for insights into server performance and behavior.
4. **Interpreting Results**: Review the output and logs to assess the DICOM server's handling of the test cases, noting any performance bottlenecks, errors, or unexpected behaviors.

## Troubleshooting and Tips

- Ensure that the DICOM server is correctly configured and accessible from the testing environment.
- Verify that the folder structure and DICOM file sizes are consistent with the test cases being executed.
- For extended testing or high-frequency transfer scenarios, monitor system and network resources to prevent overload.

## Extending the Toolkit

The toolkit's modular design allows for easy extension with additional DICOM file sizes, test scenarios, or customized scripts. When adding new components, maintain consistency with the existing naming conventions and configuration settings to ensure seamless integration.

---

This README provides a foundational understanding of the DICOM Server Testing Toolkit's capabilities and usage. For specific testing requirements or advanced configurations, consider customizing the scripts and settings to better suit your environment and objectives.
