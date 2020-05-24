#!/bin/bash

while [ !`ls /var/lib/rancher/k3s/server/token >/dev/null 2>&1` ];
do
  sleep 1
done


docker run -it --env-file=/etc/registerer/env takutakahashi/route53-registerer `hostname` TXT \\\"`cat /var/lib/rancher/k3s/server/token`\\\"
