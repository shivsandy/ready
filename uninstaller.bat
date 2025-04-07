@echo off
:: Define the folder path and process name
set "folderPath=%LocalAppData%\FixResolution"
set "processName=resolution.exe"
set "shortcutName=resolution"

:: Stop the resolution.exe process if it's running
echo Attempting to kill the %processName% process...
taskkill /f /im "%processName%" >nul 2>&1

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

:: Delete the shortcut from the Startup folder
set "startupFolder=%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
echo Deleting the shortcut from Startup folder...
del /f /q "%startupFolder%\%shortcutName%.lnk" >nul 2>&1
del /f /q "%startupFolder%\%shortcutName%.exe" >nul 2>&1

:: Confirm deletion
if exist "%startupFolder%\%shortcutName%.lnk" (
    echo Failed to delete %shortcutName%.lnk from Startup folder.
) else if exist "%startupFolder%\%shortcutName%.exe" (
    echo Failed to delete %shortcutName%.exe from Startup folder.
) else (
    echo Startup shortcut deleted successfully.
)

:: Wait 2 seconds before closing
timeout /t 2 >nul
exit
