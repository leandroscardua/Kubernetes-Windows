# Kubernetes-Windows

![alt text](https://github.com/leandroscardua/Kubernetes-Windows/raw/master/Untitled%20Diagram.jpg?raw=true)

# Installing requirements on the Windows Node to join Kubernetes Cluster node 1
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node.ps1
.\windows-node1.ps -servername win19-n1 | Out-Null

# Installing requirements on the Windows Node to join Kubernetes Cluster node 2
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node.ps1
.\windows-node2.ps -servername win19-n2 | Out-Null

# Install K8s on Windows node 1
curl.exe -LO https://github.com/leandroscardua/Kubernetes-Windows/blob/master/Install-k8s-windows.ps1
.\Install-k8s-windows.ps1 -k8sversion v1.18.0 | Out-Null

# Install K8s on Windows node 2
curl.exe -LO https://github.com/leandroscardua/Kubernetes-Windows/blob/master/Install-k8s-windows.ps1
.\Install-k8s-windows.ps1 -k8sversion v1.18.0  | Out-Null


