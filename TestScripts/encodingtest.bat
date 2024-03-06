@ECHO OFF
REM Begin DICOM file transmission using StoreSCU with specific configurations.
CALL Config.bat  REM Load configuration settings from Config.bat.

SET OUT=%~n0-output.txt  REM Set output log file name based on this script's name.

REM Define the size of the DICOM images to use in this test.  This overwrites the gloabal size from Config.bat
SET IMGSZ=KB128

REM Transmitting DICOM files from the designated folder with controlled parameters.
REM Verbose mode (-v) is enabled for detailed output.
REM The operation repeats 100,000 times (--repeat 100000) for extensive testing.
REM Unique identifiers are generated: a new patient ID for each study (+IP 1), a new study UID for every 2 series (+IS 2), and a new series UID for every 10,000 images (+IR 10000).
REM The -xi flag proposes the use of implicit VR little endian transfer syntax.
REM AE titles for SCU (-aet STORESCU) and SCP (-aec %AE%) are specified, along with the SCP's address (%SCP%) and port (%PORT%)from config.bat.
REM The DICOM files are sourced from the directory indicated by %IMGSZ%.

:: Transmitting files with a 5-second pause between each batch to manage load on the SCP.
FOR /L %%i IN (1,1,10) DO (
    START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
    SLEEP 5
)

:Exit
REM End of DICOM file transmission.
PAUSE
REM Pause to review output before closing the window.