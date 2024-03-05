@ECHO OFF
:: Disable command echoing for cleaner output.

CALL Config.bat
:: Execute Config.bat to set necessary environment variables, such as AE titles and network settings.

SET OUT=%~n0-output.txt
:: Set a variable 'OUT' to store the output log file name, using the script's name for reference.

SET IMGSZ=KB128
:: Define the size (or type) of DICOM images that the StoreSCU command will process, corresponding to the folder name.

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
    START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    SLEEP 2
)

:Exit
:: Label to indicate script termination.

PAUSE
:: Pause the script to allow user to view any output before the window closes.
