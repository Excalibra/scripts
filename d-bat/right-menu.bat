@echo off
echo Please select an operation to execute:
echo 1. Revert to the classic Win10 right-click menu
echo 2. Restore the Win11 and later version right-click menu
echo 3. Exit

choice /c 123 /n /m "Select the corresponding option:"

goto option_%errorlevel%

rem Option handling
:option_1
rem Revert to the classic Win10 right-click menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
tskill explorer
echo Classic Win10 right-click menu has been restored.
goto end

:option_2
rem Restore the Win11 and later version right-click menu
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /va /f
rem Restart File Explorer/Refresh
tskill explorer
echo Win11 and later version right-click menu has been restored.
goto end

:option_3
echo Exiting the program.
exit

:end
pause
