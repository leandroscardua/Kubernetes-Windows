sudo hostnamectl set-hostname k8s-primary

sudo apt-get update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg libseccomp2

# netfilter and everlay
sudo modprobe br_netfilter
sudo modprobe overlay

# Disable swap 
sudo swapoff -a

# Enables IP Forward 
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo sysctl --system

# Install ContainerD
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Configure containerD
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# install Kubernetes /
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update
sudo apt install -y kubelet
sudo apt install -y kubeadm
sudo apt install -y kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Enable autocomplete for kubectl
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc

# Initialize kubeadm
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

# Enable non-root use kubeadm
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Installing a Pod network add-on 

wget https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/kube-flannel.yml

sudo kubectl apply -f kube-flannel.yml

# Install Windows Flannel and kube-proxy DaemonSet, current version 1.19.5
curl -L https://github.com/kubernetes-sigs/sig-windows-tools/releases/download/v0.1.5/kube-proxy.yml | sed 's/VERSION/"1.24.0"/g' | kubectl apply -f -
sudo kubectl apply -f https://github.com/kubernetes-sigs/sig-windows-tools/releases/download/v0.1.5/flannel-overlay.yml

