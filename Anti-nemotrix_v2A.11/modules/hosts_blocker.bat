@echo off
set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"

findstr /i "nemotrix.org" "%HOSTS%" >nul || (
echo. >> "%HOSTS%"
echo 127.0.0.1 nemotrix.org >> "%HOSTS%"
echo 127.0.0.1 www.nemotrix.org >> "%HOSTS%"
echo [+] Blocked nemotrix.org in hosts file
)