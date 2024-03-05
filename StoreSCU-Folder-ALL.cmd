@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt

%~d0
CD %~dp0

GOTO :SKIP

StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB512\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB04\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB10\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*
StoreSCU.exe -v -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*

:SKIP
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB512\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB04\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 400 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB10\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 200 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB20\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% MB60\*



:Exit

PAUSE