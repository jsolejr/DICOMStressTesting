@ECHO OFF
:: Disable echoing of commands to keep the output clean.

:: Get the directory of the current batch file
SET "BATCH_DIR=%~dp0"

:: Change directory to the batch file directory to ensure relative paths work
CD /D "%BATCH_DIR%"

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
CALL ..\Config\Config.bat

:: Define a variable to name the output log file based on the name of this script.
SET OUT=%~n0-output.txt

:: Specify the size of DICOM images that will be used in the StoreSCU command. Overwrites the config.bat value. Ensure this matches the folder name containing the images.
SET IMGSZ=KB128

:: Update the path to the Images folder according to the new directory structure
SET IMAGE_PATH=%BATCH_DIR%..\Images\%IMGSZ%

:: The following block of code starts the StoreSCU command in a minimized window titled "LOADER"
:: The command is repeated 1,000,000 times
:: +IP 1, +IS 2, and +IR 2000 are options for the command
:: -xi specifies that the command should exit on invalid data
:: -aet and -aec specify the calling and called AE titles
:: The last argument is a wildcard for files in the %IMGSZ% directory
:: After each command execution, the script sleeps for 2 seconds before starting the next command
:: This block is repeated 10 times

FOR /L %%i IN (1,1,15) DO (
    START "LOADER" StoreSCU.exe -v --repeat 500000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% "%IMAGE_PATH%\*"
    SLEEP 5