# Ask the user for each configuration parameter
$AE = Read-Host "Enter AE Title"
$SCP = Read-Host "Enter SCP Address (default: 127.0.0.1)"
$PORT = Read-Host "Enter Port (default: 104)"
$IMGSZ = Read-Host "Enter Image Size (Valid values: KB128,KB256,KB512,MB01; MB04 and MB10 currently not supported)"
$CCNTS = Read-Host "Enter Number of Concurrent Connections"

# Set default values if user input is empty
if (-not $SCP) { $SCP = "127.0.0.1" }
if (-not $PORT) { $PORT = "104" }

# Create or overwrite Config.bat with the new values
@"
REM --Put your Connection information here -- 

SET AE=$AE
SET SCP=$SCP
SET PORT=$PORT

REM --Specify your image size to test with --
REM --Valid values: KB128,KB256,KB512,MB01,MB04,MB10 (Currently do not have files for 4 and 10 MB) --
SET IMGSZ=$IMGSZ

REM --Specify the Number of concurrent connections to open--
SET CCNTS=$CCNTS
"@ | Out-File -FilePath Config.bat
