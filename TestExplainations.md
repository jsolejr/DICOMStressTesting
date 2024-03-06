## DICOM Server Testing: `Saturate*.bat` vs. `StoreSCU*.cmd`

### Purpose and Scope
- **`Saturate*.bat` Files**
  - Designed for intensive stress testing.
  - Use loops to execute `StoreSCU.exe` multiple times, simulating heavy server load.

- **`StoreSCU*.cmd` Files**
  - Tailored for controlled DICOM store operations.
  - Execute `StoreSCU.exe` consecutively with pauses, suitable for reliability assessments.

### Repetition and Load Handling
- **`Saturate*.bat`**
  - Loops the `StoreSCU` command 20 times, each with 1,000,000 DICOM image sends, for high-load scenarios.  Image Size defined at configuration

- **`StoreSCU*.cmd`**
  - Sequentially runs `StoreSCU` four times, each with 1,000 sends, with pauses for system stabilization.  Image Size defined at configuration

### DICOM Data Generation
- Both scripts generate new patient IDs, study UIDs, and series UIDs at different intervals using `+IP`, `+IS`, and `+IR` options, influencing data diversity.

### Verbose Output
- **`StoreSCU*.cmd`**
  - Enables verbose mode (`-v`) for detailed operation output.

- **`Saturate*.bat`**
  - Does not specify verbose mode, implying different output management needs.

### Path to DICOM Files
- **`Saturate*.bat`**
  - Uses `%IMGSZ%` variable (e.g., `KB128`) to reference DICOM file directory.

- **`StoreSCU*.cmd`**
  - Directly points to `KB032` directory for DICOM files.

### Configuration File Path
- **`Saturate*.bat`**
  - Calls configuration from `..\Config\Config.bat`, providing a structured directory setup.

- **`StoreSCU*.cmd`**
  - Calls configuration from `..\Config\Config.bat`, providing a structured directory setup.

---

### Summary
- `Saturate*.bat` files are for stress testing under extreme loads, whereas `StoreSCU*.cmd` files focus on controlled DICOM store operations for performance and reliability testing under specified conditions.

---