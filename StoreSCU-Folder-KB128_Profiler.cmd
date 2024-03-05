@ECHO OFF
CALL Config.bat

SET OUT=%~n0-output.txt

FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Second /Format:table ^| findstr /r "."') DO (
 set Milisecond=%time:~9,2% 
 set Day=%%A
 set Hour=%%B
 set Minute=%%C
 set Second=%%D
)
set /a Start=%Day%*8640000+%Hour%*360000+%Minute%*6000+%Second%*100+%Milisecond%
 
::
::
:: PUT COMMANDS HERE

StoreSCU.exe -v --repeat 100 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*

::
::
 
FOR /F "skip=1 tokens=1-6" %%A IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Second /Format:table ^| findstr /r "."') DO (
 set Day=%%A
 set Hour=%%B
 set Minute=%%C
 set Second=%%D
)
set Milisecond=%time:~9,2% 
set /a End=%Day%*8640000+%Hour%*360000+%Minute%*6000+%Second%*100+%Milisecond%
set /a Diff=%End%-%Start%
set /a DiffMS=%Diff%%%100
set /a Diff=(%Diff%-%DiffMS%)/100
set /a DiffSec=%Diff%%%60
set /a Diff=(%Diff%-%Diff%%%60)/60
set /a DiffMin=%Diff%%%60
set /a Diff=(%Diff%-%Diff%%%60)/60
set /a DiffHrs=%Diff%
 
:: format with leading zeroes
if %DiffMS% LSS 10 set DiffMS=0%DiffMS!%
if %DiffSec% LSS 10 set DiffMS=0%DiffSec%
if %DiffMin% LSS 10 set DiffMS=0%DiffMin%
if %DiffHrs% LSS 10 set DiffMS=0%DiffHrs%

echo.
echo.
 
echo Total Time: %DiffHrs%:%DiffMin%:%DiffSec%.%DiffMS%

:Exit

PAUSE
