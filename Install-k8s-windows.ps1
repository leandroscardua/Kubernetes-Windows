# Installing requirements on the Windows Node to join Kubernetes Cluster

curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.18.0 | Out-Null
