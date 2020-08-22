# Download Debloater scripts
  Write-Host Downloading Windows10debloater zip
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $url="https://github.com/Sycnex/Windows10Debloater/archive/master.zip"
  (New-Object System.Net.WebClient).DownloadFile($url, "$env:TEMP\debloat.zip")
  Expand-Archive -Path $env:TEMP\debloat.zip -DestinationPath $env:TEMP -Force

# Execute Windows10debloater 
  Write-Host Execute Windows10debloater
  . $env:TEMP\Windows10Debloater-master\Windows10SysPrepDebloater.ps1 -Sysprep -Debloat -Privacy

  # Enable Administrator account
  Write-host Enable Administrator account
  cmd /c net user administrator /active:yes

  rm $env:TEMP\debloat.zip
  rm -recurse $env:TEMP\Windows10Debloater-master