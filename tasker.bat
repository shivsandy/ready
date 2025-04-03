@echo off
setlocal

:: Get the current username
for /f "tokens=2 delims=\" %%a in ('echo %username%') do set user=%%a

:: Set the path to the FixResolution folder
set folderPath=C:\Users\%user%\AppData\Local\FixResolution

:: Check if resolution.exe has a silent flag (adjust this if resolution.exe has a silent flag)
:: Create the task for logon with silent mode argument (if available)
schtasks /create /tn "FixResolutionLogon" /tr "\"%folderPath%\resolution.exe\" /silent" /sc onlogon /ru "%user%" /f /st 00:00 /du 9999:59 /it

:: Create the task for startup with silent mode argument (if available)
schtasks /create /tn "FixResolutionStartup" /tr "\"%folderPath%\resolution.exe\" /silent" /sc onstart /ru "%user%" /f /st 00:00 /du 9999:59 /it

echo Tasks created successfully.
endlocal
