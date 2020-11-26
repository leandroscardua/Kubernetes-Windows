[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
param(
  [Parameter(Mandatory=$true)]
  [String]$k8sversion
)

# Installing requirements on the Windows Node to join Kubernetes Cluster

curl.exe -LO https://github.com/kubernetes-sigs/sig-windows-tools/releases/latest/download/PrepareNode.ps1
.\PrepareNode.ps1 -KubernetesVersion "$k8sversion" | Out-Null

# install fix after reboot

Set-Content C:\k\StartKubelet.ps1 -Value {
$FileContent = Get-Content -Path "/var/lib/kubelet/kubeadm-flags.env"
$global:KubeletArgs = $FileContent.Trim("KUBELET_KUBEADM_ARGS=`"")

$netId = docker network ls -f name=host --format "{{ .ID }}"
if ($netId.Length -lt 1) {
    docker network create -d nat host
}

$cmd = "C:\k\kubelet.exe $global:KubeletArgs --cert-dir=$env:SYSTEMDRIVE\var\lib\kubelet\pki --config=/var/lib/kubelet/config.yaml --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --hostname-override=$(hostname) --pod-infra-container-image=`"mcr.microsoft.com/k8s/core/pause:1.2.0`" --enable-debugging-handlers --cgroups-per-qos=false --enforce-node-allocatable=`"`" --network-plugin=cni --resolv-conf=`"`" --log-dir=/var/log/kubelet --logtostderr=false --image-pull-progress-deadline=20m"

Invoke-Expression $cmd
}
