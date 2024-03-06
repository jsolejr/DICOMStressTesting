@ECHO OFF
REM Disable echoing to maintain a clean command prompt output.

REM Load the configuration settings from Config.bat, including AE titles and network configurations.
CALL Config.bat

REM Define an output log file, naming it after the script itself.
SET OUT=%~n0-output.txt

REM Execute the StoreSCU command to send DICOM files with specified parameters and transfer syntaxes.
REM -v: Enables verbose mode, providing detailed output about the operation for better insights and debugging.
REM --repeat 4000: Instructs the StoreSCU command to repeat the send operation 4,000 times, often used for conducting stress tests or evaluating system reliability under load.
REM +IP 1: Generates a new patient ID and name after every study sent, facilitating the creation of unique patient data for testing purposes.
REM +IS 2: Generates a new study UID after every 2 series sent, aiding in simulating multiple distinct studies within the test data, enhancing the testing scope.
REM +IR 100: Generates a new series UID after every 100 images sent, contributing to the diversity of series within the studies, useful for comprehensive testing scenarios.
REM -xi: Specifies the proposal of implicit VR little endian transfer syntax only, which simplifies the transfer syntax negotiation process to a single, widely supported option.
REM -aet STORESCU: Defines the Application Entity Title of the Store SCU, identifying the SCU within the DICOM network.
REM -aec %AE%: Specifies the Application Entity Title of the SCP (Service Class Provider), as configured in Config.bat, indicating the target SCP for the image transfer.
REM %SCP% %PORT%: Directs the StoreSCU to send images to the specified SCP's IP address and port number, as detailed in Config.bat, establishing the network destination for the transfers.
REM KB256\*: Targets the directory containing the DICOM files to be sent, assumed here to be approximately 256 kilobytes in size, denoted by the 'KB256' directory.
StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec %AE% %SCP% %PORT% KB256\*

:Exit
REM Label indicating the conclusion of the script's main operations.

REM Pause the script to allow the user to review any output messages before the command prompt window closes.
PAUSE