@ECHO OFF
:: Disable command echoing to clean up the script's output.

:: Start the DICOM Store SCP (storescp.exe) in a new minimized window.
:: The '--fork' option allows handling each incoming connection in a separate process for better concurrency.
:: '-aet STORESCP' sets the Application Entity Title to 'STORESCP', identifying this SCP in the DICOM network.
:: '--ignore 9000' tells the SCP to ignore any requests on port 9000, potentially for security or configuration reasons.
:: The '&' at the end allows the command to run asynchronously, letting the batch file proceed without waiting for this command to complete.
start /min storescp.exe --fork -aet STORESCP --ignore 9000 &
