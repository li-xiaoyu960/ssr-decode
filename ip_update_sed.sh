#/!/bin/sh
#echo "UTF-8 is græat ☺"

time=`date +%y-%m-%d-%H:%M`
changecount=0
changecontent=""

#新增加的TG推送功能变量
TOKEN=XXX    #TG机器人token
chat_ID=XXX               #用户ID或频道、群ID
#message_text="您于$time有$changecount个节点更新：$changecontent"               #要发送的信息
MODE='HTML'             #解析模式，可选HTML或Markdown
URL="https://api.telegram.org/bot${TOKEN}/sendMessage"          #api接口
####################

#第一个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换 
ss1new=$(sed -n '1p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s1下载新节点$ss1new"

ss1old=$(sed -n '11p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s1现使用节点$ss1old"

if [ -n "$ss1new" ] && [ "$ss1new" = "$ss1old" ]; then
	echo "s1节点IP相同，未作更换"
elif [ -n "$ss1new" ] && [ "$ss1new" != "$ss1old" ]; then
	sed -i "11 s/$ss1old/$ss1new/" /root/.config/clash/proxy-providers/jms.yaml
	ss1update=$(sed -n '11p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s1"	#tg推送模块
	echo "s1节点ip有更新，旧IP为:$ss1old,新的IP为:$ss1update,更新时间为:$time"
else
	echo "节点更新错误"
fi

#第二个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换
ss2new=$(sed -n '2p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s2下载新节点$ss2new"

ss2old=$(sed -n '17p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s2现使用节点$ss2old"

if [ -n "$ss2new" ] && [ "$ss2new" = "$ss2old" ]; then
        echo "s2节点IP相同，未作更换"
elif [ -n "$ss2new" ] && [ "$ss2new" != "$ss2old" ]; then
        sed -i "17 s/$ss2old/$ss2new/" /root/.config/clash/proxy-providers/jms.yaml
        ss2update=$(sed -n '17p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s2"	#tg推送模块
        echo "s2节点ip有更新，旧IP为:$ss2old,新的IP为:$ss2update,更新时间为:$time"
else
        echo "s2节点更新错误"
fi

#第三个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换
vmess3new=$(sed -n '3p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s3下载新节点$vmess3new"

vmess3old=$(sed -n '23p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s3现使用节点$vmess3old"

if [ -n "$vmess3new" ] && [ "$vmess3new" = "$vmess3old" ]; then
        echo "s3节点IP相同，未作更换"
elif [ -n "$vmess3new" ] && [ "$vmess3new" != "$vmess3old" ]; then
        sed -i "23 s/$vmess3old/$vmess3new/" /root/.config/clash/proxy-providers/jms.yaml
        vmess3update=$(sed -n '23p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s3"	#tg推送模块
        echo "s3节点ip有更新，旧IP为:$vmess3old,新的IP为:$vmess3update,更新时间为:$time"
else
        echo "s3节点更新错误"
fi

#第四个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换
vmess4new=$(sed -n '4p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s4下载新节点$vmess4new"

vmess4old=$(sed -n '33p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s4现使用节点$vmess4old"

if [ -n "$vmess4new" ] && [ "$vmess4new" = "$vmess4old" ]; then
        echo "s4节点IP相同，未作更换"
elif [ -n "$vmess4new" ] && [ "$vmess4new" != "$vmess4old" ]; then
        sed -i "33 s/$vmess4old/$vmess4new/" /root/.config/clash/proxy-providers/jms.yaml
        vmess4update=$(sed -n '33p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s4"	#tg推送模块
        echo "s4节点ip有更新，旧IP为:$vmess4old,新的IP为:$vmess4update,更新时间为:$time"
else
        echo "s4节点更新错误"
fi
#第五个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换
vmess5new=$(sed -n '5p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s5下载新节点$vmess5new"

vmess5old=$(sed -n '44p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s5现使用节点$vmess5old"

if [ -n "$vmess5new" ] && [ "$vmess5new" = "$vmess5old" ]; then
        echo "s5节点IP相同，未作更换"
elif [ -n "$vmess5new" ] && [ "$vmess5new" != "$vmess5old" ]; then
        sed -i "44 s/$vmess5old/$vmess5new/" /root/.config/clash/proxy-providers/jms.yaml
        vmess5update=$(sed -n '44p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s5"	#tg推送模块
        echo "s5节点ip有更新，旧IP为:$vmess5old,新的IP为:$vmess5update,更新时间为:$time"
else
        echo "s5节点更新错误"
fi
#第六个节点：在/root/.config/clash/proxy-providers/jms.yaml文件中取得旧IP，在/root/.config/clash/proxy-providers/ip_update_latest.json文件中取得新IP，对比并替换

vmess801new=$(sed -n '6p' /root/.config/clash/proxy-providers/ip_update_latest.json)
echo "s801下载新节点$vmess801new"

vmess801old=$(sed -n '54p' /root/.config/clash/proxy-providers/jms.yaml)
echo "s801现使用节点$vmess801old"

if [ -n "$vmess801new" ] && [ "$vmess801new" = "$vmess801old" ]; then
        echo "s801节点IP相同，未作更换"
elif [ -n "$vmess801new" ] && [ "$vmess801new" != "$vmess801old" ]; then
        sed -i "54 s/$vmess801old/$vmess801new/" /root/.config/clash/proxy-providers/jms.yaml
        vmess801update=$(sed -n '54p' /root/.config/clash/proxy-providers/jms.yaml)
        changecount=`expr $changecount + 1`
	changecontent="$changecontent + s801"	#tg推送模块
        echo "s801节点ip有更新，旧IP为:$vmess801old,新的IP为:$vmess801update,更新时间为:$time"
else
        echo "s801节点更新错误"
fi


if [ $changecount = 0 ]; then
	echo "节点没有更新，openclash未重新启动"
	echo "------------------------------我是本次的分隔符--------本次没有节点更新---------更新时间为：$time-------------------------------"
else
	/etc/init.d/openclash restart
        echo "节点有更新，已重启openclash"
	echo "------------------------------我是本次的分隔符--------本次更新节点$changecount个----------更新时间为：$time--------------------"
	message_text="您于$time有$changecount个节点更新：$changecontent"               #tg推送模块：要发送的信息
        curl -s -o /dev/null -X POST $URL -d chat_id=${chat_ID} -d text="${message_text}"	#tg推送模块
fi	



exit 0


