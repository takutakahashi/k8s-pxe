#!/bin/bash

git clone https://github.com/cloudflare/cfssl.git -b v1.4.1 /tmp/cfssl
docker run -it -v /tmp/cfssl:/src golang:1.14 bash -c 'cd /src; make'
cp /tmp/cfssl/bin/* /bin/
