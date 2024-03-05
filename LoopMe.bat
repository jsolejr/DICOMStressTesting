::
:: Use this script to quickly build a "Loop command n Times" test.
::

@ECHO OFF
:: Specify the number of loops to do
SET /A countlimit = 1000000


SET /A count = 0

:LoopHead
SET /A count += 1

REM ## INSERT COMMANDS HERE ##
REM ## \/ \/ \/ \/ \/ \/ \/ ##

ECHO %count%
%~dp0\sleep 2

REM ## /\ /\ /\ /\ /\ /\ /\ ##
REM ## INSERT COMMANDS HERE ##

IF /I %count% LSS %countlimit% GOTO LoopHead


ECHO Looper Complete
PAUSE

