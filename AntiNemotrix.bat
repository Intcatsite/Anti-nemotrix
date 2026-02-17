@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

if not "%1"=="am_admin" (
    powershell -Command "Start-Process cmd -ArgumentList '/c %0 am_admin' -Verb RunAs"
    exit /b
)

setlocal
cd /d "%~dp0"

echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║          Anti-Nemotrix Guard v2A.17                    ║
echo ║   Утилита для удаления рекламного ПО Nemotrix          ║
echo ╚════════════════════════════════════════════════════════╝
echo.

if not exist "blacklist.txt" (
    echo ошибка: файл blacklist.txt не найден!
    echo создайте файл blacklist.txt с доменами
    pause
    exit /b 1
)

echo [*] Запуск процесса очистки...
echo.

set /a removed=0
set /a blocked=0
set /a files_found=0
set /a files_deleted=0

echo [1/4] Блокировка доменов через hosts файл...
for /f "tokens=*" %%i in (blacklist.txt) do (
    findstr /x "127.0.0.1 %%i" %WINDIR%\System32\drivers\etc\hosts >nul 2>&1
    if errorlevel 1 (
        echo 127.0.0.1 %%i >> %WINDIR%\System32\drivers\etc\hosts
        echo       [✓] Заблокирован: %%i
        set /a blocked=!blocked!+1
    )
)
echo.

echo [2/4] Удаление записей реестра...
set count=0
for /f "tokens=*" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| find /v "Default"') do (
    echo %%i | findstr /i "nemotrix adware redirect inject" >nul
    if not errorlevel 1 (
        reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v %%i /f >nul 2>&1
        echo       [✓] Удален: %%i
        set /a count=!count!+1
    )
)

for /f "tokens=*" %%i in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| find /v "Default"') do (
    echo %%i | findstr /i "nemotrix adware redirect inject" >nul
    if not errorlevel 1 (
        reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v %%i /f >nul 2>&1
        echo       [✓] Удален: %%i
        set /a count=!count!+1
    )
)
set /a removed=!removed!+!count!
echo.

echo [3/4] Поиск и удаление временных файлов...
echo.

setlocal enabledelayedexpansion

for /r "%TEMP%" %%i in (*nemotrix* *adware* *inject* *redirect*) do (
    if exist "%%i" (
        set /a files_found=!files_found!+1
        echo   Файл %%!files_found!: %%~nxi
        echo   Путь: %%i
        
        set /p answer="   Удалить файл? (y/n): "
        if /i "!answer!"=="y" (
            del /f /q "%%i" >nul 2>&1
            if !errorlevel! equ 0 (
                echo   [✓] Файл удален
                set /a files_deleted=!files_deleted!+1
            ) else (
                echo   [✗] Не удалось удалить файл (файл может быть открыт)
            )
        ) else (
            echo   [⊘] Файл пропущен
        )
        echo.
    )
)

for /r "%APPDATA%\Temp" %%i in (*nemotrix* *adware* *inject* *redirect*) do (
    if exist "%%i" (
        set /a files_found=!files_found!+1
        echo   Файл %%!files_found!: %%~nxi
        echo   Путь: %%i
        
        set /p answer="   Удалить файл? (y/n): "
        if /i "!answer!"=="y" (
            del /f /q "%%i" >nul 2>&1
            if !errorlevel! equ 0 (
                echo   [✓] Файл удален
                set /a files_deleted=!files_deleted!+1
            ) else (
                echo   [✗] Не удалось удалить файл
            )
        ) else (
            echo   [⊘] Файл пропущен
        )
        echo.
    )
)

for /r "%LOCALAPPDATA%\Temp" %%i in (*nemotrix* *adware* *inject* *redirect*) do (
    if exist "%%i" (
        set /a files_found=!files_found!+1
        echo   Файл %%!files_found!: %%~nxi
        echo   Путь: %%i
        
        set /p answer="   Удалить файл? (y/n): "
        if /i "!answer!"=="y" (
            del /f /q "%%i" >nul 2>&1
            if !errorlevel! equ 0 (
                echo   [✓] Файл удален
                set /a files_deleted=!files_deleted!+1
            ) else (
                echo   [✗] Не удалось удалить файл
            )
        ) else (
            echo   [⊘] Файл пропущен
        )
        echo.
    )
)

if !files_found! equ 0 (
    echo   [✓] Подозрительных файлов не найдено
    echo.
)

echo [4/4] Сброс DNS кэша...
ipconfig /flushdns >nul 2>&1
echo       [✓] DNS кэш очищен
echo.

echo ╔════════════════════════════════════════════════════════╗
echo ║                    РЕЗУЛЬТАТЫ                          ║
echo ╠════════════════════════════════════════════════════════╣
echo ║ Заблокировано доменов:    !blocked!                        ║
echo ║ Удалено из реестра:       !removed!                        ║
echo ║ Найдено файлов:           !files_found!                        ║
echo ║ Удалено файлов:           !files_deleted!                        ║
echo ║ Сброс DNS:                выполнен                    ║
echo ╚════════════════════════════════════════════════════════╝
echo.

echo Очистка завершена!
if !files_deleted! gtr 0 (
    echo Удалено файлов: !files_deleted!
    echo Рекомендуется перезагрузить компьютер.
)
echo.

pause