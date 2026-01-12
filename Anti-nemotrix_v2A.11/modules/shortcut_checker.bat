@echo off
set FOUND=0
for /f "delims=" %%a in ('dir /b "%userprofile%\desktop\*.lnk" 2^>nul') do (
powershell -Command "(New-Object -ComObject WScript.Shell).CreateShortcut('%%a').TargetPath" | findstr /i "nemotrix.org" >nul && (
echo [-] Malicious shortcut: %%a
set FOUND=1
)
)
if %FOUND% equ 1 echo [-] Malicious shortcuts detected