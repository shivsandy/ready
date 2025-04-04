@echo off
:: Get the path where the script is running
set "scriptDir=%~dp0"

:: Define the paths
set "folderPath=%LocalAppData%\FixResolution"
set "resolutionExePath=%scriptDir%resolution.exe"
set "uninstallerBatPath=%scriptDir%uninstaller.bat"
set "copiedExePath=%folderPath%\resolution.exe"
set "shortcutPath=%folderPath%\resolution.lnk"
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Check if the resolution.exe file exists in the script's directory
if not exist "%resolutionExePath%" (
    echo Error: resolution.exe not found in the same directory as the script.
    timeout /t 5 /nobreak >nul
    exit /b
)

:: Check if the uninstaller.bat file exists in the script's directory
if not exist "%uninstallerBatPath%" (
    echo Error: uninstaller.bat not found in the same directory as the script.
    timeout /t 5 /nobreak >nul
    exit /b
)

:: Check if the folder already exists, and create it if it doesn't
if not exist "%folderPath%" (
    mkdir "%folderPath%"
)

:: Copy resolution.exe and uninstaller.bat to the newly created folder
copy "%resolutionExePath%" "%folderPath%\" >nul
copy "%uninstallerBatPath%" "%folderPath%\" >nul

:: Create the shortcut using VBScript
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%folderPath%\CreateShortcut.vbs"
echo Set oShellLink = WshShell.CreateShortcut("%shortcutPath%") >> "%folderPath%\CreateShortcut.vbs"
echo oShellLink.TargetPath = "%copiedExePath%" >> "%folderPath%\CreateShortcut.vbs"
echo oShellLink.Save >> "%folderPath%\CreateShortcut.vbs"

:: Run the VBScript to create the shortcut
cscript //nologo "%folderPath%\CreateShortcut.vbs"

:: Move the shortcut to the Startup folder
move "%shortcutPath%" "%startupFolder%\resolution.lnk" >nul

:: Delete the VBScript after it's done
del "%folderPath%\CreateShortcut.vbs"

:: Run resolution.exe from the new folder
start "" "%copiedExePath%"

:: End of script
echo Folder created, files copied, shortcut added to Startup, and resolution.exe executed.
timeout /t 2 /nobreak >nul
exit
