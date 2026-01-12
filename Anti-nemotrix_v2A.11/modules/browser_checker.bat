@echo off
set THREAT=0
set BROWSERS=Chrome Edge Firefox Opera Brave

echo [BROWSER CHECKER] Starting aggressive scan...
echo.

for %%b in (%BROWSERS%) do (
    if exist "%USERPROFILE%\Desktop\%%b.lnk" (
        powershell -Command "$s=New-Object -ComObject WScript.Shell;try{$l=$s.CreateShortcut('%USERPROFILE%\Desktop\%%b.lnk');if($l.TargetPath -match 'nemotrix' -or $l.Arguments -match 'nemotrix'){echo '[!] %%b SHORTCUT INFECTED'}}catch{}"
    )
    
    if exist "%LOCALAPPDATA%\%%b\User Data\Default\Preferences" (
        findstr /i "nemotrix" "%LOCALAPPDATA%\%%b\User Data\Default\Preferences" >nul
        if !errorlevel! equ 0 (
            echo [!] %%b PREFERENCES INFECTED
            set THREAT=1
        )
    )
)

if exist "%APPDATA%\Mozilla\Firefox\Profiles" (
    for /d %%p in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
        if exist "%%p\prefs.js" (
            findstr /i "nemotrix" "%%p\prefs.js" >nul
            if !errorlevel! equ 0 (
                echo [!] FIREFOX PREFS INFECTED
                set THREAT=1
            )
        )
    )
)

findstr /i "nemotrix.org" "%WINDIR%\System32\drivers\etc\hosts" >nul
if !errorlevel! equ 0 (
    echo [!] HOSTS FILE INFECTED
    set THREAT=1
)

tasklist | findstr /i "chrome.*nemotrix\|edge.*nemotrix\|firefox.*nemotrix" >nul
if !errorlevel! equ 0 (
    echo [!] BROWSER PROCESS INFECTED
    set THREAT=1
)

echo.
if !THREAT! equ 1 (
    echo ================================
    echo [!] CRITICAL: BROWSER INFECTION DETECTED
    echo [!] Run browser_cleaner_agro.bat immediately!
    exit /b 1
) else (
    echo [✓] No active browser threats
    exit /b 0
)