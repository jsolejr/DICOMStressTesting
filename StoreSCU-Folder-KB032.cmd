@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt



START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*
SLEEP 5
START "LOADER" /MIN StoreSCU.exe -v --repeat 1000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB032\*




:Exit

PAUSE