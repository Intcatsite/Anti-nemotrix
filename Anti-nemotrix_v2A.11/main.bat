@echo off
cd /d "%~dp0"
openfiles >nul 2>&1
if %errorlevel% neq 0 (
echo [!] Run as Administrator
pause
exit /b
)

title Anti-Nemotrix v2A.11
color 0B

echo Anti-Nemotrix System Shield
echo -----------------------------------------------------
echo 1. Full Scan
echo 2. Quick Clean
echo 3. Real-time Protection
echo 4. Exit
echo -----------------------------------------------------
set /p choice="Select: "

if "%choice%"=="1" goto fullscan
if "%choice%"=="2" goto quickclean
if "%choice%"=="3" goto realtime
exit

:fullscan
echo Full scan started...
call "%~dp0modules\hosts_blocker.bat"
call "%~dp0modules\registry_cleaner.bat"
call "%~dp0modules\file_cleaner.bat"
call "%~dp0modules\process_scanner.bat"
call "%~dp0modules\shortcut_checker.bat"
call "%~dp0modules\service_checker.bat"
call "%~dp0modules\task_checker.bat"
call "%~dp0modules\browser_checker.bat"
call "%~dp0modules\dns_flusher.bat"
echo Full scan completed
pause
exit

:quickclean
echo Quick clean started...
call "%~dp0modules\hosts_blocker.bat"
call "%~dp0modules\registry_cleaner.bat"
call "%~dp0modules\file_cleaner.bat"
call "%~dp0modules\dns_flusher.bat"
echo Quick clean completed
pause
exit

:realtime
echo Starting real-time protection...
echo Press Ctrl+C to stop
call "%~dp0modules\network_monitor.bat"