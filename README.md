# Adobe LZMA2 Unpacker Script
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- https://superuser.com/users/219506/john-henckel for script that I found on https://superuser.com/a/1537608/1256850
- Me for editing above script to use robocopy instead of xcopy.
- Adobe Systems Incorporated for providing Zip-Lzma2-compressed applications.

## Special Note
- Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.
  - You can pack and install these assets with the script I wrote at https://github.com/osmankovan123/AdobeRepackerAndInstallerScript/tree/HyperDrive
- I suggest run this script on freshly installed Windows due to HyperDrive installer will skip already installed packages. Therefore, some packages may not be unpacked.
  - Or you can uninstall every bits of Adobe apps via Adobe Creative Cloud Cleaner Tool at https://helpx.adobe.com/enterprise/kb/cc-cleaner-tool-for-enterprise-users.html .
    - If web page isn't accessible, try downloading from direct link at https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe .
- To unpack all language assets, on application.json, change every language packages conditions from that langauge to your desired install language (i.e. en_US).
  - Or you can search and replace "condition" with anything else that isn't conflicting with any variable. This also allows to unpack all architectures and Windows 7 special packages.
  - Some installers have resources\AppInfo.json file (i.e. Photoshop and Premiere Elements 2023). If this file exists, probably application.json and other crucial files are cannot be altered due to HyperDrive installer engine's version (>=5.6.0.788) and HyperDrive installer gives "Installer is corrupt." error. To solve this, use HyperDrive installer engine with older version from one of the installers (4.5.0.300=<x<=5.5.0.617 should work.).
    - Or if you want most up to date HyperDrive installer engine, you can just replace Set-up.exe on root of the installer media with version 4.5.0.300=<x<=5.5.0.617.
    - If AppInfo.json can be generated with some tool if I understand algorithm of these strings, above steps will be unnecassary. If you know how to generate these strings, let me know :).

## What does this script do?
Normally, packed assets with Zip-Lzma2 method, folder and file structure can be seen via any archiving software, but cannot be directly unpacked via 7-Zip or other archive software that I know in existence. But they will be extracted to adobeTemp folder during installation as raw. They can be tricky to get these installer files as when install of specific package was finished, they will be deleted. This script constantly summons robocopy with no waiting and copies unpacked Adobe assets from adobeTemp folder to desired location, so be sure to have beefy computer if you can. It copies only new files so new files instantly copied to desired location as Adobe Installer copies unpacked assets to adobeTemp directory.

## Instructions
- Create adobeTemp directory on root of C drive. Maybe drive section change due to Adobe Creative Cloud's default install location settings.
- Edit script's destination directory to your desire.
  - On default, it's D:\AdobeLZMA2. Change it to something you desire. I suggest fast medium location to unpack destination.
- Run this script as admin. You'll see robocopy doing it's work.
- Run your desired Zip-Lzma2-compressed Adobe installer.
  - If application that you want to install is not compatible with system that you want to install, but you want just to unpack packages, you can search and replace "condition" with anything else that isn't conflicting with any variable.
- Wait to install to be complete.
- You'll see destination directory contains bunch of folders starting with ETR. These are the unpacked assets copied from adobeTemp directory.
  - Be sure to verify file and folder count from 7-Zip or other archiving software. Sometimes even with constant spawning of robocopy, some files may missing. You can try to find these missing files from installed location of Adobe program and copy it to appropriate location on extracted installer assets.
    - Especially on Adobe XD and Fresco (Very especially CSDKConfigurator.exe (this file cannot be found after installation AFAIK.) and icons directory.).
