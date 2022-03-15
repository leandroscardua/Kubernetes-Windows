#param(
#  [Parameter(Mandatory=$true)]
#  [String]$k8sversion
#)
#Enable Donwloadas
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Installing requirements on the Windows Node to join Kubernetes Cluster

curl.exe -LO https://raw.githubusercontent.com/kubernetes-sigs/sig-windows-tools/master/kubeadm/scripts/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.23.4 -ContainerRuntime Docker | Out-Null

# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/adding-windows-nodes/#install-wins-kubelet-and-kubeadm
