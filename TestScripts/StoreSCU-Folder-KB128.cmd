@ECHO OFF
REM Disable echoing to keep the output clean.

REM Load configuration settings from Config.bat, which includes AE titles and network settings.
CALL Config.bat

REM Define an output log file named after this script.
SET OUT=%~n0-output.txt

REM Execute the StoreSCU command to send DICOM files with specific transfer syntax proposals.
REM -v: Enables verbose mode for detailed operation output.
REM --repeat 4000: Repeats the send operation 4,000 times, useful for stress testing or reliability assessments.
REM +IP 1: Invents a new patient ID and name after every 1 study sent, useful for generating unique patient data.
REM +IS 2: Invents a new study UID after every 2 series sent, aiding in simulating distinct studies.
REM +IR 100: Invents a new series UID after every 100 images sent, creating diverse series within the test data.
REM -xi: Proposes implicit VR little endian transfer syntax only, useful for compatibility with systems that prefer or require this syntax.
REM -aet STORESCU: Specifies the Application Entity Title of the SCU (Service Class User).
REM -aec %AE%: Specifies the Application Entity Title of the SCP (Service Class Provider) as configured in Config.bat.
REM %SCP% %PORT%: Directs the DICOM images to the SCP's address and port, as specified in Config.bat.
REM KB128\*: Specifies the directory path containing the DICOM files to be sent, in this case, files from the KB128 directory.
StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB128\*

:Exit
REM Marks the end of the script's main operations.

REM Pause the script execution to allow the user to review the output before closing.
PAUSE
