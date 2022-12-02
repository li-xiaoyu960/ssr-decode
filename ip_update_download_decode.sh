#!/bin/sh
#
# Author: Lu Xu <oliver_lew at outlook at com>
# License: MIT License. 2021-2021 Lu Xu
#
# A shell script to parse Shadowsocks(R)/v2ray subscription links
# and generate json config files
#
# Requirements: base64, curl/wget (optional)

##只有ss类型需要本地端口吗？没发现有用，自己随便设置
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
	conf=$(echo "/etc/openclash/ip_update_latest.json")
	echo "Saving to $conf"
	cat >> "$conf" <<- EOF
	  server: $server
	EOF
	cat >> /etc/openclash/ip_update_log.log <<- EOF
	**本次解析的SS协议服务器IP地址为：$server
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
	conf=$(echo "/etc/openclash/ip_update_latest.json")
	echo "Saving to $conf"
	cat >> "$conf" <<- EOF
	  server: ${add-null}
	EOF
	cat >> /etc/openclash/ip_update_log.log <<- EOF
	**本次解析的VMESS协议服务器IP地址为: ${add-null}
	EOF
}

decode_link() {
	info=$(decode_base64 "${1#*://}")
	case "${1%%:*}" in
		ss)     decode_ss "$info" ;;
		ssr)    decode_ssr "$info" ;;
		vmess)  decode_vmess "$info" ;;
		#https) decode_link "$(wget -qO - "$1")" ;;变成下面的格式，能够记录每次wget访问订阅链接成功与否、访问时间、输出形式
		https) decode_link "$(wget -a /etc/openclash/ip_update_log.log -O - "$1")" ;;
		
		*)      for link in $info; do decode_link "$link"; done ;;
	esac
}

##主程序位置，$#代表传入参数个数，$1代表第一个参数，我的订阅链接使用0个参数，手动输入链接能下载识别，直接输入第一个参数却不能完全识别链接地址，在&后识别不了
##使用sh ssr-decode "https://" 能正常解析使用
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
