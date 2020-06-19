#!/bin/bash -ex

if [[ "`cat /opt/status`" = "rebooted" ]]; then
        rm /opt/status
        curl -X POST $SLACK_URL -d '{"text":"halted"}'
        halt
fi
/bin/apply_eeprom
ls /dev/sda && /bin/burn_img
/bin/inject_provision
JSON_FMT='{"text":"%s"}'
SERIAL=`cat /proc/cpuinfo  |grep Serial |cut -c 19-`
curl -X POST $SLACK_URL -d "`printf "$JSON_FMT" "$SERIAL"`"
curl -X POST $SLACK_URL -d '{"text":"rebooted"}'
echo "rebooted" > /opt/status
reboot
