@ECHO OFF
:: Call the configuration batch file to set up environment variables
CALL Config.bat

:: Set the output file name based on the name of the current script
SET OUT=%~n0-output.txt

:: Set the image size to be used in the StoreSCU command
SET IMGSZ=KB128

:: Start the StoreSCU command in a minimized window titled "LOADER"
:: The command is repeated 1,000,000 times
:: +IP 1, +IS 2, and +IR 2000 are options for the command
:: -xi specifies that the command should exit on invalid data
:: -aet and -aec specify the calling and called AE titles
:: The last argument is a wildcard for files in the %IMGSZ% directory
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
:: Wait for 2 seconds before starting the next command
SLEEP 2

:: The above command is repeated 5 times with a 2-second pause between each repetition
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2

:: Exit label, the script jumps here when it needs to exit
:Exit

:: Pause the script before it ends, so the user can see any output
PAUSE