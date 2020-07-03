#!/bin/bash
ls /bin/etcd || /bin/etcd_build.sh
HOSTNAME=`hostname`
IP=`dig +short $HOSTNAME`
ETCD_UNSUPPORTED_ARCH=arm /bin/etcd --name $HOSTNAME  --data-dir /var/lib/etcd/$HOSTNAME \
  --initial-advertise-peer-urls https://$HOSTNAME:2380 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster-state new \
  --initial-cluster f903c77f.lab.takutakahashi.dev=http://10.10.1.14:2380,dd03570a.lab.takutakahashi.dev=http://10.10.1.15:2380,2dff6fc0.lab.takutakahashi.dev=http://10.10.1.27:2380 \
  --advertise-client-urls https://$HOSTNAME:2379 \
  --listen-client-urls https://$IP:2379,https://127.0.0.1:2379 \
  --listen-peer-urls https://$IP:2380
