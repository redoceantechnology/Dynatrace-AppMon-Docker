#!/usr/bin/env bash

OLD_LICENSE_FILE=`lsof -iTCP -sTCP:LISTEN -n -P | grep 1337 | grep LISTEN`
#TODO: Scan for process, if running kill it
#TODO: fetch local ip and update pull script with correct ip

if [[ ${OLD_LICENSE_FILE} != '' ]]; then
   echo "Old license still running, killing it"
   kill -9 `lsof -iTCP -sTCP:LISTEN -n -P | grep 1337 | grep LISTEN | awk '{print$2}'`
   nohup nc -l 1337 < trial-license/appmon_license_201904011038.lic &
else
   echo "Serving license file..."
   nohup nc -l 1337 < trial-license/appmon_license_201904011038.lic &
fi
