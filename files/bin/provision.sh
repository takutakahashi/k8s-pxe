#!/bin/bash

### docker install ###

apt update -y
apt install -y docker.io

### register DNS record ###
/bin/register_dns.sh
