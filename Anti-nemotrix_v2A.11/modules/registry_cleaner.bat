@echo off
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "CMD" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge" /f >nul 2>&1
echo [+] Registry cleaned