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

:: Below commands execute StoreSCU to send DICOM files, repeated for a set number of times with specific parameters.
:: Each execution is followed by a 2-second pause to manage the load on the receiving SCP.
:: Start the StoreSCU command in a minimized window titled "LOADER", iterating the send process 1,000,000 times.
:: +IP 1: Generate a new patient ID for every study sent, useful for testing with unique patient data.
:: +IS 2: Generate a new study UID after every 2 series sent, simulating multiple studies.
:: +IR 2000: Generate a new series UID after every 2,000 images sent, creating diversity in series within studies.
:: -xi: Propose implicit VR little endian transfer syntax for DICOM communication.
:: -aet STORESCU: Specify the Application Entity Title of the Store SCU.
:: -aec %AE%: Specify the Application Entity Title of the SCP, as configured in Config.bat.
:: %SCP% %PORT%: Define the target SCP's IP address and port number.
:: %IMGSZ%\*: Send all files within the specified directory, matching the set image size/type.

FOR /L %%G IN (1,1,20) DO (
    START "LOADER" StoreSCU.exe -v --repeat 500000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% "%IMAGE_PATH%\*"
    SLEEP 2
)

:Exit
:: Label to indicate script termination.

PAUSE
:: Pause the script to allow user to view any output before the window closes.
