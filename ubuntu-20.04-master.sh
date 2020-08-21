sudo hostnamectl set-hostname k8s-master

sudo apt-get update && sudo apt upgrade && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Enable netfilter / habilitar netfilter
sudo modprobe br_netfilter

# Disable swap / Disabilitando swap
sudo swapoff -a

# Enables IP Forward / Habilitando redirecionamento
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl --system

# Install docker / Instalando o Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update && apt-cache policy docker-ce
sudo usermod -aG docker ${USER}

# install Kubernetes / Instalando o Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update && sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Initialize kubeadm
sudo kubeadm init

# Enable non-root use kubeadm
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Installing a Pod network add-on / Instalando Pod Network Addon

wget https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/kube-flannel.yml











