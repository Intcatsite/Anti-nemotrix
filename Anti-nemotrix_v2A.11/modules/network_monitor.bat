@echo off
:loop
netstat -ano | findstr ":80 :443" | findstr /i "nemotrix" >nul
if %errorlevel% equ 0 (
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /i "nemotrix"') do (
taskkill /f /pid %%a
echo [-] Killed PID: %%a
)
)
timeout /t 30 /nobreak >nul
goto loop