REM StoreSCU-Folder-1 32KB.cmd
@ECHO OFF
REM Disable echoing to keep the output window clean.

:: Store the current directory to return back to it later
SET "CURRENT_DIR=%CD%"

:: Navigate to the script's own directory
CD /D "%~dp0"

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
CALL ..\Config\Config.bat

REM Set a variable to name the output log file based on this script's name.
SET OUT=%~n0-output.txt

REM Execute StoreSCU command to send DICOM files with specified parameters.
REM -v: Enables verbose mode for detailed operation output.
REM --repeat 4000: Instructs StoreSCU to repeat the send operation 4000 times, useful for stress testing or reliability assessments.
REM +IP 1: Generates a new patient ID and name after every study sent, facilitating the creation of unique patient data for testing purposes.
REM +IS 2: Generates a new study UID after every 2 series sent, aiding in simulating multiple distinct studies within the test data, enhancing the testing scope.
REM +IR 100: Generates a new series UID after every 100 images sent, contributing to the diversity of series within the studies, useful for comprehensive testing scenarios.
REM -xi: Proposes implicit VR little endian transfer syntax only, simplifying the transfer syntax negotiation to a single, widely supported option.
REM -aet STORESCU: Defines the Application Entity Title of the Store SCU, identifying the SCU within the DICOM network.
REM -aec %AE%: Specifies the Application Entity Title of the SCP (Service Class Provider), as configured in Config.bat, indicating the target SCP for the image transfer.
REM %SCP% %PORT%: Directs the DICOM images to the SCP's address and port, as specified in Config.bat, establishing the network destination for the transfers.
REM KB032\*: Specifies the directory path containing the DICOM files to be sent, in this case, files from the KB032 directory.
START "LOADER" StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB032\*


:: Return to the original directory
CD /D "%CURRENT_DIR%"

:Exit
REM Mark the end of the script's main operations.

REM Pause the script execution to allow the user to review the output before the window closes.
PAUSE
