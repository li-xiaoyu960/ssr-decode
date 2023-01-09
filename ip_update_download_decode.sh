#!/bin/sh
#
# Author: Lu Xu <oliver_lew at outlook at com>
# License: MIT License. 2021-2021 Lu Xu
#
# A shell script to parse Shadowsocks(R)/v2ray subscription links
# and generate json config files
#
# Requirements: base64, curl/wget (optional)

## oM-* |^iss类 ~^k |^` a |M-, |M-0端 oM-# p^w =没 o^q nM-0 |^i tM-( l gM-*己 z^o便设置
local_port=${LOCAL_PORT:-1080}
timeout=${TIMEOUT:-300}

decode_base64() {
        case "$((${#1} % 4))" in
                2) echo "$1==" ;;
                3) echo "$1=" ;;
                *) echo "$1" ;;
        esac | tr '_-' '/+' | grep -o "^[a-zA-Z0-9+/=]*" | base64 -d
}

decode_ss() {
        IFS=:@\  read -r method password server server_port <<- EOF
                ${1%%/?*}
        EOF
        conf=$(echo "/etc/openclash/proxy_provider/ip_update_latest.json")
        echo "Saving to $conf"
        cat >> "$conf" <<- EOF
            server: $server
        EOF
        cat >> /etc/openclash/proxy_provider/ip_update_log.log <<- EOF
        ** |M-,次解 ~^p z^dSS m^o议 |^m jM-! yM-(IP |M-0 }^`为 z$server
        EOF
}

decode_ssr() {
        IFS=:\  read -r server server_port protocol method obfs password <<- EOF
                ${1%%/?*}
        EOF

        while IFS='=' read -r key value; do
                [ -n "$value" ] && eval "$key=\"$(decode_base64 "$value")\""
        done <<- EOF
                $(echo "${1#*/?}" | tr '&' '\n')
        EOF

        conf=$(echo "ssr-${group:-NoGroup}-${remarks:-Null}.json" | tr "/ " _)
        echo "Saving to $conf"
        cat > "$conf" <<- EOF
        {
            "server": "$server",
            "server_port": $server_port,
            "password": "$(decode_base64 "$password")",
            "local_address": "127.0.0.1",
            "local_port": $local_port,
            "timeout": $timeout,
            "method": "$method",
            "protocol": "$protocol",
            "protocol_param": "${protoparam:-null}",
            "obfs": "$obfs",
            "obfs_param": "${obfsparam:-null}"
        }
        EOF
}


decode_vmess() {
        while IFS=': ' read -r key value; do
                [ -n "$value" ] && eval "$key=\"$value\""
        done <<- EOF
                $(echo "$1" | tr '{,}' '\n' | tr -d '"')
        EOF
        conf=$(echo "/etc/openclash/proxy_provider/ip_update_latest.json")
        echo "Saving to $conf"
        cat >> "$conf" <<- EOF
            server: ${add-null}
        EOF
        cat >> /etc/openclash/proxy_provider/ip_update_log.log <<- EOF
        ** |M-,次解 ~^p z^dVMESS m^o议 |^m jM-! yM-(IP |M-0 }^`为: ${add-null}
        EOF
}

decode_link() {
        info=$(decode_base64 "${1#*://}")
        case "${1%%:*}" in
                ss)     decode_ss "$info" ;;
                ssr)    decode_ssr "$info" ;;
                vmess)  decode_vmess "$info" ;;
                #https) decode_link "$(wget -qO - "$1")" ;; o^x h^p k }M-" z^d格 o l cM-= =记 u o次wget访 wM-.订 x^e sM-> nM-% h^p j^= n pM-& `^a访 wM-. wM-6 wM-4 `^a s gM-:                    >
                https) decode_link "$(wget -a /etc/openclash/proxy_provider/ip_update_log.log -O - "$1")" ;;

                *)      for link in $info; do decode_link "$link"; done ;;
        esac
}

##主 k o m置 l$#代表传 eM-% o^b uM-0个 uM-0 l$1代表第 `个 o^b uM-0 l h^q z^d订 x^e sM-> nM-%使 tM-(0个 o^b uM-0 l i^k jM-( s eM-% sM-> nM-% cM-= k载 f hM-+ l {M-4                               >
##使 tM-(sh ssr-decode "https://"  cM-=正常解 ~^p使 tM-(
if [ "$#" = 1 ] && [ "$1" = "-h" ]; then
        echo "Usage: ssr-decode [ (http|https|ss|ssr|vmess):// | BASE64 | < input.txt ]"
elif [ "$#" = 0 ]; then
        while read -r link; do
                decode_link "$link"
        done
else
        for link in "$@"; do
                decode_link "$link"
        done
fi
exit 0

