#/!/bin/sh
#echo "UTF-8 is græat ☺"

rm ip_update_latest.json
sleep 30
sh ip_update_download_decode.sh "https://***.php?service=***"
sleep 30
sh ip_update_sed.sh >>ip_update_log.log
sleep 30

exit 0