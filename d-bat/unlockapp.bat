@echo off
setlocal

set /p "targetPath=Please enter the directory or program to operate on:"

@REM Remove any quotes from the input path
set "targetPath=%targetPath:"=%"

@REM Check if the path exists
if not exist "%targetPath%" (
    echo The specified path does not exist. Exiting.
    exit /b
)

@REM Get the directory part and filename part of the path
for %%F in ("%targetPath%") do (
    set "actualPath=%%~dpF"
    set "fileName=%%~nxF"
)

@REM Construct the actual path to operate on
set "actualPath=%actualPath%%fileName%"

echo --- Detecting processes for the specified path and terminating them. ---
@REM Terminate the given process
taskkill /F /FI "IMAGENAME eq %fileName%" 2>nul

@REM If it's a directory, terminate all .exe processes in the directory and its subdirectories
if exist "%actualPath%\." (
    for /r "%actualPath%" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)
echo/
echo --- Detecting and terminating processes of compression software. ---
@REM Special handling for: WinRAR, 7-Zip

@REM WinRAR
if exist "%ProgramFiles%\WinRAR\." (
    for /r "%ProgramFiles%\WinRAR" %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)

@REM 7-Zip
if exist "%ProgramFiles%\7-Zip\." (
    for /r "%ProgramFiles%\7-Zip\." %%A in (*.exe) do (
        taskkill /F /FI "IMAGENAME eq %%~nxA" 2>nul
    )
)

echo ---------------- Done ---------------------
echo/

@REM Prompt the user to choose whether to delete the folder and its contents
set /p deleteOption=Delete %actualPath%? (Y/N)
if /I "%deleteOption%"=="Y" (
    rd /S /Q "%actualPath%" 2>nul
    del /F /Q "%actualPath%" 2>nul
    echo Deletion operation completed.
) else (
    if /I "%deleteOption%"=="N" (
        echo Deletion operation canceled.
    ) else (
        echo Invalid input. Exiting.
    )
)

endlocal
pause
