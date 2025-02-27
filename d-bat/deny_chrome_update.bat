@echo off
@%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@cd /d "%~dp0"

@echo off
@setlocal enabledelayedexpansion

:: Check if the Chrome Update folder exists, create it if it doesn't
IF NOT EXIST "%userprofile%\AppData\Local\Google\Update" (
    mkdir "%userprofile%\AppData\Local\Google\Update"
)

@REM Grant full control permissions to the Everyone group for a file
@REM icacls "C:\Windows\System32\usosvc.dll" /grant "Everyone":F

:: Deny specific users or groups access to the folder
:: (OI)(CI) means the permissions apply to the object and its sub-objects, (RX) means deny read and execute permissions.
icacls "%userprofile%\AppData\Local\Google\Update" /deny "Everyone":(OI)(CI)RX

:: Check if the operation was successful
if %errorlevel% neq 0 (
    echo Failed to set folder permissions.
) else (
    echo Folder permissions set successfully.
)

pause
