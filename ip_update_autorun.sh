#!/bin/sh
#echo "UTF-8 is græat ☺"
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/etc/openclash
export LANG="en_US.UTF-8" 

rm /etc/openclash/ip_update_latest.json
sleep 30
sh /etc/openclash/ip_update_download_decode.sh "https://XXXXXXXXXXXXXXX"
sleep 30
sh /etc/openclash/ip_update_sed.sh >>/etc/openclash/ip_update_log.log
sleep 30

exit 0