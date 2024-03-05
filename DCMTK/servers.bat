REM This script uses the DICOM storescp tool to set up
REM multiple Store SCP services, each listening on
REM different ports and configured for specific operational
REM scenarios. The --fork option ensures that each incoming
REM connection is handled independently, enhancing the
REM service's capability to manage multiple simultaneous DICOM
REM transfers efficiently.

@ECHO OFF
:: Disable command echoing to clean up script output.
:: Start multiple instances of storescp.exe in minimized windows. Each instance is configured to ignore a specific port from 9000 to 9008.
:: This might be used to avoid conflicts with other services or for testing purposes.
start /min storescp.exe -aet STORESCP --ignore 9000 &
start /min storescp.exe -aet STORESCP --ignore 9001 &
start /min storescp.exe -aet STORESCP --ignore 9002 &
start /min storescp.exe -aet STORESCP --ignore 9003 &
start /min storescp.exe -aet STORESCP --ignore 9004 &
start /min storescp.exe -aet STORESCP --ignore 9005 &
start /min storescp.exe -aet STORESCP --ignore 9006 &
start /min storescp.exe -aet STORESCP --ignore 9007 &
start /min storescp.exe -aet STORESCP --ignore 9008 &

:: Start additional instances of storescp.exe, each configured with the --fork option to handle each connection in a separate process.
:: These instances listen on specific ports (9000 to 9003) and are set to store received DICOM data in the "E:\MIX\" directory.
:: Each instance uses a unique AET, potentially representing different service levels or data types (e.g., STORESCP128K for 128Kb images).
start /min storescp.exe --fork -od E:\MIX\ -aet STORESCP128K 9000 &
start /min storescp.exe --fork -od E:\MIX\ -aet STORESCP256K 9001 &
start /min storescp.exe --fork -od E:\MIX\ -aet STORESCP512K 9002 &
start /min storescp.exe --fork -od E:\MIX\ -aet STORESCPMB01 9003 &
