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
:: Commented out to use the config.bat setting
:: SET IMGSZ=KB128

:: Update the path to the Images folder according to the new directory structure
SET IMAGE_PATH=%BATCH_DIR%..\Images\%IMGSZ%


:: Execute the StoreSCU command in a minimized window titled "LOADER". The command is configured to send DICOM files and is repeated 2,000,000 times to simulate extensive usage.
:: Repeating 2,000,000 times to generate 4,000 exams with 2 series each and 250 images per series (500 images per exam)
:: There will be 10 simulated modalities in this test

FOR /L %%i IN (1,1,10) DO (
    START "LOADER" StoreSCU.exe -v --repeat 2000000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% "%IMAGE_PATH%\*"
    SLEEP 5
)

:Exit
REM End of DICOM file transmission.
PAUSE
REM Pause to review output before closing the window.