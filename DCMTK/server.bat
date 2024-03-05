@ECHO OFF
:: Disable command echoing to clean up the script's output.

:: Start the DICOM Store SCP (storescp.exe) in a new minimized window.
:: The '--fork' option allows handling each incoming connection in a separate process for better concurrency.
:: '-aet STORESCP' sets the Application Entity Title to 'STORESCP', identifying this SCP in the DICOM network.
:: '--ignore Do not store images
:: Port 9000 - Edit as needed
start /min storescp.exe --fork -aet STORESCP --ignore 9000