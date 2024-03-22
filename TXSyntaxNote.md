# DICOM Stress Testing: Transmission Syntax Details

Please note that the default transmission syntax used in all of these scripts is **Implicit VR Little Endian**. This is specified using the `-xi` flag in the DICOM tool commands within the scripts.

## Changing the Transmission Syntax

If you need to test with a different DICOM transmission syntax, you can easily modify the scripts by changing the `-xi` flag to the appropriate flag that represents your desired transmission syntax.

For a comprehensive list of available transmission syntax options and their corresponding flags, please refer to the [Transmission Syntax Reference Document](https://github.com/jsolejr/DICOMStressTesting/blob/main/DCMTK_reference_for_Tx_Syntax.md).

This reference includes detailed information on how to specify various transmission syntaxes such as Explicit VR Little Endian, Explicit VR Big Endian, JPEG Lossless, JPEG LS Lossless, MPEG2, and more.

### Example

To change the transmission syntax to JPEG lossless TS, replace `-xi` with `-xs` in the command within the script.

```bash
# Original command with Implicit VR Little Endian
StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xi -aet STORESCU -aec STORESCP %SCP% 9000 %IMGSZ%\*
```
```bash
# Modified command for JPEG lossless TS and all uncompressed transfer syntaxes
StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 -xs -aet STORESCU -aec STORESCP %SCP% 9000 %IMGSZ%\*
```
## Further Assistance

If you encounter any issues while changing the transmission syntax or have questions about a specific syntax option, feel free to open an issue in the repository for support.
