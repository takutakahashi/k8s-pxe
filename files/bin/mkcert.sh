#!/bin/bash
HOSTNAME=`hostname`
IP=`dig +short $HOSTNAME`
ls /bin/cfssl || cfssl_build.sh
cd /tmp/pxe/files/bin/cfssl
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
echo '{"CN":"k8s.lab.takutakahashi.dev","hosts":[""],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server -hostname="$IP,$HOSTNAME,localhost,127.0.0.1" - | cfssljson -bare server
