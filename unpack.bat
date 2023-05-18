@echo off
echo Watching for changes to C:\adobeTemp ...
:top
cd %~dp0
for /r %%a in ("*") do robocopy "C:\adobeTemp" "D:\AdobeLZMA2" /E /NOOFFLOAD /R:0 | find /v "File(s) copied"
timeout /t 0 >nul
goto :top
