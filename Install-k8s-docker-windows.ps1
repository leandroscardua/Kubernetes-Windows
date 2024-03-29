#param(
#  [Parameter(Mandatory=$true)]
#  [String]$k8sversion
#)
# Enable Download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Installing requirements on the Windows Node to join Kubernetes Cluster
Write-Host "Downloadling ps1"
curl.exe -L https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/PrepareNode.ps1 > c:\Windows\temp\PrepareNode.ps1
#.\PrepareNode.ps1 -KubernetesVersion "v1.23.4" -ContainerRuntime "Docker"
Write-Host "Installing K8s"
c:\Windows\Temp\PrepareNode.ps1 -KubernetesVersion "v1.24.0" -ContainerRuntime "Docker"
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#install-wins-kubelet-and-kubeadm
