@ECHO OFF

:: Load configuration settings from the Config.bat file, which sets up necessary environment variables.
    CALL \Config\Config.bat

ECHO Performing Echo Test...
echoscu.exe -aet ImTheSCU -aec %AE% %SCP% %PORT%

ECHO Echo Test Complete.
PAUSE