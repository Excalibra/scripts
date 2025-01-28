@REM Missing letters are due to the lack of setting CRLF (Carriage Return and Line Feed).
@REM To add a line break, use echo\

@echo off

:Loop
cls
echo\
echo Please choose an option based on your needs:
echo [1] Set the program to always run with administrator privileges by default
echo [2] Remove the administrator privileges setting for a program
echo [3] Enable all programs to run with administrator privileges by default
echo [4] Disable all programs from running with administrator privileges by default
echo [5] Exit normally
echo\
choice /c 12345

if %errorlevel% equ 1 (

    set /p soft_path=Please copy and paste the program path into the terminal: 
    reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v %soft_path% /t REG_SZ /d "RUNASADMIN" /f
    echo OK, the program is now set to run with administrator privileges.
    timeout /t 5
    GOTO Loop

) else if %errorlevel% equ 2 (

    set /p soft_path=Please copy and paste the program path into the terminal: 
    reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v %soft_path% /f
    timeout /t 5
    GOTO Loop

) else if %errorlevel% equ 3 (

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0x00000001 /f
    echo OK, all programs are now set to run with administrator privileges by default.
    timeout /t 5
    GOTO Loop

) else if %errorlevel% equ 4 (

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0x00000000 /f
    echo OK, the default setting for all programs to run with administrator privileges has been disabled.
    timeout /t 5
    GOTO Loop

)

if %errorlevel% equ 5 (GOTO End)

:End

echo Exited normally.
