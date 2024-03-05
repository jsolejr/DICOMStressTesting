# Use these values to force a specfic tx syntax in the CStore

-  StoreSCU.exe -v --repeat 4000 +IP 1 +IS 2 +IR 100 `-xi` -aet STORESCU -aec %AE% %SCP% %PORT%

-x=   --propose-uncompr
          propose all uncompressed TS, explicit VR
          with local byte ordering first (default)

  -xe   --propose-little
          propose all uncompressed TS, explicit VR little endian first

  -xb   --propose-big
          propose all uncompressed TS, explicit VR big endian first

  -xi   --propose-implicit
          propose implicit VR little endian TS only

  -xs   --propose-lossless
          propose default JPEG lossless TS
          and all uncompressed transfer syntaxes

  -xy   --propose-jpeg8
          propose default JPEG lossy TS for 8 bit data
          and all uncompressed transfer syntaxes

  -xx   --propose-jpeg12
          propose default JPEG lossy TS for 12 bit data
          and all uncompressed transfer syntaxes

  -xv   --propose-j2k-lossless
          propose JPEG 2000 lossless TS
          and all uncompressed transfer syntaxes

  -xw   --propose-j2k-lossy
          propose JPEG 2000 lossy TS
          and all uncompressed transfer syntaxes

  -xt   --propose-jls-lossless
          propose JPEG-LS lossless TS
          and all uncompressed transfer syntaxes

  -xu   --propose-jls-lossy
          propose JPEG-LS lossy TS
          and all uncompressed transfer syntaxes

  -xm   --propose-mpeg2
          propose MPEG2 Main Profile @ Main Level TS only

  -xh   --propose-mpeg2-high
          propose MPEG2 Main Profile @ High Level TS only

  -xr   --propose-rle
          propose RLE lossless TS
          and all uncompressed transfer syntaxes
