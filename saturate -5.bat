@ECHO OFF
:: Disable command echo for cleaner output.

CALL Config.bat
:: Load environment variables and configurations from Config.bat.

SET OUT=%~n0-output.txt
:: Define the output file name, appending "-output.txt" to the script name.

SET IMGSZ=MB01
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
    START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 5000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    SLEEP 5
)

:Exit
:: Label to indicate the end of the script's operations.

PAUSE
:: Pause the script to allow the user to see the output before the window closes.
