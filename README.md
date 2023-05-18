# Adobe LZMA2 Unpacker Script
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Special Note
Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.

## What does this script do?
This script continuously copies unpacked Adobe assets from adobeTemp folder to desired location via robocopy.
