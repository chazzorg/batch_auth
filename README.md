# batch_auth

## 目录介绍

```
.
├── auth.sh                 # 命令执行文件
└── host                    # 服务器账号存放文件

```

## 项目介绍

batch_auth 解决批量服务器授权问题，通过执行脚本，可以让管理机器完成对其他目标服务器的ssh密钥授权。

#### 项目地址 ：[码云](https://gitee.com/chazzorg/batch_auth)      [github](https://github.com/chazzorg/batch_auth)

**使用概览：**

1. 编辑目标服务器账号文件 `host`, 最后一行留一行空白
```bash
ipxxxxx root 123456
ipxxxxx root 123456

```

2. 赋予脚本执行权限
 ```bash
chmod 700 ./auth.sh
```

3. 指定配置文件运行脚本。
```bash
./auth.sh host
```
