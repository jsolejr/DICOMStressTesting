@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt
SET IMGSZ=KB128


START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 100000 +IP 1 +IS 2 +IR 10000 -xi -aet STORESCU -aec %AE% %SCP% %PORT% %IMGSZ%\*
SLEEP 5

:Exit

PAUSE