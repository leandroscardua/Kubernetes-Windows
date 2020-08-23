$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

Write-Host "Rename the computer to win19-n1"
#Rename
Rename-Computer -NewName "win19-n1" | Out-Null

Write-Host "Rename the network interface to Ethernet"
# Rename network interface to Ethernet
Rename-NetAdapter -Name (Get-NetAdapter -Name * -Physical).Name -NewName "Ethernet" | Out-Null

Write-Host "Enabling Winrm Access"
# Enable winrm access 
Set-WSManQuickConfig -Force | Out-Null

Write-Host "Disabling Windows Updates"
#Disable Windows Update
Stop-Service -Name "wuauserv" -Force | Out-Null
Set-Service -Name "wuauserv" -StartupType Disabled | Out-Null

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
Write-Host "Installing Docker Engine Enterprise"
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force | Out-Null

# Install the client interface to manage the Docker Engine Enterprise
Write-Host "Installing Interface de Gerenciamento of the Docker"
Install-Package -Name docker -ProviderName DockerMsftProvider -Force | Out-Null

# Installing requirements on the Windows Node to join Kubernetes Cluster

curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.18.0

pause

Write-Host "Please, Hit enter to reboot the server to complete the configuration"

Restart-Computer


