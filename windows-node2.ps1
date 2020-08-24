$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

Write-Host "Rename the computer to win19-n2"
#Rename
Rename-Computer -NewName "win19-n2" | Out-Null

Write-Host "Rename the network interface to Ethernet"
# Rename network interface to Ethernet
Rename-NetAdapter -Name (Get-NetAdapter -Name * -Physical).Name -NewName "Ethernet" | Out-Null

Write-Host "Uninstalling Windows-Defender Feature"
# Uninstall Windows Defender
Uninstall-WindowsFeature Windows-Defender | Out-Null

# Update the NuGet Module
Write-Host "Updating The Nuget Package Management"
Install-PackageProvider -Name NuGet -Force | Out-Null

# Install the Windows Feature Containers on the Server
Write-Host "Installing Windows Containers Feature"
Install-WindowsFeature -Name Containers | Out-Null

# Install the Docker Engine Enterprise on the Server
Write-Host "Installing Docker Engine"
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force | Out-Null

# Install the client interface to manage the Docker Engine Enterprise
Write-Host "Installing Docker Client"
Install-Package -Name docker -ProviderName DockerMsftProvider -Force | Out-Null

pause

Write-Host "Please, Hit enter to reboot the server to complete the configuration"

Restart-Computer
