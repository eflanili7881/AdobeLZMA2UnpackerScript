# Adobe LZMA2 Unpacker Script
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Special Note
- Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.
- I suggest run this script on freshly installed Windows due to HyperDrive installer will skip already installed packages. Therefore, some packages may unpacked.

## What does this script do?
Normally, packed assets with Zip-Lzma2 method cannot be unpacked via 7-Zip. But they will extracted to adobeTemp folder during installation. They can be tricky to get these installer files as when install of specific package was finished, they will be deleted. This script continuously copies unpacked Adobe assets from adobeTemp folder to desired location via robocopy. It copies only new files.

## Instructions
- Create adobeTemp directory on root of C drive. Maybe drive section change due to Adobe Creative Cloud's default install location settings.
- Edit script's destination directory to your desire.
- Run this script as admin. You'll see robocopy doing it's work.
- Run your desired LZMA2-compressed Adobe installer.
- Wait to install to be complete.
