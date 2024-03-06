@ECHO OFF

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
CALL ..\Config\Config.bat

ECHO Simple Connectivity Test Starting...

:: Assume success initially
SET "TEST_SUCCESSFUL=1"

REM The following commands send one DICOM file from each specified folder to the corresponding SCP instance.
REM If any command fails, we note that the test failed.

ECHO Sending a DICOM file from the KB005 folder...
StoreSCU.exe -v -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB005\*.dcm
IF %ERRORLEVEL% NEQ 0 SET "TEST_SUCCESSFUL=0"

ECHO Sending a DICOM file from the KB032 folder...
StoreSCU.exe -v -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB032\*.dcm
IF %ERRORLEVEL% NEQ 0 SET "TEST_SUCCESSFUL=0"

ECHO Sending a DICOM file from the KB128 folder...
StoreSCU.exe -v -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB128\*.dcm
IF %ERRORLEVEL% NEQ 0 SET "TEST_SUCCESSFUL=0"

ECHO Sending a DICOM file from the KB256 folder...
StoreSCU.exe -v -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB256\*.dcm
IF %ERRORLEVEL% NEQ 0 SET "TEST_SUCCESSFUL=0"

ECHO Simple Connectivity Test Completed.

:: Create a VBS file to show a message box with the result
SET "VBS_FILE=%TEMP%\show_message.vbs"

IF "%TEST_SUCCESSFUL%"=="1" (
    ECHO MsgBox "The Simple Connectivity Test was successful.", vbInformation, "Test Result" > "%VBS_FILE%"
) ELSE (
    ECHO MsgBox "The Simple Connectivity Test failed.", vbExclamation, "Test Result" > "%VBS_FILE%"
)

:: Execute the VBS file to show the dialogue
CSCRIPT //NoLogo "%VBS_FILE%"
DEL "%VBS_FILE%"

PAUSE
