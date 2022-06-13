# Enable Download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Rename the network interface to Ethernet"
# Rename network interface to Ethernet
Rename-NetAdapter -Name (Get-NetAdapter -Name * -Physical).Name -NewName "Ethernet"

$tagcd = (Invoke-WebRequest -UseBasicParsing "https://api.github.com/repos/containerd/containerd/releases/latest" | ConvertFrom-Json)[0].tag_name
$lvcd = $tagcd -replace "v",""

$tagk8s = (Invoke-WebRequest -UseBasicParsing "https://api.github.com/repos/kubernetes/kubernetes/releases/latest" | ConvertFrom-Json)[0].tag_name
$lvk8s = $tagk8s -replace "v",""

#Installing ContainerD
curl.exe -L https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/Install-Containerd.ps1 > c:\Windows\temp\Install-Containerd.ps1

Write-Host "Installing ContainerD version: $tagcd"
c:\Windows\Temp\Install-Containerd.ps1 -ContainerDVersion "$lvcd"
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#joining-a-windows-worker-node

# Installing requirements on the Windows Node to join Kubernetes Cluster
curl.exe -L https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/PrepareNode.ps1 > c:\Windows\temp\PrepareNode.ps1
#.\PrepareNode.ps1 -KubernetesVersion "v1.23.4" -ContainerRuntime "Docker"
Write-Host "Installing kubernetes version: $lvk8s"
c:\Windows\Temp\PrepareNode.ps1 -KubernetesVersion "$tagk8s" -ContainerRuntime "ContainerD"
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#install-wins-kubelet-and-kubead
