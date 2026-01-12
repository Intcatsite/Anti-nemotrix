@echo off
schtasks /query /fo list | findstr /i "nemotrix" >nul
if %errorlevel% equ 0 (
for /f "tokens=2 delims=:" %%a in ('schtasks /query ^| findstr /i "nemotrix"') do (
schtasks /delete /tn "%%a" /f
echo [-] Removed task: %%a
)
)