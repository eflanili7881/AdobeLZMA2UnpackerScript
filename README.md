# !!! SCRIPT NOT UPLOADED !!!

# Adobe LZMA2 Unpacker Script - Macintosh
A .sh script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

# CAUTION!
Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- [John Henckel](https://superuser.com/users/219506/john-henckel) for script that I found on [here](https://superuser.com/a/1537608/1256850).
- [Me](https://github.com/eflanili7881) for editing above script to use RoboCopy instead of XCopy.
- Adobe Systems Incorporated for providing Zip-Lzma2-compressed applications.

## What does this script do?
Normally, packed assets with Zip-Lzma2 method, folder and file structure can be seen via any archiving software, but cannot be directly unpacked via 7-Zip or other archive software that I know in existence. And these packages expanded size and compressed size are equal and compression method is Store on these packages.
- But even if you try to repack directly unpacked assets with 7-Zip or other archive software on 7-Zip as Store (-mx0 on 7-Zip), it gives "app cannot be installed at this time, error 127" error. It means "package cannot be extracted" error on https://helpx.adobe.com/creative-cloud/kb/troubleshoot-download-install-logs.html#error127.

  ![image](https://github.com/user-attachments/assets/9caa637f-514b-4766-94b3-4b61aac26e33)

  ![image](https://github.com/user-attachments/assets/c684f98d-04cd-43ae-84d5-a5bfc6ad55c7)

- But they will be extracted to adobeTemp folder during installation as raw into bunch of folders with random GUIDs into /.adobeTemp or maybe another adobeTemp folder on other drives root that depends on Creative Cloud settings.

  ![image](https://github.com/user-attachments/assets/21bd56b1-7bc2-4762-a549-773cb5b75f66)

- They can be tricky to get these installer files as when extraction of specific package was finished, they will be moved to directories that specified in *.pimx file. This script constantly summons cp with no cooldown as any file enters to /.adobeTemp or any folder you specified in script and copies unpacked Adobe assets from adobeTemp folder to desired location, so be sure to have beefy computer if you can. It copies only new files so new files instantly copied to desired location as Adobe Installer copies unpacked assets to adobeTemp directory.
  - If you patch HDPIM.dylib on **/Library/Application Support/Adobe/Adobe Desktop Common/HDBox/HDPIM.dylib** that I'm gonna mention it on "To patch dylib's" section on https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/tree/unpacker-mac-patchedbins#to-patch-dylibs, you can at least preserve directory structure and most importantly, *.pimx file that's extracted to **adobeTemp** directory.

## Special Note about Script
- I tried several approaches, but due to filesystem hierarchy?, I cannot copy files fast enough to temporary location (even with while true with sleep 0 loop).
  - My record with Adobe Audition CC 2019 version 12.0.0.141 and **ditto** copy tool was ~1284MB out of ~1285MB.
    - Pretty close, I know.
    - But if I remember right, it has problems with symbolic links.
  - My record with Adobe Audition CC 2019 version 12.0.0.141 and **cp** copy tool was ~800MB out of ~1285MB.
    - It misses almost 37% of files.
    - But it copies symbolic links correctly.
- I will release the script, but I recommending you to apply steps from https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/tree/unpacker-mac-patchedbins.

## Special Note
- Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.
  - You can pack and install these assets with the script I wrote at https://github.com/eflanili7881/AdobeRepackerAndInstallerScript/tree/HyperDrive-mac
- I suggest run this script on freshly installed macOS due to HyperDrive installer will skip already installed packages. Therefore, some packages may not be unpacked.
  - You can uninstall every bits of Adobe apps via Adobe Creative Cloud Cleaner Tool at https://helpx.adobe.com/enterprise/kb/cc-cleaner-tool-for-enterprise-users.html.
    - If web page isn't accessible, try downloading from direct link at https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg.
      - You can try it run OS from HDD (Creative Cloud forces user to install OS drive) or change adobeTemp folder to HDD?, then set copy destination to a fast medium (like NVMe SSD).
    - Above link only downloads latest version; if you need another specific version, you can check Wayback Machine for link https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg or you can download specific versions from Wayback Machine below:
      |Version|Link|Note|
      |:-:|:-:|:-:|
      |4.3.0.113|https://web.archive.org/web/20200625170051/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.134|https://web.archive.org/web/20200813063747/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.146|https://web.archive.org/web/20201029152543/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.151|https://web.archive.org/web/20210321222552/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.204|https://web.archive.org/web/20220824095902/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.228|https://web.archive.org/web/20230130232631/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.231|https://web.archive.org/web/20230315092416/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.519|https://web.archive.org/web/20231227054016/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
      |4.3.0.591|https://web.archive.org/web/20240324222213/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg|Last version for macOS High Sierra and Mojave|
      |4.3.0.680|https://web.archive.org/web/20240516194139/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg|First version to require macOS Catalina|
      |4.3.0.834|https://web.archive.org/web/20241123142301/https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg||
  - To unpack all language assets, on application.json, change every language packages conditions from that langauge to your desired install language (i.e. en_US).
    - Or you can search and replace "condition" with anything else that isn't conflicting with any variable. This also allows to unpack all architectures and other special packages.
- Some installers have resources\AppInfo.json file (i.e. Photoshop and Premiere Elements 2023). If this file exists, probably application.json and other crucial files are cannot be altered due to HyperDrive installer engine's version **(>=5.6.0.788)** and HyperDrive installer gives "Installer is corrupt" error. To solve this, use HyperDrive installer engine with older version from one of the installers (**4.5.0.300=<x<=5.5.0.617** should work.).
  - If you ignore this, you'll see this screen:
 
    ![image](https://github.com/user-attachments/assets/e5556fa0-5083-40bd-be5b-52fd1eb7e893)

  - If you want most up to date HyperDrive installer engine, you can just replace Install.app on root of the installer media with version **4.5.0.300=<x<=5.5.0.617** from **/packages/ADC/HDBox/HDBox.pima/Install.app** that you get from standard Adobe Creative Cloud installer version **4.5.0.300=<x<=5.5.0.617**.
  - AppInfo.json can be generated with some tool if I understand algorithm of these strings, above steps will be unnecassary. If you know how to generate these strings, let me know :).
- If you're gonna use **5.3.5.518 (or 5.3.5.499 if it's first pre-release ARM 64-Bit release)=<x<=5.5.0.617**, be sure to put contents of packages folder to common/osx10/packages (or macarm64 if you're gonna use ARM 64-bit version of Creative Cloud) and contents of resources folder (except content directory) to resources/osx10 (or macarm64 if you're gonna use ARM 64-bit version of Creative Cloud) inside installation media. Changed sections marked as bold.
  | Old install structure **(<5.3.5.518)** | New install structure **(>=5.3.5.518 (or 5.3.5.499 if it's first pre-release ARM 64-Bit release))** |
  | :-: | :-: |
  | **packages** | **common\osx10(or macarm64)\packages** |
  | products | products |
  | **resources** | **resources\osx10(or macarm64)(Only AdobePIM.dylib moved here.)** |
  | Install.app | Install.app |
  - If you skip this, the installer will say "Installer file may be damaged" as it can't find "common" directory inside of installation media.
 
    ![image](https://github.com/user-attachments/assets/b6674f3f-4528-4950-9587-2fa8d94d4a33)

    - If you want to use old install media layout, you can just replace Install.app on root of the installer media with version **4.5.0.300=<x<=5.3.1.470** from **/packages/ADC/HDBox/HDBox.pima/Install.app** that you get from standard Adobe Creative Cloud installer version **4.5.0.300=<x<=5.3.1.470**.
