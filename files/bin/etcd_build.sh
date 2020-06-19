#!/bin/bash -xe
rm -rf /tmp/etcd
git clone https://github.com/etcd-io/etcd.git -b v3.4.8 /tmp/etcd
docker run -v /tmp/etcd:/src golang:1.14 bash -c 'cd /src; make'
cp /tmp/etcd/bin/* /bin/
