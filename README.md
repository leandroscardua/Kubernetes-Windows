# Kubernetes-Windows

# Installing requirements on the Windows Node to join Kubernetes Cluster node 1
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node1.ps1
.\windows-node1.ps1 | Out-Null

# Installing requirements on the Windows Node to join Kubernetes Cluster node 2
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node2.ps1
.\windows-node2.ps1 | Out-Null

# Install K8s on Windows node 1 and 2
curl.exe -LO https://github.com/leandroscardua/Kubernetes-Windows/blob/master/Install-k8s-windows.ps1
.\Install-k8s-windows.ps1 | Out-Null
