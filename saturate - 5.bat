@ECHO OFF
:: Disable echoing of commands to keep the output clean.

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
CALL Config.bat

:: Define a variable to name the output log file based on the name of this script.
SET OUT=%~n0-output.txt

:: Specify the size of DICOM images that will be used in the StoreSCU command. Ensure this matches the folder name containing the images.
SET IMGSZ=KB128

:: Execute the StoreSCU command in a minimized window titled "LOADER". The command is configured to send DICOM files and is repeated 1,000,000 times to simulate extensive usage.
:: The '+IP 1' option generates a new patient ID for every study, aiding in testing with unique patient data.
:: The '+IS 2' option creates a new study UID after every 2 series, simulating multiple studies.
:: The '+IR 2000' option invents a new series UID after every 2000 images, enhancing data diversity within studies.
:: The '-xi' flag is used to propose the implicit VR little endian transfer syntax for DICOM communications.
:: The '-aet STORESCU' sets the Application Entity Title of the SCU, and '-aec %AE%' specifies the Application Entity Title of the receiving SCP, as configured in Config.bat.
:: The '%IMGSZ%\' part specifies the directory containing the DICOM files to be sent.
:: Repeat the sending process four more times to ensure thorough testing, with a brief pause between each to prevent overloading the server.
FOR /L %%i IN (1,1,5) DO (
    START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    SLEEP 2
)

:: End of the script.
:Exit

:: Pause the script execution to allow the user to review any output messages before the window closes.
PAUSE
