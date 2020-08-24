# Kubernetes-Windows

# Installing requirements on the Windows Node to join Kubernetes Cluster node 1
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node1.ps1
.\windows-node1.ps1 | Out-Null

# Installing requirements on the Windows Node to join Kubernetes Cluster node 2
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node2.ps1
.\windows-node2.ps1 | Out-Null

# Install K8s on Windows node 1 and 2
curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion v1.18.0 | Out-Null
