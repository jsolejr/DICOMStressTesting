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

REM Sequence a send for each size 
START "LOADER" StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB032\*
SLEEP 1
START "LOADER" StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB128\*
SLEEP 1
START "LOADER" StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB256\*
SLEEP 1
START "LOADER" StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB512\*
SLEEP 1
START "LOADER" StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\MB01\*

:Exit
:: This is a label for an exit point in the script. It doesn't do anything by itself, but you can use the GOTO command to jump to this point in the script.

PAUSE
:: This command pauses the script and waits for the user to press any key before continuing. Since this is the last command in the script, it effectively pauses the script at the end so you can see the output before the command prompt window closes.