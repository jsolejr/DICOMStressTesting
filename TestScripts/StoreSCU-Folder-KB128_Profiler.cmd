REM This script is designed to execute DICOM transfers using the StoreSCU utility.
REM It sets up the environment by calling Config.bat, captures the current time to calculate
REM the total execution duration, and runs StoreSCU.exe to send DICOM files from the KB032 folder.
REM The script executes StoreSCU multiple times with a 5-second pause between each run, 
REM targeting the same folder but potentially allowing for different DICOM files to be sent.
REM The execution time is calculated and displayed at the end, providing insights into 
REM the performance and efficiency of the DICOM transfer process.

@ECHO OFF
REM Load configuration settings
CALL Config.bat

REM Set a variable for the output log file, naming it after this script
SET OUT=%~n0-output.txt

REM Capture the start time in components
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Second /Format:table ^| findstr /r "."') DO (
 REM Capture the current time's milliseconds, day, hour, minute, and second
 set Milisecond=%time:~9,2% 
 set Day=%%A
 set Hour=%%B
 set Minute=%%C
 set Second=%%D
)

REM Calculate the start time in milliseconds from the midnight
set /a Start=%Day%*8640000+%Hour%*360000+%Minute%*6000+%Second%*100+%Milisecond%
 
REM Placeholder for additional commands, this is where you can add more operations
:: PUT COMMANDS HERE

REM Example command: This line is using the StoreSCU utility to send DICOM files with specified parameters.
REM -v: Enables verbose mode for detailed operation output, providing insight into the send process and any potential issues.
REM --repeat 100: Repeats the send operation 100 times, which can be useful for testing the DICOM server's handling of multiple consecutive transfers.
REM +IP 1: Generates a new patient ID and name for every study sent. This is particularly useful in testing environments to ensure unique patient identifiers.
REM +IS 2: Creates a new study UID after every 2 series sent. This aids in testing how the server handles multiple studies and series.
REM +IR 100: Generates a new series UID after every 100 images sent. This can help in assessing the server's performance with varying series within the studies.
REM -xi: Specifies to propose implicit VR little endian transfer syntax only, a common choice for compatibility with a wide range of DICOM servers.
REM -aet STORESCU: Specifies the Application Entity Title of this SCU, identifying it within the DICOM network.
REM -aec %AE%: Defines the Application Entity Title for the receiving SCP, which is set in the Config.bat file.
REM %SCP% %PORT%: Specifies the IP address and port number of the SCP, directing where the DICOM files should be sent, as configured in Config.bat.
REM KB128\*: Indicates that DICOM files from the KB128 directory are to be sent, suggesting these files are approximately 128 kilobytes in size.
StoreSCU.exe -v --repeat 100 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*


REM Capture the end time in components
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Second /Format:table ^| findstr /r "."') DO (
 set Day=%%A
 set Hour=%%B
 set Minute=%%C
 set Second=%%D
)
set Milisecond=%time:~9,2% 

REM Calculate the end time in milliseconds from the midnight
set /a End=%Day%*8640000+%Hour%*360000+%Minute%*6000+%Second%*100+%Milisecond%

REM Calculate the difference between the end and start times to get the total execution time
set /a Diff=%End%-%Start%
set /a DiffMS=%Diff%%%100
set /a Diff=(%Diff%-%DiffMS%)/100
set /a DiffSec=%Diff%%%60
set /a Diff=(%Diff%-%Diff%%%60)/60
set /a DiffMin=%Diff%%%60
set /a Diff=(%Diff%-%Diff%%%60)/60
set /a DiffHrs=%Diff%

REM Ensure all time components have leading zeroes if they are less than 10
if %DiffMS% LSS 10 set DiffMS=0%DiffMS%
if %DiffSec% LSS 10 set DiffSec=0%DiffSec%
if %DiffMin% LSS 10 set DiffMin=0%DiffMin%
if %DiffHrs% LSS 10 set DiffHrs=0%DiffHrs%

REM Display the total execution time
echo Total Time: %DiffHrs%:%DiffMin%:%DiffSec%.%DiffMS%

:Exit
REM Pause the script to review the output before closing
PAUSE
