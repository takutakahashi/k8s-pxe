#!/bin/bash

while [[ ! -f "/var/lib/rancher/k3s/server/token" ]];
do
  sleep 1
done

docker run -it --env-file=/etc/registerer/env takutakahashi/route53-registerer `hostname` TXT \\\"`cat /var/lib/rancher/k3s/server/token`\\\"
