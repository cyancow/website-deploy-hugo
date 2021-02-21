# website-deploy

## 简介

我的个人网站部署在 k8s，本仓库分享部署相关的脚本、yaml 以及 Dockerfile，网站地址: https://imroc.io

## 特点

* http 自动跳转 https
* https 证书自动续期并 reload
* 网站纯静态，多子目录，静态文件使用 hugo 构建，分散在多个 repo
* 自动拉取最新静态内容
* 无需挂载额外付费的持久化存储

## 关键技术

* Kubernetes & nginx
* cert-manager & ACME & Let's Encrypt
* inotifywait 感知配置变更通知 nginx 热加载
* dumb-init 接管 1 号进程透传 SIGTERM 停止信号给 shell 中启动的进程以实现优雅停止
* initContainer clone 静态文件
* sidecar 同步最新静态文件

## 部署步骤

安装 cert-manager:
``` bash
make cert-manager
```

创建保存 cloudflare API TOKEN 的 Secert (用于 ACME 协议自动签发证书):
``` bash
export API_TOKEN=xx # 替换为 cloudflare 中创建的 API TOKEN
make apitoken
```

创建 Issuer:
``` bash
make issuer
```

签发证书:
``` bash
make cert
```

构建并上传 docker 镜像:
``` bash
make gitimage
docker push imroc.tencentcloudcr.com/library/git:latest
make nginximage
docker push imroc.tencentcloudcr.com/library/nginx:latest
```

生成需要用到的 configmap (配置与脚本):
``` bash
make gencm
```

部署:
``` bash
make
```
