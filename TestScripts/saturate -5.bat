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

:: Set the directory name containing DICOM images to be sent.

:: Execute the StoreSCU command multiple times in a loop, each time sending DICOM files from the MB01 directory.
:: Parameters explained:
:: -v: Verbose mode for detailed output.
:: --repeat 100000: Repeat sending operation 100,000 times.
:: +IP 1: Invent a new patient ID after each study.
:: +IS 2: Invent a new study UID after every 2 series.
:: +IR 5000: Invent a new series UID after every 5,000 images.
:: -xi: Propose the implicit VR little endian transfer syntax.
:: -aet STORESCU: Specify the Application Entity Title of the SCU.
:: -aec %AE%: Specify the Application Entity Title of the SCP.
:: %SCP% %PORT%: Target SCP's IP address and port number.
:: %IMGSZ%\*: Send all files in the specified directory.

FOR /L %%G IN (1,1,5) DO (
    START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 5000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% "%IMAGE_PATH%\*"
    SLEEP 5
)

:Exit
:: Label to indicate the end of the script's operations.

PAUSE
:: Pause the script to allow the user to see the output before the window closes.
