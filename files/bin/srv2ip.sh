#!/bin/bash
dig SRV $1 +short |awk '{print $4}' |while read line
do
  echo `dig +short $line`
done
