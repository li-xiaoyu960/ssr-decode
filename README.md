# 自定义后的使用方法
## 运行流程
 - first step
```sh
rm ip_update_latest.json 
```
 - second step
 ```sh
sh ip_update_download_decode.sh "https://***.php?service=***"
```
 - third step
 ```sh
sh ip_update_sed.sh >>ip_update_log.log
```

## 文件说明

共有四个文件：  
分别是  
 - ip_update_download_decode.sh       
    **Disclaimer:**负责下载订阅文件并base64解码成节点信息，分别以"  server= *.*.*.*"输出到ip_update_latest.json文件中，每个ip占用一行  
 - ip_update_sed.sh  
    **Disclaimer:**负责将ip_update_latest.json每行IP地址与配置文件对应行的IP地址比对，null、相同、不同分别采取不同措施  
 - ip_update_latest.json  
    **Disclaimer:**存储订阅的最新IP信息  
 - ip_update_log.log  
    **Disclaimer:**记录ip_update_download_decode.sh和ip_update_sed.sh脚本产生的日志信息  
 - ip_update_autorun.sh  
    **Disclaimer:**配置上订阅链接地址，写入定时任务即可自动执行  
    chmod +x /etc/openclash/ip_update*        #必须增加执行权限，不然报权限拒绝错误  
    crontab -e  
    SHELL=/bin/bash           #必须定义SHELL类型  
    PATH=/sbin:/bin:/usr/sbin:/usr/bin    #必须指定环境变量  
    0 */1 * * * /etc/openclash/ip_update_autorun.sh       #文件路径以及文件内的路径必须是绝对路径，每小时执行一次  
