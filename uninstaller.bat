@echo off
:: Define the folder path and process name
set "folderPath=%LocalAppData%\FixResolution"
set "processName=resolution.exe"

:: Stop the resolution.exe process if it's running
echo Attempting to kill the %processName% process...
taskkill /f /im "%processName%"

:: Check if the process was successfully killed
if %errorlevel% equ 0 (
    echo Process %processName% has been terminated.
) else (
    echo Process %processName% was not running.
)

:: Delete the FixResolution folder
echo Deleting the FixResolution folder...
rd /s /q "%folderPath%"

:: Check if the folder was successfully deleted
if exist "%folderPath%" (
    echo Failed to delete the FixResolution folder.
) else (
    echo FixResolution folder deleted successfully.
)

pause
