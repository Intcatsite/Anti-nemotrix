@echo off
tasklist /fi "imagename eq *nemotrix*" /fo csv >nul
if %errorlevel% equ 0 (
taskkill /f /im *nemotrix*
echo [-] Killed nemotrix process
)