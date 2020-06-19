#!/bin/bash
ls /bin/etcd || /bin/etcd_build.sh
HOSTNAME=`hostname`
IP=`dig +short $HOSTNAME`
ETCD_UNSUPPORTED_ARCH=arm /bin/etcd --name `hostname` --initial-advertise-peer-urls http://$IP:2380 \
  --listen-peer-urls http://$IP:2380 \
  --listen-client-urls http://$IP:2379,http://127.0.0.1:2379 \
  --advertise-client-urls http://$IP:2379 \
  --discovery https://discovery.etcd.io/5586cb47489459c0ca8c025d42bee89f
