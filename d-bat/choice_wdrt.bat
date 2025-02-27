@echo off

:: "C:\Program Files (x86)\NSudo_8.2_All_Components\NSudo Launcher\x64\NSudoLG.exe" -U:T cmd /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /v "TamperProtection" /d 0 /t REG_DWORD /f""

:: Automatically run the following code with administrator privileges
%1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit & cd /d "%~dp0"

:: color 9

cls
echo Please select an operation:
echo/
echo [1] Disable Real-time Protection
echo [2] Enable Real-time Protection
echo/
choice /c 12 /n /m "Please enter your choice (1 or 2):"
echo/
if errorlevel 2 (
    REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f 2>nul 1>nul
    echo Real-time Protection enabled, OK!
    echo/
    ) else (
        REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f 1>nul
        echo Real-time Protection disabled, OK!
        echo Click "Turn off Tamper Protection" in Windows Defender to permanently disable real-time protection.
        echo You can also manually enable "Tamper Protection" when needed to turn on real-time protection for the long term.
        echo/
    )
pause
