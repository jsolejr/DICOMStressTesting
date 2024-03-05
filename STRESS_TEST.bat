@ECHO OFF
:: Disable echoing to maintain a clean command line interface.

CALL Config.bat
:: Execute Config.bat to load necessary configurations and environment variables.

SET OUT=%~n0-output.txt
:: Define the output file name using this script's name for consistency.

:: Uncomment the next line if you need to set the image size manually.
:: SET IMGSZ=MB10

:: Initiate a loop to execute StoreSCU.exe multiple times based on the %CCNTS% variable value.
:: %CCNTS%: Number of concurrent connections to open is defined in teh config.bat file.
FOR /L %%G IN (1,1,%CCNTS%) DO (
    :: Start the StoreSCU command in a minimized window for each iteration of the loop.
    :: -v: Verbose mode to display detailed operation output.
    :: --repeat 10000: Repeat sending operation 10,000 times to simulate extensive use or stress test.
    :: +IP 1, +IS 1, +IR 10000: Generate a new patient ID for every study, a new study UID for every series, and a new series UID every 10,000 images.
    :: -xi: Propose the implicit VR little endian transfer syntax only.
    :: -aet STORESCU and -aec %AE%: Specify Application Entity Titles for the SCU and SCP.
    :: %SCP% %PORT%: Define the destination SCP's IP address and port number.
    :: %IMGSZ%\*: Use all files within the directory specified by %IMGSZ%.
    start /min StoreSCU.exe -v --repeat 10000 +IP 1 +IS 1 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    
    :: Pause for 5 seconds after each execution to manage system resources and network traffic.
    SLEEP 5
)

:Exit
:: Label for the script's exit point.

PAUSE
:: Pause the execution to allow the user to review any messages before closing the window.
