:: Turn off the command echo
@ECHO OFF

:: Call the configuration batch file to set up environment variables
CALL Config.bat

:: Set the output file name based on the name of the current script
SET OUT=%~n0-output.txt

:: Set the image size to be used in the StoreSCU command.  This should match the value of the folder name containing the image you want to test with.
SET IMGSZ=KB128

:: The following block of code starts the StoreSCU command in a minimized window titled "LOADER"
:: The command is repeated 1,000,000 times
:: +IP 1, +IS 2, and +IR 2000 are options for the command
:: -xi specifies that the command should exit on invalid data
:: -aet and -aec specify the calling and called AE titles
:: The last argument is a wildcard for files in the %IMGSZ% directory
:: After each command execution, the script sleeps for 2 seconds before starting the next command
:: This block is repeated 10 times

FOR /L %%i IN (1,1,15) DO (
    START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    SLEEP 5