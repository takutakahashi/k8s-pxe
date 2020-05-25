#!/bin/bash -xe

K3S_OPTS="--node-taint k3s-controlplane=true:NoExecute --no-deploy traefik"
ls /bin/k3s && ls /var/lib/rancher/k3s && k3s server $K3S_OPTS
apt install -y dnsutils netcat
wget "https://github.com/rancher/k3s/releases/download/v1.16.9%2Bk3s1/k3s-armhf"
chmod +x k3s-armhf
mv k3s-armhf /bin/k3s
host=k8s.lab.takutakahashi.dev
for i in 1 2 3 4 5
do
  echo exit |nc -w 10 $host 6443 && ( K3S_TOKEN=`dig +short TXT ${host} | sed 's/"//g'` k3s server --server https://${host}:6443 $K3S_OPTS) || true
done

register_secret.sh &
k3s server --cluster-init --tls-san k8s.lab.takutakahashi.dev $K3S_OPTS
