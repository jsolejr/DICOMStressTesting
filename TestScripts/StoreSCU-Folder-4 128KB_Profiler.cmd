REM StoreSCU-Folder-4 128KB_Profiler.cmd
@ECHO OFF
REM Disable echoing to keep the output window clean.

:: Store the current directory to return back to it later
SET "CURRENT_DIR=%CD%"

:: Navigate to the script's own directory
CD /D "%~dp0"

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
CALL ..\Config\Config.bat

REM Set a variable to name the output log file based on this script's name.
SET "OUT=%~n0-output.txt"

:: Get the start timestamp
SET "START_TIME=%TIME%"

REM Execute StoreSCU command to send DICOM files with specified parameters.
START "LOADER" StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% ..\Images\KB128\* >> 

:: Get the end timestamp
SET "END_TIME=%TIME%"

:: Calculate the difference in time from start to end
CALL :GetDuration "%START_TIME%" "%END_TIME%" Duration

:: Output the duration to the console and the log file
ECHO Total Duration: %Duration% >> "%OUT%"
ECHO Total Duration: %Duration%

:Exit
REM Pause the script to review the output before closing
PAUSE
GOTO :EOF

:GetDuration
SETLOCAL
REM Expecting input in the format "HH:MM:SS.CS"
FOR /F "tokens=1-4 delims=:." %%a IN ("%~1") DO (
    SET /A "StartH=%%a, StartM=%%b, StartS=%%c, StartCS=%%d"
)
FOR /F "tokens=1-4 delims=:." %%a IN ("%~2") DO (
    SET /A "EndH=%%a, EndM=%%b, EndS=%%c, EndCS=%%d"
)

REM Calculate the duration in centiseconds (CS), seconds (S), minutes (M), and hours (H)
SET /A "DurationCS=(EndCS-StartCS)+((EndS-StartS)*100)+((EndM-StartM)*6000)+((EndH-StartH)*360000)"
SET /A "DurationS=(DurationCS/100) %% 60, DurationM=(DurationCS/6000) %% 60, DurationH=DurationCS/360000"
SET /A "DurationCS=DurationCS %% 100"

REM Zero pad the components if necessary
IF %DurationH% LSS 10 SET "DurationH=0%DurationH%"
IF %DurationM% LSS 10 SET "DurationM=0%DurationM%"
IF %DurationS% LSS 10 SET "DurationS=0%DurationS%"
IF %DurationCS% LSS 10 SET "DurationCS=0%DurationCS%"

REM Combine components into one string
SET "Duration=%DurationH%:%DurationM%:%DurationS%.%DurationCS%"

REM Pass the result out of the function
ENDLOCAL & SET "%~3=%Duration%"
GOTO :EOF
