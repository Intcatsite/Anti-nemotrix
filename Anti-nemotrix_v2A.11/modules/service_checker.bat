@echo off
sc query | findstr /i "nemotrix" >nul
if %errorlevel% equ 0 (
for /f "tokens=2" %%a in ('sc query ^| findstr /i "nemotrix"') do (
sc stop "%%a"
sc delete "%%a"
echo [-] Removed service: %%a
)
)