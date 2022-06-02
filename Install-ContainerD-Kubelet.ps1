#param(
#  [Parameter(Mandatory=$true)]
#  [String]$k8sversion
#)
# Enable Download
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Installing ContainerD
curl.exe -L https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/Install-Containerd.ps1 > c:\Windows\temp\Install-Containerd.ps1

Write-Host "Installing ContainerD"
c:\Windows\Temp\PrepareNode.ps1 -ContainerDVersion 1.6.4
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#joining-a-windows-worker-node

# Installing requirements on the Windows Node to join Kubernetes Cluster
curl.exe -L https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/PrepareNode.ps1 > c:\Windows\temp\PrepareNode.ps1
#.\PrepareNode.ps1 -KubernetesVersion "v1.23.4" -ContainerRuntime "Docker"
Write-Host "Installing Kubelet"
c:\Windows\Temp\PrepareNode.ps1 -KubernetesVersion "v1.24.0" -ContainerRuntime "ContainerD"
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#install-wins-kubelet-and-kubead
