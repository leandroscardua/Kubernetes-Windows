sudo hostnamectl set-hostname k8s-primary

sudo apt-get update && sudo apt upgrade -y && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

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
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

# change cggroup to systemd
cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl daemon-reload && systemctl restart docker

# install Kubernetes /
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update
sudo apt install -y kubelet
sudo apt install -y kubeadm
sudo apt install -y kubectl

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
curl -L https://raw.githubusercontent.com/leandroscardua/Kubernetes-Windows/master/kube-flannel.yml | kubectl apply -f -

# Install Windows Flannel and kube-proxy DaemonSet, current version 1.23.0
curl -L https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/kube-proxy.yml | sed 's/VERSION/v1.23.0/g' | kubectl apply -f -
kubectl apply -f https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/flannel-host-gw.yml
