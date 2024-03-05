@ECHO OFF
CALL Config.bat

ECHO Simple Connectivity Test Starting...
REM The following commands send one DICOM file from each specified folder to the corresponding SCP instance.

REM Send a single DICOM file from the KB005 folder
ECHO Sending a DICOM file from the KB005 folder...
StoreSCU.exe -v -aet STORESCU -aec STORESCP128K %SCP% 9000 KB005\*.dcm

REM Send a single DICOM file from the KB032 folder
ECHO Sending a DICOM file from the KB032 folder...
StoreSCU.exe -v -aet STORESCU -aec STORESCP256K %SCP% 9001 KB032\*.dcm

REM Send a single DICOM file from the KB128 folder
ECHO Sending a DICOM file from the KB128 folder...
StoreSCU.exe -v -aet STORESCU -aec STORESCP512K %SCP% 9002 KB128\*.dcm

REM Send a single DICOM file from the KB256 folder
ECHO Sending a DICOM file from the KB256 folder...
StoreSCU.exe -v -aet STORESCU -aec STORESCPMB01 %SCP% 9003 KB256\*.dcm

ECHO Simple Connectivity Test Completed.
PAUSE

