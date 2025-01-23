:: Preceding Comments Retained

:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsUpdate::AutoUpdateCfg&Language=en-gb
@REM https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update#update-enableautomaticupgrades
@REM https://www.howtogeek.com/799392/what-is-waasmedic-agent-exe-how-to-fix-high-disk-usage/
@REM https://www.majorgeeks.com/content/page/what_is_the_update_orchestrator_service.html
@REM https://answers.microsoft.com/en-us/windows/forum/all/windows-7-8-81-registry-edits-to-prevent-windows/4cbd4842-d11f-4579-a8de-18576aad2597
@REM https://greatis.com/stopupdates10/

@REM Pause updates for 3000 days
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t reg_dword /d 3000 /f

@REM Target group name for this computer 
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroup" /t REG_SZ /d "YourTargetGroup" /f

@REM This service uses this information to determine which updates should be deployed on this computer. Enabled Value 0 = Disabled, 1 = Enabled
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetGroupEnabled" /t REG_DWORD /d "0x0" /f

:: ------- Specify Intranet Microsoft Update Service Location--------
@REM This setting allows you to specify a server on the network to perform internal update services. The automatic update client will search for this service to find updates applicable to computers on the network.
@REM Value 0 = Disabled, 1 = Enabled
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f
@REM Specify Intranet Microsoft URL
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f
@REM Set Intranet Status Server
@REM reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f
:: -------------------------------------------------

@REM This service is primarily used to check the health of Windows updates to ensure the system can receive the latest security and feature updates promptly, and its value is set to 4 (to disable this service).
@REM REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaasMedic" /v "Start" /t REG_DWORD /d 4 /f

:: Preceding Comments Retained

:: Completely Disable Windows Update

@REM Temporarily stop the Windows Update service
net stop wuauserv

@REM Pause upgrades. Enabled Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseDeferrals" /t REG_DWORD /d "0x1" /f

@REM Allow non-administrators to receive update notifications. Enabled Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ElevateNonAdmins" /t REG_DWORD /d "0x1" /f

@REM This setting allows you to specify a server on the network to perform internal update services. The automatic update client will search for this service to find updates applicable to computers on the network.
@REM Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d "0x1" /f

@REM Specify Intranet Microsoft URL
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "http://127.0.0.1" /f
@REM Set Intranet Status Server
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "http://127.0.0.1" /f

@REM If this policy setting is enabled, it will prevent users from connecting to the Windows Update website. Value 1 = Enabled, 0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWindowsUpdate" /t REG_DWORD /d "0x1" /f

@REM Configure automatic updates. Value 1 = Disabled, 0 = Enabled 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "0x1" /f

@REM Allow automatic updates to install immediately. Value 1 = Enabled, 0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /t REG_DWORD /d "0x1" /f

@REM Automatic update frequency. Value 0 = Disabled, 1 = Enabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "DetectionFrequencyEnabled" /t REG_DWORD /d "0x0" /f

@REM Reschedule the installation of automatic updates. Value 1 = Enabled, 0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x0" /f

@REM Remove access to all Windows Update features. Value 1 = Enabled, 0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "0x1" /f

@REM Disable access to all Windows Update features. Value 1 = Enabled, 0 = Disabled
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "RescheduleWaitTimeEnabled" /t REG_DWORD /d "0x1" /f

@REM Prevent running Windows Anytime Upgrade (Windows version upgrade). Value 1 = Enabled, 0 = Disabled
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\WAU" /v "Disabled" /t REG_DWORD /d "0x1" /f

@REM Allow or prevent the Microsoft Store from providing updates to the latest version of Windows. Value 1 = Enabled, 0 = Disabled
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d 1 /f

@REM ------ Windows Update Health Service and Update Orchestrator Service
@REM The "Start" value includes 0 (failed to start), 1 (automatically start at system boot), 2 (manual start), and 3 (disabled), while 4 indicates that the service will not be started; if the service is already running, it will be stopped.
@REM This service is primarily used to check the health of Windows updates to ensure the system can receive the latest security and feature updates promptly, and its value is set to 4 (to disable this service).
@REM Update Orchestrator Service, disabled
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f
@REM ------ Windows Update Health Service and Update Orchestrator Service

@REM ---- Win7 Upgrade Notification Block
@REM Disable "Get Windows 10" upgrade notifications https://www.jb51.net/os/windows/418707.html
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d 0 /f
@REM https://serverfault.com/questions/695916/registry-key-gpo-to-disable-and-block-windows-10-upgrade
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v "DisableGwx" /t REG_DWORD /d 1 /f
@REM Disable "PC not supported" pop-up in Windows 7 
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\EOSNotify" /v "DiscontinueEOS" /t REG_DWORD /d 1 /f
@REM ---- Win7 Upgrade Notification Block

@REM Start the Windows Update service
net start wuauserv

:: Completely Disable Windows Update

pause
