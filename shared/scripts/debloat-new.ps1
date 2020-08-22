# Download Debloater scripts
  Write-Host Downloading Windows10debloater zip
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $url="https://github.com/Sycnex/Windows10Debloater/archive/master.zip"
  (New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
  Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force

# Execute Windows10debloater 
  Write-Host Execute Windows10debloater
  . $env:TEMP\Windows10Debloater-master\Windows10SysPrepDebloater.ps1 -Sysprep -Debloat -Privacy

# Turn off Windows Defender Firewall 
  Write-Host Disable Windows Defender Firewall
  Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False


# Disable Windows Defender
  Write-host Disable Windows Defender
  $os = (gwmi win32_operatingsystem).caption
  if ($os -like "*Windows 10*") {
    Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend
  } else {
    Uninstall-WindowsFeature Windows-Defender-Features
  }

  # Enable Administrator account
  Write-host Enable Administrator account
  cmd /c net user administrator /active:yes

  rm $env:TEMP\debloat.zip
  rm -recurse $env:TEMP\Windows10Debloater-master