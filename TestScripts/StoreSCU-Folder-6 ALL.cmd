REM StoreSCU-Folder-6 ALL.cmd
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

GOTO :SKIP
:: This line skips the following commands and jumps to the label :SKIP.

:: The following lines are commands that execute the StoreSCU utility to send DICOM files from specified directories to a DICOM server with designated settings.
:: Each command sends files from a different directory, corresponding to different file sizes or categories.

:: Sending DICOM files from the KB032 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB032\*

:: Sending DICOM files from the KB128 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB128\*

:: Sending DICOM files from the KB512 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB512\*

:: Sending DICOM files from the MB04 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\MB01\*


:: The following commands are commented out and can be enabled as needed by removing the leading "::".
:: Sending DICOM files from the MB20 directory with implicit VR little endian transfer syntax.
::StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*

:: Sending DICOM files from the MB60 directory with implicit VR little endian transfer syntax.
::StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*

:SKIP
START "LOADER"  StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB032\*
SLEEP 5
START "LOADER"  StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB128\*
SLEEP 5
START "LOADER"  StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB256\*
SLEEP 5
START "LOADER"  StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB512\*
SLEEP 5
START "LOADER"  StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\MB01\*
:: Do not have files for following sizes
::SLEEP 5
::START "LOADER" /MIN StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*
::SLEEP 5
::START "LOADER" /MIN StoreSCU.exe -v --repeat 100 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*

:Exit
:: This is a label for an exit point in the script. It doesn't do anything by itself, but you can use the GOTO command to jump to this point in the script.

PAUSE
:: This command pauses the script and waits for the user to press any key before continuing. Since this is the last command in the script, it effectively pauses the script at the end so you can see the output before the command prompt window closes.