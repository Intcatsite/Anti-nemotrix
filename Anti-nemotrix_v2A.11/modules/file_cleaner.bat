@echo off
del /s /f /q "%temp%\*nemotrix*" >nul 2>&1
del /s /f /q "%AppData%\*nemotrix*" >nul 2>&1
echo [+] Temporary files cleaned