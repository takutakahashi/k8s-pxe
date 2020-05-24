#!/bin/bash

### docker install ###
apt update -y
apt install -y docker.io

### register DNS record ###
/bin/register_dns.sh

### k3s up ###
/bin/k3s_up.sh
