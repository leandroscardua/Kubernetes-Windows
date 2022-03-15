$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
#Register-PSRepository -Default -Verbose
#Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2/ | Out-Null
#Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted | Out-Null

Write-Host "Rename the network interface to Ethernet"
# Rename network interface to Ethernet
Rename-NetAdapter -Name (Get-NetAdapter -Name * -Physical).Name -NewName "Ethernet" | Out-Null

#Write-Host "Uninstalling Windows-Defender Feature"
# Uninstall Windows Defender
#Uninstall-WindowsFeature Windows-Defender -Remove | Out-Null

# Update the NuGet Module
Write-Host "Updating The Nuget Package Management"
#Install-PackageProvider -Name NuGet -Force | Out-Null
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null

# Install the Windows Feature Containers on the Server
Write-Host "Installing Windows Containers Feature"
Install-WindowsFeature -Name Containers | Out-Null

# Install the Docker Engine Enterprise on the Server
Write-Host "Installing Docker Engine"
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force | Out-Null

# Install the client interface to manage the Docker Engine Enterprise
Write-Host "Installing Docker Client"
Install-Package -Name docker -ProviderName DockerMsftProvider -Force | Out-Null
