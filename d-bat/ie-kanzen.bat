@REM ------------- Privilege escalation and closing UAC---------------------------

@REM [Implementation of running bat batch files with administrator privileges](https://dev.to/excalibra/the-method-to-run-a-bat-batch-file-with-administrator-privileges-16a)
@REM When starting a bat file, first call a vbs script. Through the vbs script, call the runas part of the bat with administrator privileges, and finally locate the current execution environment (directory) of the script.

@ECHO off

:: ---------- Local execution can open privilege elevation (suitable for local machine file execution! Online execution of pipe transmission has errors.) ---------------
@REM %1 C:\Windows\SysWOW64\mshta.exe vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
@REM cd /d "%~dp0"
:: ---------- Local execution can open privilege elevation (suitable for local machine file execution! Online execution of pipe transmission has errors.) ---------------

@REM Close UAC, restart to take effect
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

@REM ----------- Compatibility View ----------------------------

@REM Add all websites to compatibility view.
@REM [Registry method to modify IE8 security level](https://dev.to/excalibra/how-to-modify-ie8-security-levels-using-registry-editor-3o84)
@REM In the domestic environment, IE browser is required, so simply set them all to compatibility view
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation" /v "AllSitesCompatibilityMode" /t REG_DWORD /d 1 /f

@REM -------- Homepage settings and anti-hijacking --------------------------
@REM The latest win11 system has removed the GUI of IE homepage settings.

@REM Set the homepage
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ /d www.duckduckgo.com /f

@REM Prevent the homepage from being maliciously modified, the principle: external programs do not have such high permissions to modify this item.
@REM reg add "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /d 1 /f >nul
@REM This instruction is used to unlock the deadlock! >nul does not input any information.
@REM reg delete "HKCU\Software\Policies\Microsoft\Internet Explorer\Control Panel" /v HomePage /f >nul

@REM Prevent edge hijacking IE, that is, IE enables third-party extensions by default.
@REM [[REG] How to set "Allow third-party browser extensions" in the registry [IE11 edition]] (https://admx.help/?Category=InternetExplorer&Policy=Microsoft.Policies.InternetExplorer::Advanced_EnableBrowserExtensions)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main" /v "Enable Browser Extensions" /t REG_SZ /d "NO" /f

@REM Registry modification, but does not close IE's default enabled third-party extensions. (The latest version of win10/11 system still has to turn off IE's default enabled third-party extensions... double-pronged)
@REM https://techcommunity.microsoft.com/t5/enterprise/ie-to-edge-87-redirection-issues/m-p/1941961
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "UpsellDisabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "RedirectionMode" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Edge\IEToEdge" /v "QuietExpirationTime" /t REG_QWORD /d 0 /f

@REM ------------- Add trusted sites -----------------

@REM The /v parameter is "http", which means it will create or modify a key-value pair named "http"; /t specifies the type /d specifies the value of the registry key to set or modify; /f force
@REM Since Ranges\Range100 are all numbers, and the configuration of two long key registration is also required, I personally feel that ZoneMap\Domains is not as easy to manage.
@REM Add a website and specify it as a trusted site. 0x00000002 is the hexadecimal of 2.

@REM There will be a bug that the trusted site GUI interface cannot delete the IP site, that is, the same is true for another method in the example, so it is best to set it to the business related to the IE browser
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.1" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.2" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\192.168.0.3" /v https /t REG_DWORD /d 0x00000002 /f

@REM Websites with domain names can be deleted normally, and IPs can only be deleted using the registry.
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\duckduckgo.com\www" /v http /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\bing.com\www" /v https /t REG_DWORD /d 0x00000002 /f


@REM ----------------- IE trusted site settings, interpret one by one ---------------------------

@REM Directly adjust the security level of trusted sites to the lowest
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 

@REM Directly adjust the security level of Intranet to the lowest
@REM 0 Local computer area; 1 Intranet; 2 Trusted site area; 3 Internet external network area; 4 Restricted site area.
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "CurrentLevel" /t REG_DWORD /d 0x10000 /f 

@REM Using domain group policy to set IE trusted sites](https://blogs.manageengine.com/active-directory/2018/08/02/securing-zone-levels-internet-explorer.html)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "Flags" /t REG_DWORD /d 0x00047 /f

@REM Apply IE configuration policies to all users. A bug that cannot add trusted sites appeared on IE on win11
@REM https://www.itprotoday.com/compute-engines/jsi-tip-5130-how-can-i-manage-internet-explorer-security-zones-registry
@REM reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v SECURITY_HKLM_ONLY /t REG_DWORD /d 1 /f

@REM Check the various configurations and templates:
:: https://admx.help/?Category=InternetExplorer&Policy=Microsoft.Policies.InternetExplorer::IZ_Policy_TurnOnProtectedMode_9
:: https://admx.help/?Category=InternetExplorer&Policy=Microsoft.Policies.InternetExplorer::IZ_PolicyTrustedSitesZoneTemplate

@REM Enable ActiveX control automatic prompt, 0, enable; 3, disable.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f

@REM 0, Enable; 1, disable; 2, prompt. Enable Java applet script
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1402" /t REG_DWORD /d 0 /f

@REM 0, Enable; Enable download signed ActiveX controls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f

@REM 3, disable; Disable downloading unsigned ActiveX controls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 1 /f

@REM Options can only follow the documentation, which may be too large a project, and all numerical options are not uniform and are relatively messy.
@REM Continue.....

@REM Disable allowing only approved domains to use ActiveX controls without prompting
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120B" /t REG_DWORD /d 0 /f

@REM Disable using pop-up window blocker
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1809" /t REG_DWORD /d 3 /f

@REM Enable allowing scripts for the Internet Explorer WebBrowser control
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1206" /t REG_DWORD /d 0 /f

@REM Enable allowing META REFRESH, allowing redirection
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1608" /t REG_DWORD /d 0 /f

@REM Enable allowing Scriptlet, web verification code is useful
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1209" /t REG_DWORD /d 0 /f

@REM Enable allowing binary files and script behavior
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2000" /t REG_DWORD /d 0 /f

@REM Allow loading XAML files, which provides support for many aspects of animation and 3D.
:: [XAML](https://dev.to/excalibra/xaml-n1e)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2402" /t REG_DWORD /d 0 /f

@REM Enable allowing loading XAML browser applications
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2400" /t REG_DWORD /d 0 /f

@REM Enable allowing loading XPS files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2401" /t REG_DWORD /d 0 /f

@REM Enable allowing dragging content from different domains in a window, **disable**
@REM Prevent employees from dragging and dropping at will, resulting in misclicking options.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2708" /t REG_DWORD /d 3 /f

@REM Enable allowing dragging content from different domains between multiple windows, **disable**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2709" /t REG_DWORD /d 3 /f

@REM Allow using the old media player on the webpage to play videos and animations, **disable**
@REM Prevent employees from watching videos, goofing off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "120A" /t REG_DWORD /d 3 /f

@REM Allow font download
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1604" /t REG_DWORD /d 0 /f

@REM Allow installing desktop items, which allows users to use web content as the desktop background **prompt**.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1800" /t REG_DWORD /d 1 /f

@REM Allow drag and drop files or copy/paste files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1802" /t REG_DWORD /d 0 /f

@REM Allow file download
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1803" /t REG_DWORD /d 0 /f

@REM Allow active scripting; disabling will prevent script code on pages in this zone from running.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1400" /t REG_DWORD /d 0 /f

@REM Allow windows started by scripts without size or position restrictions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2102" /t REG_DWORD /d 0 /f

@REM Allow websites to use script window prompts to get information
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2105" /t REG_DWORD /d 0 /f

@REM Allow websites to open windows without a status bar or address bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2104" /t REG_DWORD /d 0 /f

@REM Allow active content to access my computer through restricted protocols, **prompt**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2300" /t REG_DWORD /d 1 /f

@REM Allow cut, copy, or paste operations from the clipboard through scripts
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1407" /t REG_DWORD /d 0 /f

@REM Allow scripts to update the status bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2103" /t REG_DWORD /d 0 /f

@REM Disable the .NET Framework installer, **disable**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2600" /t REG_DWORD /d 0 /f

@REM Close the first-run control prompt
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1208" /t REG_DWORD /d 0 /f

@REM Enable MIME probing, mainly used to confirm file types.
:: [Summary of several ways to get the MIME type of a file in Java](https://dev.to/excalibra/summary-of-methods-to-obtain-mime-types-of-files-in-java-27l5)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2100" /t REG_DWORD /d 0 /f

@REM Enable SmartScreen filter scan, **disable**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2301" /t REG_DWORD /d 3 /f

@REM Disable protected mode
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2500" /t REG_DWORD /d 3 /f

@REM Enable cross-site scripting filtering, **disable**
@REM Allow cross-site scripting injection.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1409" /t REG_DWORD /d 3 /f

@REM Enable Internet Explorer to render the old filter. For compatibility
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270B" /t REG_DWORD /d 0 /f

@REM Enable launching applications and files in IFRAME
@REM FRAME is an HTML tag, which functions as a document in a document, or a floating frame. The iframe element creates an inline frame (that is, an inline frame) that contains another document.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1804" /t REG_DWORD /d 0 /f

@REM Websites in a less strict Web content domain can navigate to this zone, **prompt**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2101" /t REG_DWORD /d 1 /f

@REM Enable displaying security warnings for potentially unsafe files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1806" /t REG_DWORD /d 0 /f

@REM Enable running scripts for ActiveX controls marked as safe to execute, automatically interact with scripts without user intervention.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f

@REM Initialize and run scripts for ActiveX controls that are not marked as safe, **prompt**
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 1 /f

@REM User data persistence
@REM Users can save information in browser history, favorites, XML storage, or directly in webpages saved to disk.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1606" /t REG_DWORD /d 0 /f

@REM Allow submitting unencrypted form data
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1601" /t REG_DWORD /d 0 /f

@REM Enable automatic prompt for file download
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2200" /t REG_DWORD /d 0 /f

:: Display mixed content, **prompt** Secure (https://) and insecure content (http://)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1609" /t REG_DWORD /d 1 /f

@REM Enable "do not prompt for client certificate selection if there is no certificate or only one certificate"
@REM Automatic certificate confirmation for trusted sites
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A04" /t REG_DWORD /d 0 /f

@REM User sends path information when uploading files through an HTML form.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "160A" /t REG_DWORD /d 0 /f

@REM Automatically use the current username and password to automatically log in
@REM SMB file sharing on the network
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1A00" /t REG_DWORD /d 0 /f

@REM Enabling this policy setting prevents Internet Explorer from checking anti-malware programs to see if an ActiveX control instance can be safely created.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "270C" /t REG_DWORD /d 0 /f

@REM Users can open windows and frames across domains and access applications across domains.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1607" /t REG_DWORD /d 0 /f

@REM The default system for REG_DWORD is hexadecimal, and its values can be represented in decimal or binary.
@REM 196608 decimal, software channel permission, security level - low
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1E05" /t REG_DWORD /d 0x030000 /f

@REM Enable running ActiveX controls and plugins
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f

@REM Enable running unsigned managed components.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2004" /t REG_DWORD /d 0 /f
@REM Enable running signed managed components.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2001" /t REG_DWORD /d 0 /f

@REM Users can load pages in the zone that use MSXML or ADO to access data from other sites in the zone
@REM Internal database access
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1406" /t REG_DWORD /d 0 /f

@REM Java permissions, security level - low; 196608 decimal
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1C00" /t REG_DWORD /d 0x030000 /f

@REM Reserved words, such as: Default1408Local, Default140ATrusted, Default1605Internet, Default2302Restricted

:: Microsoft officially deleted the old version of the IE documentation, but traces can still be found. Comparing the following two documents, you can find the clues.
:: I guess Microsoft was going to make some settings at the time, and then defined these reserved items with special meaning in the "Trusted Site Area Template" section
:: https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/c05dc3bf-dcfc-4f46-8be2-8a78e46875a7

@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "140A" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1605" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1408" /t REG_DWORD /d 0 /f
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2302" /t REG_DWORD /d 0 /f


@REM ------------ Compatibility view example.----------------
@REM %Temp% is a variable directory, and the run file of double-clicking winRAR is often saved here
@REM  What does attrib -s -r -h mean? attrib -r is used to remove the read-only, system, and hidden attributes. The specific explanation is as follows:
@REM + Sets an attribute.
@REM - Clears an attribute.
@REM R Read-only file attribute.
@REM A Archive file attribute.
@REM S System file attribute.
@REM H Hidden file attribute.
@REM  del /f: force delete read-only files. /s: delete the specified files in all subdirectories. /q: quiet mode

@REM If exist "%Temp%\~import.reg" (
@REM  Attrib -R -S -H "%Temp%\~import.reg"
@REM  del /F /Q "%Temp%\~import.reg"
@REM If exist "%Temp%\~import.reg" (
@REM  Echo Could not delete file "%Temp%\~import.reg"
@REM  Pause
@REM )

@REM Usage of importing the registry from Internet Explorer\BrowserEmulation\ClearableListData\UserFilter.
@REM [IE browser compatibility view settings data analysis](https://dev.to/excalibra/ie-browser-compatibility-view-settings-data-analysis-228m)
@REM Although the article describes in detail, binary and hexadecimal are not suitable for most people, so PASS
@REM Moreover, doing so can easily cause the IE compatibility view settings to fail to add websites, and the error "You entered an invalid domain" is displayed.

@REM > "%Temp%\~import.reg" ECHO Windows Registry Editor Version 5.00
@REM >> "%Temp%\~import.reg" ECHO.
@REM >> "%Temp%\~import.reg" ECHO [HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation\ClearableListData]
@REM >> "%Temp%\~import.reg" ECHO "UserFilter"=hex:41,1f,00,00,53,08,ad,ba,01,00,00,00,36,00,00,00,01,00,00,00,\
@REM >> "%Temp%\~import.reg" ECHO   01,00,00,00,0c,00,00,00,d9,1c,6d,08,94,d9,d6,01,01,00,00,00,0c,00,31,00,39,\
@REM >> "%Temp%\~import.reg" ECHO   00,32,00,2e,00,31,00,36,00,38,00,2e,00,30,00,2e,00,33,00,33,00

@REM START /WAIT REGEDIT /S "%Temp%\~import.reg"
@REM DEL "%Temp%\~import.reg"


@REM ------- Add a trusted site example ------------------------

@REM Trusted site settings, rewrite the website and address you need to set Range is the meaning of branch scope, add a domain name, Range1...2...3, etc.
@REM ":Range" is the name of this specific range. Note that the colon before the name is required, although it is a string key, but to distinguish it from the same name relationship.
@REM REG_SZ string type; REG_DWORD numerical type; specify this branch to the trusted domain
@REM 0 Local computer area; 1 Intranet; 2 Trusted site area; 3 Internet external network area; 4 Restricted site area.

@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range100" /v ":Range" /t REG_SZ /d 192.168.0.11 /f 
@REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range100" /v "http" /t REG_DWORD /d 2 /f

@REM ----------- Tools involved in writing code---------------------

@REM Good batch files can be packaged into exe files with Bat To Exe Converter
@REM Windows setting important reference website: https://admx.help
@REM Registry tool: https://registry-finder.com
@REM Search tool: https://www.voidtools.com/
@REM Restoring Internet Explorer 11 (IE11) functionality has become a niche need since Microsoft retired IE11 and transitioned users to Microsoft Edge. However, a Chinese "Xiaoyuer" win11 IE repair tool can be used: https://www.yrxitong.com/h-nd-963.html

ECHO "UAC has been disabled, and the computer will take effect after restarting."
pause
