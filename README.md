# 用本地 image 导出 tar 备份文件的方式

docker save [image id] -o [备份文件] [image 的名字，最好和导出前保持一致]

例子：

```bash
docker save fe62a8c8e712 -o foodhwy_server.tar wyg27/laravel42-php8:v8.0.7
docker save 1319b1eaa0b7 -o foodhwy_redis.tar redis:6.0.6
```
