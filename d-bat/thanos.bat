@echo off
cls

REM Start-Process -FilePath "1.bat" -Wait
REM cmd /c 1.bat

rem Define ANSI escape sequences to change text colour
set "red=[1;31m"
set "green=[1;32m"
set "yellow=[1;33m"
set "reset=[0m"

echo %green%C Drive Thanos Script Features:%reset%
echo/
echo %red%Note: This script is suitable for small and medium-sized enterprises, as well as desktop engineers.%reset%
echo/
echo %yellow%1. Clears local account cache files for Foxmail%reset%
echo %yellow%2. Performs partial disk cleanup: Windows.old, Windows update files, upgrade logs, etc.%reset%
echo %yellow%3. Iteratively deletes unused temporary files and disables hibernation files%reset%
echo/
echo %red%Note: Please log out of Foxmail before running this script.%reset%

echo/
echo Press any key to continue...
pause > nul

setlocal enabledelayedexpansion
set "folder=%userprofile%\AppData\Local"
set "tempFile=C:\path\to\tempfile.txt"

rem ------------------Foxmail - Adjust or remove based on your enterprise environment---------------------

rem Testing deletion, confirmed OK, keeping it. If multiple drives exist, the default directory is D:\Program Files\Foxmail 7.2\Storage
set "targetFolder=C:\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%Detected %targetFolder% directory.%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%Files successfully deleted!%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% directory does not exist.
)

set "targetFolder=C:\Program Files\Foxmail 7.2\Storage"

if exist "%targetFolder%" (
    echo %yellow%Detected %targetFolder% directory.%reset%
    taskkill /F /IM "foxmail*" /T  2> $null
    rd /s /q "%targetFolder%\"
    echo %green%Files successfully deleted!%reset%
    mkdir "%targetFolder%"
) else (
    echo %targetFolder% directory does not exist.
)

rem ------------------Foxmail - Adjust or remove based on your enterprise environment---------------------


echo Cleaning Windows.old...
rd/s/q C:\windows.old 2>nul

echo Cleaning Windows update files...
if exist "%tempFile%" del /q "%tempFile%"
copy nul "%tempFile%"

del /q C:\Windows\SoftwareDistribution\Download\*.* 2>nul
rd /s /q C:\Windows\SoftwareDistribution\Download\ 2>nul

echo Cleaning Windows upgrade logs...
taskkill /f /im TrustedInstaller.exe >nul 2>&1
del /q C:\Windows\Logs\CBS\*.* 2>nul
rd /s /q C:\Windows\Logs\CBS\ 2>nul

echo Cleaning Internet temporary files...
del /q /f /s "%USERPROFILE%\AppData\Local\Temp\*.*" 2>nul
del /q /f /s "%LOCALAPPDATA%\Temp\*.*" 2>nul

echo Cleaning temporary files...
del /q /f /s "%TEMP%\*.*" 2>nul

echo Disabling hibernation file...
powercfg -h off

set "downloadPath=%userprofile%\Downloads"

echo %red%Do you want to delete all files in the Downloads folder? (Y/N)%reset%
set /p choice=

if /i "%choice%"=="Y" (
    echo Deleting download files...
    for /d %%i in ("%downloadPath%\*") do (
        rd /s /q "%%i"
    )
    del /q "%downloadPath%\*.*"
    echo Download files deleted.
) else (
    echo Download files not deleted.
)

echo Emptying Recycle Bin...
%SystemRoot%\System32\cmd.exe /c "echo Y|PowerShell.exe -NoProfile -Command Clear-RecycleBin"

echo Cleanup completed.

echo.
echo Press any key to continue...
pause > nul
