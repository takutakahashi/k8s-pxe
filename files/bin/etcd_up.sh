#!/bin/bash
ls /bin/etcd || /bin/etcd_build.sh
HOSTNAME=`hostname`
IP=`dig +short $HOSTNAME`
ETCD_UNSUPPORTED_ARCH=arm /bin/etcd --name $HOSTNAME  --data-dir /var/lib/etcd/$HOSTNAME \
  --cert-file=/etc/etcd/certs/server.crt --key-file=/etc/etcd/certs/server.key \
  --peer-auto-tls \
  --discovery-srv lab.takutakahashi.dev \
  --initial-advertise-peer-urls https://$HOSTNAME:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster-state new \
  --advertise-client-urls https://$HOSTNAME:2379 \
  --listen-client-urls https://$IP:2379,https://127.0.0.1:2379 \
  --listen-peer-urls https://$IP:2380
