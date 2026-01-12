@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

title Anti-Nemotrix v2A.11
color 0B

cd /d "%~dp0"

net session >nul 2>&1
if errorlevel 1 (
    echo [!] Run as Administrator
    pause
    exit /b 1
)

:menu
cls
echo ========================================
echo      Anti-Nemotrix v2A.11
echo ========================================
echo.
echo [1] Full System Scan
echo [2] Quick Clean
echo [3] Browser Deep Scan
echo [4] Browser Agro Clean
echo [5] Real-time Protection
echo [6] Exit
echo.
set /p choice="Select option: "

if "%choice%"=="1" goto full_scan
if "%choice%"=="2" goto quick_clean
if "%choice%"=="3" goto browser_scan
if "%choice%"=="4" goto browser_agro
if "%choice%"=="5" goto realtime
if "%choice%"=="6" exit /b
goto menu

:full_scan
cls
echo [FULL SYSTEM SCAN]
echo ==================
echo.
call modules\registry_cleaner.bat
call modules\file_cleaner.bat
call modules\process_scanner.bat
call modules\service_checker.bat
call modules\task_checker.bat
call modules\dns_flusher.bat
echo.
echo ==================
echo [✓] Full scan completed
pause
goto menu

:quick_clean
cls
echo [QUICK CLEAN]
echo =============
echo.
call modules\hosts_blocker.bat
call modules\registry_cleaner.bat
call modules\file_cleaner.bat
call modules\dns_flusher.bat
echo.
echo =============
echo [✓] Quick clean completed
pause
goto menu

:browser_scan
cls
echo [BROWSER DEEP SCAN]
echo ===================
echo.
call modules\browser_checker.bat
if errorlevel 1 (
    echo.
    echo [!] INFECTION DETECTED!
    echo [!] Consider running Browser Agro Clean
) else (
    echo.
    echo [✓] No browser threats found
)
pause
goto menu

:browser_agro
cls
echo [BROWSER AGRO CLEAN]
echo ====================
echo.
echo [!] WARNING: This will:
echo      - Kill all browser processes
echo      - Reset browser shortcuts
echo      - Clean browser settings
echo      - Remove all nemotrix traces
echo.
set /p confirm="Are you sure? (y/N): "
if /i not "%confirm%"=="y" goto menu

call modules\browser_cleaner_agro.bat
pause
goto menu

:realtime
cls
echo [REAL-TIME PROTECTION]
echo ======================
echo.
echo Protection is running...
echo Press Ctrl+C to stop
echo.
call modules\network_monitor.bat
goto menu