#!/bin/sh
#echo "UTF-8 is græat  xM-:"
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/etc/openclash
export LANG="en_US.UTF-8"

rm /etc/openclash/proxy_provider/ip_update_latest.json
sleep 30
sh /etc/openclash/proxy_provider/ip_update_download_decode.sh "XXXXXXXXXXXXX"
sleep 30
sh /etc/openclash/proxy_provider/ip_update_sed.sh >>/etc/openclash/proxy_provider/ip_update_log.log
sleep 30

exit 0
