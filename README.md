# Adobe LZMA2 Unpacker Script - Patched Binaries for Windows
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

# CAUTION!
Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- [John Henckel](https://superuser.com/users/219506/john-henckel) for script that I found on [here](https://superuser.com/a/1537608/1256850).
- [Me](https://github.com/eflanili7881) for editing above script to use RoboCopy instead of XCopy.
- Adobe Systems Incorporated for providing Zip-Lzma2-compressed applications.

## Notes
- HDPIM.dll controls moving extracted assets and deleting folder structure and most importantly *.pimx file from temporary extraction location. If you patch specific addresses on HDPIM.dll, you'll prevent deletion of these things.
  - But I can't prevent assets to be moved. I'll inspect that deeper.

## To patch dll's
- Download Cutter from https://cutter.re or https://github.com/rizinorg/cutter/releases
- Install Cutter and IDA Pro 6.5 or newer.
# - On HDPIM.dll (version 6.4.0.359)
  - 2 address needed to be patched this time.
    - Open AdobePIM.dll with IDA Pro 6.5 or newer with Portable executable for 80386 (PE) (pe64.dll) decompiler.
    - On IDA Pro, search for string **FileUtils**.
    - Click the result on **0x100e23ba** or **0x100e23eb**
   
      ![image](./pictures/389191837-9ab69247-c617-49a2-a987-73d976b01e4d.png)

    - Find the start of function that contains result from previous step (in case, it's **0x100e2351**)
   
      ![image](./pictures/389192001-dec73ca8-28cb-42f3-a94d-1c0c200aa4fe.png)

    - You got first location to patch. Take note this address.
      - This address prevents deletion of *.pimx file.
    - On IDA Pro, search for string **RemoveDirectoryW**.
    - Click the result on **0x100e251b**.
   
      ![image](./pictures/389192238-b3bd4016-0817-4e31-811d-cab488b870af.png)

    - Look for address **0x100e251a** (0x1 address before the result that come from previous step.)
    - You got last location to patch. Take note this address.
      - This address prevents deletion of folder structure in **adobeTemp** folder.
    - You got all necessary addresses to patch on Clutter.
    - Open HDPIM.dll on Cutter with experimental (aaaa) mode and in write mode (-w).
    - Jump to address 0x100e2351.
   
      ![image](./pictures/389192447-df74c82d-0063-49de-96e7-2f0e74bb5a5f.png)

    - Change **mov byte [ebp - 4], 0** to **jmp 0x100e244f** with disabling *Fill all remaining bytes with NOP opcodes*.
    - Changing will invalidate function on address 0x100e235e but it's not going to be a problem.
    - When you reload file with same settings, graph will turn into this:
   
      ![image](./pictures/389192705-a14691aa-b8ec-47ef-a89c-3822523447cb.png)

    - With that, you patched code that deletes *.pimx file.
    - Jump to address 0x100e251a.
   
      ![image](./pictures/389192780-e0702bf1-74e5-4606-b434-72c2acfd68c5.png)

    - Change **push eax** to **jmp 0x100e26bb** with disabling *Fill all remaining bytes with NOP opcodes*.
    - When you reload file with same settings, graph will turn into this:
   
      ![image](./pictures/389192871-2d5d3097-6668-4273-9611-51758d22dc44.png)

    - With that, you patched code that deletes directory structure on **adobeTemp** folder.
