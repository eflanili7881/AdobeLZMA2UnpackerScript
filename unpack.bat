@echo off
echo Enter adobeTemp folder location:
set /p adobetempfolder=
echo Enter AdobeLZMA2 folder location:
set /p adobelzma2folder=
echo Creating folders if they're not exist ...
mkdir "%adobetempfolder%"
mkdir "%adobelzma2folder%"
echo Watching for changes to %adobetempfolder% ...
goto :top
:top
cd "%adobetempfolder%"
for /r %%a in ("*") do robocopy "%adobetempfolder%" "%adobelzma2folder%" /E /NOOFFLOAD /R:0 | find /v "File(s) copied"
timeout /t 0 >nul
goto :top
