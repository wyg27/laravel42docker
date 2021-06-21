# 利用本 docker 设置开发环境的步骤

1、安装 Docker Desktop（Mac OS/Windows）

https://hub.docker.com/editions/community/docker-ce-desktop-mac

2、从 BitBucket 获取代码

    2.1 安装最新版的 composer，推荐用下载 composer.phar 的方式。
    2.2 在项目根目录下执行 php composer.phar update
    2.3 在项目根目录下创建 .env.php 文件，完成必要的环境变量配置。

3、将 docker-compose.yml 文件置于代码的根目录

4、第一次需要执行命令 docker-compose up -d，之后通过 Docker Desktop 的 UI 就可以操作了。

5、可选，但是建议：通过 /etc/hosts（Windows 为 c:\windows\system32\drivers\etc\hosts） 为 http://localhost:8080/ 设定一个“本地域名”。比如：

```
127.0.0.1    dummy-host3.example.com
```

但是，访问时仍然需要带上端口号。即 http://dummy-host3.example.com:8080/


# 用本地 image 导出 tar 备份文件的方式

docker save [image id] -o [备份文件] [image 的名字，最好和导出前保持一致]

例子：

```bash
docker save fe62a8c8e712 -o foodhwy_server.tar wyg27/laravel42-php8:v8.0.7
docker save 1319b1eaa0b7 -o foodhwy_redis.tar redis:6.0.6
```
