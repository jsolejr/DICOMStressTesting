@ECHO OFF
%~d0
CD %~dp0

ECHO %DATE%,%TIME%,STARTING>> out.txt
%~1
ECHO %DATE%,%TIME%,ENDING>> out.txt

EXIT