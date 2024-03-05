@ECHO OFF
CALL Config.bat

ECHO Performing Echo Test...
echoscu.exe -aet ImTheSCU -aec %AE% %SCP% %PORT%

ECHO Echo Test Complete.
PAUSE