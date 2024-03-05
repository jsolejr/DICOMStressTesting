:: Turn off the command echo
@ECHO OFF

:: Call the configuration batch file to set up environment variables.  This will contain the default image size unlesss it is overwritten by the size value of imgsz in this file.
CALL Config.bat

:: Set the output file name based on the name of the current script
SET OUT=%~n0-output.txt

:: This line is commented out, but if uncommented, it would set the image size to 10MB
REM SET IMGSZ=MB10

:: Start a loop that runs %CCNTS% times
FOR /L %%G IN (1,1,%CCNTS%) DO (
    :: Start the StoreSCU command in a minimized window
    :: The command is repeated 4000 times
    :: +IP 1, +IS 1, and +IR 100 are options for the command
    :: -xi specifies that the command should exit on invalid data
    :: -aet and -aec specify the calling and called AE titles
    :: The last argument is a wildcard for files in the KB128 directory
    start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP128K %SCP% 9000 KB128\*
    
    :: Repeat the command for files in the KB256 directory
    start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP256K %SCP% 9001 KB256\*
    
    :: Repeat the command for files in the KB512 directory
    start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCP512K %SCP% 9002 KB512\*
    
    :: Repeat the command for files in the MB01 directory
    start /min StoreSCU.exe -v --repeat 4000 +IP 1 +IS 1 +IR 100 -xi -aet STORESCU -aec STORESCPMB01 %SCP% 9003 MB01\*
    
    :: Pause for 5 seconds before the next iteration of the loop
    SLEEP 5
)

:: Label for exiting the script
:Exit

:: Pause the script before it ends, so the user can see any output
PAUSE