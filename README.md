# Kubernetes-Windows

![alt text](https://github.com/leandroscardua/Kubernetes-Windows/raw/master/Untitled%20Diagram.jpg?raw=true)

# Installing kubernetes on the Linux primary node to deploy a Kubernetes Cluster

wget https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/ubuntu-20.04-primary-docker.sh
&& chmod +x ubuntu-20.04-primary-docker.sh
&& ./ubuntu-20.04-primary-docker.sh

# Installing requirements on the Windows node 1
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node.ps1

.\windows-node.ps1 -servername win19-n1 | Out-Null

# Installing requirements on the Windows node 2
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/windows-node.ps1

.\windows-node.ps1 -servername win19-n2 | Out-Null

# Install K8s on Windows node 1
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/Install-k8s-windows.ps1

.\Install-k8s-windows.ps1 -k8sversion v1.23.4 | Out-Null

# Install K8s on Windows node 2
curl.exe -LO https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/Install-k8s-windows.ps1

.\Install-k8s-windows.ps1 -k8sversion v1.23.4 | Out-Null


