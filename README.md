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
**Disclaimer:**调试模式，查看运行流程
```sh
  4.sh node-decode.sh vmess://sdfdsgfdgssdfgdsgfdg
  5.sh node-decode.sh < file.txt
 ```
**Disclaimer:**file.txt为base64格式的字符串或者ss、vmess开头的链接
**Disclaimer:**ss、vmess开头的链接也是base64格式加密的格式文件
```sh
  6.bash node-decode.sh vmess://sdfdsgfdgssdfgdsgfdg
  7.bash node-decode.sh https://sdfdsgfdgssdfgdsgfdg
 ```
