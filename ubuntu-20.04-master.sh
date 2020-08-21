sudo hostnamectl set-hostname k8s-master

sudo apt-get update && sudo apt upgrade && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Enable netfilter 
sudo modprobe br_netfilter

# Disable swap 
sudo swapoff -a

# Enables IP Forward 
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl --system

# Install docker 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update && apt-cache policy docker-ce
sudo usermod -aG docker ${USER}

# install Kubernetes /
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update && sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize kubeadm
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

# Enable non-root use kubeadm
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Installing a Pod network add-on 

wget https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/kube-flannel.yml

kubectl apply -f kube-flannel.yml

# Install Windows Flannel and kube-proxy DaemonSet, current version 1.18.0
curl -L https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/kube-proxy.yml | sed 's/VERSION/v1.18.0/g' | kubectl apply -f -
kubectl apply -f https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/flannel-overlay.yml











