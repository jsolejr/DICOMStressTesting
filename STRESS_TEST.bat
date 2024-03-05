@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt
REM SET IMGSZ=MB10

FOR /L %%G IN (1,1,%CCNTS%) DO (
start /min StoreSCU.exe -v --repeat 10000 +IP 1 +IS 1 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
)

:Exit

PAUSE