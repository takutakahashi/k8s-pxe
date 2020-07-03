#!/bin/bash
dig SRV $1 +short |awk '{printf "%s:%s\n",$4,$3}'
