# 经修改后的使用方法
## 编辑复制
 - 1.复制代码复制到命名为node-decode.sh的文件中
## 执行方式
```sh
  1.sh node-decode.sh https://fghfsdfdsafsdf
  2.sh node-decode.sh "https://fghfsdfdsafsdf"
 ```
  **Disclaimer:**我的订阅链接中有&符号，后面的网址内容均不能识别，所以加上引号以后能正常解析下载
  ```sh
  3.sh -x node-decode.sh "https://fghfsdfdsafsdf"
 ```
**调试模式，查看运行流程
```sh
  4.sh node-decode.sh vmess://sdfdsgfdgssdfgdsgfdg
  5.sh node-decode.sh < file.txt
 ```
**file.txt为base64格式的字符串或者ss、vmess开头的链接
**ss、vmess开头的链接也是base64格式加密的格式文件
```sh
  6.bash node-decode.sh vmess://sdfdsgfdgssdfgdsgfdg
  7.bash node-decode.sh https://sdfdsgfdgssdfgdsgfdg
 ```


# Shadowsocks(R)/V2Ray subscription decoder/parser

A 100-line POSIX compatible shell script to decode, parse Shadowsocks(R)/V2Ray subscription link and create configuration files.

**Disclaimer:** This is a toy project. I don't know the standard of the encoding of those link URLs, so some parsing could quite possibly go wrong.

## Requirement:

- `base64` to decode base64 format data
- `curl` or `wget` to download http links (optional)

## Usage

The script accepts one or more links as CLI arguments or from pipe. The links can be one of the formats:
- A single `ss://` or `ssr://` or `vmess://` link. This contains a single configuration.
- A `http(s)://` subscription link. This normally contains multiple configurations.
- A base64 encoded string downloaded from a subscription link.

```
ssr-decode [ http(s)://link | ss(r)://BASE64 | vmess://BASE64 | BASE64 | < input.txt ]
```

### Issues

Some links encode the strings in other encodings other than UTF-8, the script will still decode with UTF-8. So, expect some non-sense garbles if you run into some of them.

### Customization

The `local_port` and `timeout` in the shadowsocks settings can be controlled with environment variables by `LOCAL_PORT` and `TIMEOUT`, the default is 1080 for local port and 300 for timeout

```sh
LOCAL_PORT=1234 TIMEOUT=600 ssr-decode
```

## Output

The script will generate `*.json` configuration files for each Shadowsocks(R)/V2Ray setup.

- The ShadowsocksR configuration file will be named `ssr-$group-$remarks.json` with `group` normally being the service provider, `remarks` being the description of this setup.
- The Shadowsocks configuration file will be named `ss-$server-$port.json`.
- The V2Ray configuration file will be named `v2ray-$ps.json` with `ps` normally being the description.
