# Adobe LZMA2 Unpacker Script
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- https://superuser.com/users/219506/john-henckel for script that I found on https://superuser.com/a/1537608/1256850
- Me for editing above script to use robocopy instead of xcopy.

## Special Note
- Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.
  - You can pack and install these assets with the script I wrote at https://github.com/osmankovan123/AdobeRepackerAndInstallerScript/tree/HyperDrive
- I suggest run this script on freshly installed Windows due to HyperDrive installer will skip already installed packages. Therefore, some packages may not be unpacked.
  - Or you can uninstall every bits of Adobe apps via Adobe Cleaner Tool.
- To unpack all language assets, on application.json, change every language packages conditions from that langauge to your desired install language (i.e. en_US).
  - Or you can search and replace "condition" with anything else that isn't conflicting with any text editor. This also allows to unpack all architectures or Windows 7 special packages.
  - Some installers have resources\AppInfo.json file (i.e. Photoshop and Premiere Elements 2023). If this file exists, probably application.json and other crucial files are cannot be altered due to HyperDrive installer engine's version (>=5.6.0.788) and HyperDrive installer gives "Installer is corrupt." error. To solve this, use HyperDrive installer engine with older version from one of the installers (4.5.0.300-5.5.0.617 should work.).

## What does this script do?
Normally, packed assets with Zip-Lzma2 method, folder and file structure can be seen via any archiving software I know but cannot be unpacked via 7-Zip or other archive software that I know. But they will be extracted to adobeTemp folder during installation as raw. They can be tricky to get these installer files as when install of specific package was finished, they will be deleted. This script constantly summons robocopy with no waiting and copies unpacked Adobe assets from adobeTemp folder to desired location, so be sure to have beefy computer if you can. It copies only new files so new files instantly copied to desired location as Adobe Installer copies unpacked assets to adobeTemp directory.

## Instructions
- Create adobeTemp directory on root of C drive. Maybe drive section change due to Adobe Creative Cloud's default install location settings.
- Edit script's destination directory to your desire.
- Run this script as admin. You'll see robocopy doing it's work.
- Run your desired LZMA2-compressed Adobe installer.
- Wait to install to be complete.
- You'll see destination directory contains bunch of folders starting with ETR. These are the unpacked assets extracted from LZMA2-compressed packs from installation media.
  - Be sure to verify file and folder count from 7-Zip or other archiving software. Sometimes even with constant spawning of robocopy, some files may missing.
    - Especially on Adobe XD and Fresco (Very especially CSDKConfigurator.exe missing, and icons directory.).
