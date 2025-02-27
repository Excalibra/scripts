@echo "Switching the current environment to C:\Windows\System32"
@pushd C:\Windows\System32

@echo Downloading Chromium 87, please wait....

@set chromium87_url="https://bluepload.unstable.life/selif/chromev870428088.exe"
@set chromium87="Chrome_V87.0.4280.88.exe"
@powershell -c "(New-Object System.Net.WebClient).DownloadFile('%chromium87_url%', '%userprofile%/Downloads/%chromium87%')"

@echo Downloading Flash, please wait....

@set cleanflash_url="https://bluepload.unstable.life/selif/cleanflash3400282installer1.exe"
@set cleanflash="cleanflash3400282installer1.exe"
@powershell -c "(New-Object System.Net.WebClient).DownloadFile('%cleanflash_url%', '%userprofile%/Downloads/%cleanflash%')"

@echo
echo Flash does not fully support silent installation, switching to semi-automatic installation mode.

%userprofile%\Downloads\Chrome_V87.0.4280.88.exe

start /wait %userprofile%\Downloads\cleanflash3400282installer1.exe /S
