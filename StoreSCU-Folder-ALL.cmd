@ECHO OFF
:: This line turns off the display of commands in the command prompt

CALL Config.bat
:: This line calls another batch file named Config.bat. This is typically used to set up environment variables or configurations that will be used later in the script.

SET OUT=%~n0-output.txt
:: This line sets an environment variable OUT to the name of the script file with "-output.txt" appended to it.

%~d0
:: This line changes the current drive to the drive where the script is located.

CD %~dp0
:: This line changes the current directory to the directory where the script is located.

GOTO :SKIP
:: This line skips the following commands and jumps to the label :SKIP.

:: The following lines are commands that execute the StoreSCU utility to send DICOM files from specified directories to a DICOM server with designated settings.
:: Each command sends files from a different directory, corresponding to different file sizes or categories.

:: Sending DICOM files from the KB032 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*

:: Sending DICOM files from the KB128 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*

:: Sending DICOM files from the KB512 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB512\*

:: Sending DICOM files from the MB04 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB04\*

:: Sending DICOM files from the MB1 directory with implicit VR little endian transfer syntax.
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB1\*

:: The following commands are commented out and can be enabled as needed by removing the leading "::".
:: Sending DICOM files from the MB20 directory with implicit VR little endian transfer syntax.
::StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*

:: Sending DICOM files from the MB60 directory with implicit VR little endian transfer syntax.
::StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*


:SKIP
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB256\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MBKB512\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 400 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB01\*
:: Do not have files for following sizes
::SLEEP 5
::START "LOADER" /MIN StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*
::SLEEP 5
::START "LOADER" /MIN StoreSCU.exe -v --repeat 100 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*

:Exit
:: This is a label for an exit point in the script. It doesn't do anything by itself, but you can use the GOTO command to jump to this point in the script.

PAUSE
:: This command pauses the script and waits for the user to press any key before continuing. Since this is the last command in the script, it effectively pauses the script at the end so you can see the output before the command prompt window closes.