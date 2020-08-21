
# Rename the interface
Rename-NetAdapter -Name Get-NetAdapter -Name * -Physical -NewName "Ethernet"

# Uninstall Windows Defender
Uninstall-WindowsFeature Windows-Defender

curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.18.0

#kubeadm join 
