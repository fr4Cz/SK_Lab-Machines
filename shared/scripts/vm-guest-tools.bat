if not exist "C:\Windows\Temp\7z1900-x64.msi" (
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z1900-x64.msi', 'C:\Windows\Temp\7z1900-x64.msi')" <NUL
)
REM if not exist "C:\Windows\Temp\7z1900-x64.msi" (
REM    powershell -Command "Start-Sleep 5 ; (New-Object System.Net.WebClient).DownloadFile('https://www.7-zip.org/a/7z1900-x64.msi', 'C:\Windows\Temp\7z1900-x64.msi')" <NUL
REM )

msiexec /qb /i C:\Windows\Temp\7z1900-x64.msi

if "%PACKER_BUILDER_TYPE%" equ "vmware-iso" goto :vmware
if "%PACKER_BUILDER_TYPE%" equ "virtualbox-iso" goto :virtualbox
if "%PACKER_BUILDER_TYPE%" equ "parallels-iso" goto :parallels
if "%PACKER_BUILDER_TYPE%" equ "qemu" goto :qemu
goto :done

:vmware

if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\Windows\Temp
)

if not exist "C:\Windows\Temp\windows.iso" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://softwareupdate.vmware.com/cds/vmw-desktop/ws/15.5.0/14665864/windows/packages/tools-windows.tar', 'C:\Windows\Temp\vmware-tools.tar')" <NUL
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.tar -oC:\Windows\Temp"
    FOR /r "C:\Windows\Temp" %%a in (VMware-tools-windows-*.iso) DO REN "%%~a" "windows.iso"
    rd /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

del /Q "C:\Windows\Temp\vmware-tools.tar"
del /Q "C:\Windows\Temp\windows.iso"
rd /S /Q "C:\Windows\Temp\VMware"
goto :done

:virtualbox

if exist "C:\Users\vagrant\VBoxGuestAdditions.iso" (
    move /Y C:\Users\vagrant\VBoxGuestAdditions.iso C:\Windows\Temp
)

if not exist "C:\Windows\Temp\VBoxGuestAdditions.iso" (
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://download.virtualbox.org/virtualbox/6.1.34/VBoxGuestAdditions_6.1.34.iso', 'C:\Windows\Temp\VBoxGuestAdditions.iso')" <NUL
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\VBoxGuestAdditions.iso -oC:\Windows\Temp\virtualbox"
cmd /c for %%i in (C:\Windows\Temp\virtualbox\cert\vbox*.cer) do C:\Windows\Temp\virtualbox\cert\VBoxCertUtil add-trusted-publisher %%i --root %%i
cmd /c C:\Windows\Temp\virtualbox\VBoxWindowsAdditions.exe /S
rd /S /Q "C:\Windows\Temp\virtualbox"
goto :done

:parallels
if exist "C:\Users\vagrant\prl-tools-win.iso" (
	move /Y C:\Users\vagrant\prl-tools-win.iso C:\Windows\Temp
	cmd /C "C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\prl-tools-win.iso -oC:\Windows\Temp\parallels
	cmd /C C:\Windows\Temp\parallels\PTAgent.exe /install_silent
	rd /S /Q "C:\Windows\Temp\parallels"
)
goto :done

:qemu
if exist "E:\guest-agent\" (
    msiexec /qb /x E:\guest-agent\qemu-ga-x86_64.msi
)

:done
msiexec /qb /x C:\Windows\Temp\7z1900-x64.msi
