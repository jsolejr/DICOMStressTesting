@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt



StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*




:Exit

PAUSE