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


REM Transmitting DICOM files from the designated folder with controlled parameters.
REM Verbose mode (-v) is enabled for detailed output.
REM The operation repeats 100,000 times (--repeat 100000) for extensive testing.
REM Unique identifiers are generated: a new patient ID for each study (+IP 1), a new study UID for every 2 series (+IS 2), and a new series UID for every 10,000 images (+IR 10000).
REM The -xi flag proposes the use of implicit VR little endian transfer syntax.
REM AE titles for SCU (-aet STORESCU) and SCP (-aec %AE%) are specified, along with the SCP's address (%SCP%) and port (%PORT%)from config.bat.
REM The DICOM files are sourced from the directory indicated by %IMGSZ%.

:: Transmitting files with a 5-second pause between each batch to manage load on the SCP.
FOR /L %%i IN (1,1,10) DO (
    START "LOADER" StoreSCU.exe -v --repeat 500000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% "%IMAGE_PATH%\*"
    SLEEP 5
)

:Exit
REM End of DICOM file transmission.
PAUSE
REM Pause to review output before closing the window.