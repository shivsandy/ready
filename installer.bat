@echo off
:: Get the path where the script is running
set "scriptDir=%~dp0"

:: Define the paths
set "folderPath=%LocalAppData%\FixResolution"
set "resolutionExePath=%scriptDir%resolution.exe"
set "uninstallerBatPath=%scriptDir%uninstaller.bat"
set "shortcutPath=%folderPath%\resolution.lnk"
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Check if the resolution.exe file exists in the script's directory
if not exist "%resolutionExePath%" (
    echo Error: resolution.exe not found in the same directory as the script.
    pause
    exit /b
)

:: Check if the uninstaller.bat file exists in the script's directory
if not exist "%uninstallerBatPath%" (
    echo Error: uninstaller.bat not found in the same directory as the script.
    pause
    exit /b
)

:: Check if the folder already exists, and create it if it doesn't
if not exist "%folderPath%" (
    mkdir "%folderPath%"
)

:: Copy resolution.exe and uninstaller.bat to the newly created folder
copy "%resolutionExePath%" "%folderPath%\"
copy "%uninstallerBatPath%" "%folderPath%\"

:: Create the shortcut using VBScript
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%folderPath%\CreateShortcut.vbs"
echo Set oShellLink = WshShell.CreateShortcut("%shortcutPath%") >> "%folderPath%\CreateShortcut.vbs"
echo oShellLink.TargetPath = "%folderPath%\resolution.exe" >> "%folderPath%\CreateShortcut.vbs"
echo oShellLink.Save >> "%folderPath%\CreateShortcut.vbs"

:: Run the VBScript to create the shortcut
cscript //nologo "%folderPath%\CreateShortcut.vbs"

:: Move the shortcut to the Startup folder
move "%shortcutPath%" "%startupFolder%\resolution.lnk"

:: Delete the VBScript after it's done
del "%folderPath%\CreateShortcut.vbs"

:: End of script
echo Folder created, files copied, and shortcut added to Startup successfully.
pause
