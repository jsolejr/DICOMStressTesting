@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt
SET IMGSZ=KB128


START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000000 +IP 1 +IS 2 +IR 2000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 2



:Exit

PAUSE