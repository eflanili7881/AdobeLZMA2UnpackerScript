# Adobe LZMA2 Unpacker Script - Windows
A .bat script that unpacks LZMA2-compressed Adobe HyperDrive installers to desired location.

# CAUTION!
Please, don't use this script for piracy things. I wrote this script for who wants to store LZMA2-compressed HyperDrive Adobe application installers as unpacked for various reasons. My reason was maximize deduplication ratings on my Windows Server Storage Spaces storage to store more programs. That's why I wrote this script. I will improve this script day by day.

## Credits
- [John Henckel](https://superuser.com/users/219506/john-henckel) for script that I found on [here](https://superuser.com/a/1537608/1256850).
- [Me](https://github.com/eflanili7881) for editing above script to use RoboCopy instead of XCopy.
- Adobe Systems Incorporated for providing Zip-Lzma2-compressed applications.

## What does this script do?
Normally, packed assets with Zip-Lzma2 method, folder and file structure can be seen via any archiving software, but cannot be directly unpacked via 7-Zip or other archive software that I know in existence. And these packages expanded size and compressed size are equal and compression method is Store on these packages (i.e. Adobe XD 42.0.22.11 as it's the first Adobe XD version to use Zip-Lzma2 compression below).

![image](https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/assets/44976117/594382b9-0db8-496d-941a-8517a9068e65)

  - But even if you try to repack directly unpacked assets with 7-Zip or other archive software on 7-Zip as Store (-mx0 on 7-Zip), it gives "app cannot be installed at this time, error 127" error. It means "package cannot be extracted" error on https://helpx.adobe.com/creative-cloud/kb/troubleshoot-download-install-logs.html#error127.

    ![image](https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/assets/44976117/052c5eef-b357-4747-a313-acb9472e0dcf)

    ![image](https://github.com/user-attachments/assets/5b31ab29-edf2-4303-8719-87388a61f9df)

But they will be extracted to adobeTemp folder during installation as raw into bunch of folders starting with ETR prefix into C:\adobeTemp or maybe another adobeTemp folder on other drives root that depends on Creative Cloud settings.

![image](https://github.com/user-attachments/assets/e3e18b64-e3a0-41c5-bba0-127f0edc48af)

They can be tricky to get these installer files as when ~~install~~ (extraction) of specific package was finished, they will be ~~deleted~~ (moved to directories that specified in *.pimx file). This script constantly summons robocopy with no cooldown as any file enters to C:\adobeTemp or any folder you specified in script and copies unpacked Adobe assets from adobeTemp folder to desired location, so be sure to have beefy computer if you can. It copies only new files so new files instantly copied to desired location as Adobe Installer copies unpacked assets to adobeTemp directory.
  - When I examined install process, files will not be deleted. Instead, they will be moved to directories that specified in *.pimx file.
    - Example from Adobe XD 57.1.12.2:

      ![image](https://github.com/user-attachments/assets/0fb6fbba-c5ad-41bb-91cc-80f805549ee4)

    - If you patch HDPIM.dll on **C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\HDBox\HDPIM.dll** that I'm gonna mention it on "To patch dll's" section, you can at least preserve directory structure and most importantly, *.pimx file that's extracted to **adobeTemp** directory.
      - With that, you can move files by manual from directories back to **adobeTemp** with guidance from *.zip and *.pimx file.
      - As UWP installers (.appx files) will not be moved (i think by **ignoreAsset="true"** argument), in example for Adobe XD (**SparklerApp** directory), they'll be preserved on **adobeTemp** directory.

        ![image](https://github.com/user-attachments/assets/16837dc3-d4a9-4157-92d8-84d75a9d0d47)

        - Sizes will be different due to Zip-Lzma2 compression method. Important thing is folder and file count should be same.
        - But **SupportAssets** and **AEPlugin** will be moved to respective folders.
          - AEPlugin directory for Adobe XD 57.1.12.2.
            - On **C:\Program Files\Adobe\Common\Plug-ins\7.0\MediaCore\Public\AEXD-57.1.12.2**
           
              ![image](https://github.com/user-attachments/assets/7df913de-6333-41c5-9338-a35172db263f)

          - SupportAssets directory for Adobe XD 57.1.12.2.
            - On **C:\Program Files\Common Files\Adobe\Adobe XD**
           
              ![image](https://github.com/user-attachments/assets/b692f099-8874-4eeb-946a-b93acf3ccf27)

              - **csdkConfiguratorLog.txt** will be created later by command specified in *.pimx file.
             
                ![image](https://github.com/user-attachments/assets/be8e752d-d25b-4b32-b2c9-65c7a0df3d27)

              - It's not necessary to backup this file.
## Instructions
- Run this script as admin. You'll see robocopy doing it's work. Script will create folders depending on your entries.
- Run your desired Zip-Lzma2-compressed Adobe installer.
- Wait to install to be complete.
- You'll see destination directory contains bunch of folders starting with ETR. These are the unpacked assets copied from adobeTemp directory.

  ![image](https://github.com/user-attachments/assets/e3e18b64-e3a0-41c5-bba0-127f0edc48af)
  
  - Be sure to verify file and folder count from 7-Zip or other archiving software. Sometimes even with constant spawning of robocopy, some files may missing. You can try to find these missing files from installed location of Adobe program and copy it to appropriate location on extracted installer assets.
    - Especially on Adobe XD and Fresco (Very especially CSDKConfigurator.exe (this file and icons directory)).
      - These files can be found on **C:\Program Files\Common Files\Adobe** ([AdobeCommon] variable).
      - Under that directory, look for app name that you're gonna unpack (i.e. Adobe Fresco).
        - Or you can delete every file under **C:\Program Files\Common Files\Adobe\ (app name you're gonna unpack)** if you're gonna want unpack packages in one-go.
- After that, you can close command prompt.

## Special Note
- Be sure to change Zip-Lzma2 to Zip-Deflated on application.json to install these unpacked assets.
  - You can pack and install these assets with the script I wrote at https://github.com/eflanili7881/AdobeRepackerAndInstallerScript/tree/HyperDrive-win
- I suggest run this script on freshly installed Windows due to HyperDrive installer will skip already installed packages. Therefore, some packages may not be unpacked.
  - You can uninstall every bits of Adobe apps via Adobe Creative Cloud Cleaner Tool at https://helpx.adobe.com/enterprise/kb/cc-cleaner-tool-for-enterprise-users.html .
    - If web page isn't accessible, try downloading from direct link at https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe
    - Above link only downloads latest version; if you need another specific version, you can check Wayback Machine for link https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe or you can download specific versions from Wayback Machine below:
      |Version|Link|
      |:-:|:-:|
      |4.3.0.90|https://web.archive.org/web/20200506000515/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.134|https://web.archive.org/web/20201030195736/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.158|https://web.archive.org/web/20211019235249/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.230|https://web.archive.org/web/20220113180201/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.251|https://web.archive.org/web/20220414180715/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.253|https://web.archive.org/web/20220824095901/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.278|https://web.archive.org/web/20230113090352/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.395|https://web.archive.org/web/20230916141417/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
      |4.3.0.834|https://web.archive.org/web/20241105115843/https://swupmf.adobe.com/webfeed/CleanerTool/win/AdobeCreativeCloudCleanerTool.exe|
  - To unpack all language assets, on application.json, change every language packages conditions from that langauge to your desired install language (i.e. en_US).
    - Or you can search and replace "condition" with anything else that isn't conflicting with any variable. This also allows to unpack all architectures and Windows 7 special packages.
- Some installers have resources\AppInfo.json file (i.e. Photoshop and Premiere Elements 2023). If this file exists, probably application.json and other crucial files are cannot be altered due to HyperDrive installer engine's version **(>=5.6.0.788)** and HyperDrive installer gives "Installer is corrupt" error. To solve this, use HyperDrive installer engine with older version from one of the installers (**4.5.0.300=<x<=5.5.0.617** should work.).
  - If you ignore this, you'll see this screen:

    ![image](https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/assets/44976117/92a70fdc-9cf3-4591-bdd3-76724cc06bf4)
    
    - If you want most up to date HyperDrive installer engine, you can just replace Set-up.exe on root of the installer media with version **4.5.0.300=<x<=5.5.0.617** from **/packages/ADC/HDBox/HDBox.pima/Set-up.exe** that you get from standard Adobe Creative Cloud installer version **4.5.0.300=<x<=5.5.0.617**.
  - AppInfo.json can be generated with some tool if I understand algorithm of these strings, above steps will be unnecassary. If you know how to generate these strings, let me know :).
- If you're gonna use **5.3.5.518 (or 5.3.5.499 if it's first pre-release ARM 64-Bit release)=<x<=5.5.0.617**, be sure to put contents of packages folder to common/win64/packages (or winarm64 if you're gonna use ARM 64-bit version of Creative Cloud) and contents of resources folder (except content directory) to resources/win64 (or winarm64 if you're gonna use ARM 64-bit version of Creative Cloud) inside installation media. Changed sections marked as bold.
  | Old install structure **(<5.3.5.518)** | New install structure **(>=5.3.5.518 (or 5.3.5.499 if it's first pre-release ARM 64-Bit release))** |
  | :-: | :-: |
  | **packages** | **common\win64(or winarm64)\packages** |
  | products | products |
  | **resources** | **resources\win64(or winarm64)(Only AdobePIM.dll and UpdateRedirector.dat moved here.)** |
  | Set-up.exe | Set-up.exe |
  - If you skip this, the installer will say "Installer file may be damaged" as it can't find "common" directory inside of installation media.

    ![image](https://github.com/eflanili7881/AdobeLZMA2UnpackerScript/assets/44976117/03447c52-e379-4d12-8d96-a1ddd3f9ca43)
    
    - If you want to use old install media layout, you can just replace Set-up.exe on root of the installer media with version **4.5.0.300=<x<=5.3.1.470** from **/packages/ADC/HDBox/HDBox.pima/Set-up.exe** that you get from standard Adobe Creative Cloud installer version **4.5.0.300=<x<=5.3.1.470**.

## To patch dll's
- Download Cutter from https://cutter.re or https://github.com/rizinorg/cutter/releases
- Install Cutter and IDA Pro 6.5 or newer.
  # - On HDPIM.dll (version 6.4.0.359)
  - 2 address needed to be patched this time.
    - Open AdobePIM.dll with IDA Pro 6.5 or newer with Portable executable for 80386 (PE) (pe64.dll) decompiler.
    - On IDA Pro, search for string **FileUtils**.
    - Click the result on **0x100e23ba** or **0x100e23eb**
   
      ![image](https://github.com/user-attachments/assets/9ab69247-c617-49a2-a987-73d976b01e4d)

    - Find the start of function that contains result from previous step (in case, it's **0x100e2351**)
   
      ![image](https://github.com/user-attachments/assets/dec73ca8-28cb-42f3-a94d-1c0c200aa4fe)

    - You got first location to patch. Take note this address.
      - This address prevents deletion of *.pimx file.
    - On IDA Pro, search for string **RemoveDirectoryW**.
    - Click the result on **0x100e251b**.
   
      ![image](https://github.com/user-attachments/assets/b3bd4016-0817-4e31-811d-cab488b870af)

    - Look for address **0x100e251a** (0x1 address before the result that come from previous step.)
    - You got last location to patch. Take note this address.
      - This address prevents deletion of folder structure in **adobeTemp** folder.
    - You got all necessary addresses to patch on Clutter.
    - Open HDPIM.dll on Cutter with experimental (aaaa) mode and in write mode (-w).
    - Jump to address 0x100e2351.
   
      ![image](https://github.com/user-attachments/assets/df74c82d-0063-49de-96e7-2f0e74bb5a5f)

    - Change **mov byte [ebp - 4], 0** to **jmp 0x100e244f** with disabling *Fill all remaining bytes with NOP opcodes*.
    - Changing will invalidate function on address 0x100e235e but it's not going to be a problem.
    - When you reload file with same settings, graph will turn into this:
   
      ![image](https://github.com/user-attachments/assets/a14691aa-b8ec-47ef-a89c-3822523447cb)

    - With that, you patched code that deletes *.pimx file.
    - Jump to address 0x100e251a.
   
      ![image](https://github.com/user-attachments/assets/e0702bf1-74e5-4606-b434-72c2acfd68c5)

    - Change **push eax** to **jmp 0x100e26bb** with disabling *Fill all remaining bytes with NOP opcodes*.
    - When you reload file with same settings, graph will turn into this:
   
      ![image](https://github.com/user-attachments/assets/2d5d3097-6668-4273-9611-51758d22dc44)

    - With that, you patched code that deletes directory structure on **adobeTemp** folder.
