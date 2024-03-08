# DICOM Stress Testing Toolkit Overview

Welcome to the DICOM Stress Testing Toolkit, a comprehensive suite designed to evaluate and ensure the robust performance of DICOM servers under various load conditions. This toolkit simulates real-world scenarios, providing insights into the server's capacity to handle different types and volumes of DICOM communications.

## Features

- **Configurable Test Environment:** Customize tests according to your specific server setup and requirements.
- **Wide Range of Tests:** From basic connectivity and single file transfers to high-volume stress tests and endurance evaluations.
- **Performance Analysis:** Detailed logs and performance metrics to analyze server behavior under stress.
- **Modular Design:** Easy to extend and adapt for specific testing needs or to include new types of tests.

## Getting Started

1. **Configure Your Environment:** Use `Config.bat` to set your DICOM server details and preferred testing parameters.
2. **Select Your Tests:** Choose from a variety of predefined test scripts tailored for different testing scenarios.
3. **Run Tests:** Execute the chosen test scripts and monitor your server's performance.
4. **Analyze Results:** Review the generated logs and performance data to identify potential bottlenecks or issues.

## Toolkit Components

### Batch Scripts

- **Echo Test:** Validates basic connectivity and communication between SCU and SCP.
- **Transfer Tests:** Includes single file, fixed size repetitive, and varied size transfers to evaluate server handling and throughput.
- **Concurrent Transfers:** Simulates real-world scenarios with simultaneous data transmissions.
- **Stress Tests:** Puts the server under high demand to test its limits and endurance.

### Configuration Files

- **`Config.bat`:** Central configuration script to set up your testing environment, including server details and test parameters.

### Test Folders

- Organized by file size (`KB005`, `KB128`, `MB01`, etc.) to facilitate targeted testing scenarios.

## Customization and Extension

The modular structure and clear documentation make it easy to add new tests or adapt existing ones to meet your unique requirements.

## Troubleshooting and Tips

- Ensure server accessibility and proper configuration prior to testing.
- Verify the alignment between script paths and intended test files.
- Consider system resources and potential network constraints when planning extensive testing sessions.

## Contributing

Your contributions are welcome! Whether it's adding new features, improving existing tests, or reporting issues, your input helps make this toolkit better for everyone.
