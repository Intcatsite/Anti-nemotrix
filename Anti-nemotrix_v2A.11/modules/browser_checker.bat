@echo off
set CHROME_PREFS=%localappdata%\Google\Chrome\User Data\Default\Preferences
if exist "%CHROME_PREFS%" (
findstr /i "nemotrix.org" "%CHROME_PREFS%" >nul && (
powershell -Command "(gc '%CHROME_PREFS%') -replace 'nemotrix\.org', '' | sc '%CHROME_PREFS%'"
echo [-] Chrome preferences cleaned
)
)