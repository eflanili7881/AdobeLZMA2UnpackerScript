# Adobe LZMA2 Unpacker Script - Patched Binaries for Macintosh
A .sh script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

# CAUTION!
Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- [John Henckel](https://superuser.com/users/219506/john-henckel) for script that I found on [here](https://superuser.com/a/1537608/1256850).
- [Me](https://github.com/eflanili7881) for editing above script to use RoboCopy instead of XCopy.
- Adobe Systems Incorporated for providing Zip-Lzma2-compressed applications.

## To patch dylib's
- Download Cutter from https://cutter.re or https://github.com/rizinorg/cutter/releases
- Install Cutter and IDA Pro 6.5 or newer.
# - On HDPIM.dylib (version 5.9.0.373)
  - Open AdobePIM.dylib with IDA Pro 6.5 or newer with MachO compiler.
  - On IDA Pro, search for string **Successfully deleted directory**.
  - Select the result on **0x18a354** or **0x18a4c6**.

    ![image](https://github.com/user-attachments/assets/37f0de23-582c-410e-95fd-4e0bdece6d3b)

  - Locate the box's start address that's connected to both 2 results that come from previous step (in case, it's 0x18a2a7).

    ![image](https://github.com/user-attachments/assets/9843f85a-f609-4a9c-9c42-e0cdf74b0a88)

    ![image](https://github.com/user-attachments/assets/22c4bdc6-9edc-425d-91b9-ad147ab0d7c9)

    - This address prevents deletion of folder structure in adobeTemp folder and *.pimx file.
  - You've got necessary address to change on Cutter.
  - Open HDPIM.dylib on Cutter with experimental (aaaa) mode and in write mode (-w).
  - Jump to address 0x18a2a7.

    ![image](https://github.com/user-attachments/assets/0b00a7b3-15e0-450f-8512-dd5481590b37)

  - Change **mov rsi, qword [rip + 0x2170da]** to **jmp 0x18a3b8** with disabling *Fill all remaining bytes with NOP opcodes*.
  - When you reload file with same settings, graph will turn into this:
   
    ![image](https://github.com/user-attachments/assets/a99de453-b2d8-45d1-959e-a493f6e5ba89)

  - With that, you patched code that deletes directory structure on **adobeTemp** folder and *.pimx file.
