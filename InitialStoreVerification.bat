@ECHO OFF
CALL Config.bat

:: Sending a single DICOM file from each size category for connectivity testing.
:: Utilizing verbose mode for detailed output.

ECHO Sending a single DICOM file from the KB005 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% KB005\*.dcm

ECHO Sending a single DICOM file from the KB032 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% KB032\*.dcm

ECHO Sending a single DICOM file from the KB128 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% KB128\*.dcm

ECHO Sending a single DICOM file from the KB256 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% KB256\*.dcm

ECHO Sending a single DICOM file from the KB512 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% KB512\*.dcm

ECHO Sending a single DICOM file from the MB01 folder...
StoreSCU.exe -v -aet %AE% -aec %AE% %SCP% %PORT% MB01\*.dcm

ECHO All specified DICOM files have been sent for connectivity testing.
PAUSE
