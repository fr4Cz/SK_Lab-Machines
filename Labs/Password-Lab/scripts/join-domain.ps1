# Purpose: Joins a Windows host to the contoso.com domain which was created with "create-domain.ps1".
# Source: https://github.com/StefanScherer/adfs2

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Joining the domain..."

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) First, set DNS to DC to join the domain..."
$newDNSServers = "192.168.56.102"
$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.IPAddress -match "192.168.56."}
$adapters | ForEach-Object {$_.SetDNSServerSearchOrder($newDNSServers)}

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Now join the domain..."
$hostname = $(hostname)
$user = "contoso.com\vagrant"
$pass = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$DomainCred = New-Object System.Management.Automation.PSCredential $user, $pass

# Place the computer in the correct OU based on hostname
If ($hostname -eq "wef") {
  Add-Computer -DomainName "contoso.com" -credential $DomainCred -OUPath "ou=Servers,dc=contoso,dc=com" -PassThru
} ElseIf ($hostname -eq "win10") {
  Write-Host "Adding Win10 to the domain. Sometimes this step times out. If that happens, just run 'vagrant reload win10 --provision'" #debug
  Add-Computer -DomainName "contoso.com" -credential $DomainCred -OUPath "ou=Workstations,dc=contoso,dc=com"
} Else {
  Add-Computer -DomainName "contoso.com" -credential $DomainCred -PassThru
}

Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoAdminLogon -Value 1
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultUserName -Value "vagrant"
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name DefaultPassword -Value "vagrant"
