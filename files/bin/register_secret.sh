#!/bin/bash

while [[ ! -f "/var/lib/rancher/k3s/server/token" ]];
do
  sleep 1
done
ADDR=`ip a |grep eth0 |grep inet |awk '{print $2}' |awk -F'/' '{print $1}'`
docker pull takutakahashi/route53-registerer
docker run --env-file=/etc/registerer/env takutakahashi/route53-registerer k8s.lab.takutakahashi.dev A $ADDR
docker run --env-file=/etc/registerer/env takutakahashi/route53-registerer `hostname` TXT \\\"`cat /var/lib/rancher/k3s/server/token`\\\"
