@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt
REM SET IMGSZ=MB10

FOR /L %%G IN (1,1,%CCNTS%) DO (
start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP128K %SCP% 9000 KB128\*
start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP256K %SCP% 9001 KB256\*
start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP512K %SCP% 9002 KB512\*
start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCPMB01 %SCP% 9003 MB01\*

SLEEP 5
)

:Exit

PAUSE