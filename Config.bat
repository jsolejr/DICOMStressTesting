REM --Put your Connection information here -- 
SET AE=STORESCP
SET SCP=127.0.0.1
SET PORT=9000
REM --Specify your image size to test with --
REM --Valid values: KB128,KB256,KB512,MB01,MB04,MB10 (Currently do not have files for 4 and 10 MB) --
SET IMGSZ=KB128
REM --Specify the Number of concurrent connections to open--
SET CCNTS=2