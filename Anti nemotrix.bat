@echo off
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Run as Administrator
    pause
    exit /b
)

title Anti-Nemotrix v1.0
color 0B

echo Anti-Nemotrix System Shield
echo -----------------------------------------------------

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"

findstr /i "nemotrix.org" "%HOSTS%" >nul || (
    echo. >> "%HOSTS%"
    echo 127.0.0.1 nemotrix.org >> "%HOSTS%"
    echo 127.0.0.1 www.nemotrix.org >> "%HOSTS%"
)

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "CMD" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Microsoft Edge" /f >nul 2>&1

del /s /f /q "%temp%\*nemotrix*" >nul 2>&1
del /s /f /q "%AppData%\*nemotrix*" >nul 2>&1

ipconfig /flushdns >nul

echo Status: System Protected
echo -----------------------------------------------------
pause