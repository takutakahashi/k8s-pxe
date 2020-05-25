#!/bin/bash -x
apt install -y dnsutils netcat
ls /bin/k3s && ls /bar/lib/rancher && k3s server
wget "https://github.com/rancher/k3s/releases/download/v1.17.5%2Bk3s1/k3s-armhf"
chmod +x k3s-armhf
mv k3s-armhf /bin/k3s
SERIAL=`cat /proc/cpuinfo |grep -i serial |awk '{print $3}'`
test "$SERIAL" = "" && SERIAL="aaaaaaaaaaaaaaa"
dig +short SRV k3s-master.lab.takutakahashi.dev |grep -v "$SERIAL"|awk '{print $4}' |while read host
do
  for i in 1 2 3 4 5
  do
    echo exit |nc -w 10 ${host} 6443 && ( K3S_TOKEN=`dig +short TXT ${host} | sed 's/"//g'` k3s server --server https://${host}:6443) || true
  done
done

k3s server --cluster-init --tls-san k8s.lab.takutakahashi.dev
