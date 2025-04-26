# Alpine Container with Desktop

带有桌面环境的 Alpine 容器。

此容器需通过 RDP 使用，有中文字体，主要面向轻量级用途，如管理文件、浏览网页。

> 如果你熟悉 Alpine 那用处随意。

> 浏览网页这个可以对标 [linuxserver](https://hub.docker.com/r/linuxserver/firefox) 和 [kasmweb](https://hub.docker.com/r/kasmweb/firefox) 这两个使用 VNC 的 Firefox，不知道为什么他们的镜像那么大。

## 说明

### 优势

- 内存占用低
    - 使用 Alpine 3.21 测试，Xfce 桌面内存占用不到 400M 。（KDE Plasma、GNOME 启动需要 1G 左右）
- 更新和维护时间适中
    - Alpine 半年更新一个版本，与 Debian、Ubuntu LTS 相比软件相对较新。
    - 每个版本维护 2 年，比 Ubuntu 非 LTS 版本维护时间长。

### 注意事项

- Alpine 使用的是 `Musl` C库，很多程序可能不能正常运行，请优先通过 apk 从官方仓库中安装。  
- 安装桌面程序推荐通过 Flatpak（需自行安装）。

## 用法样例

用到的两个环境变量

- `RDP_USER`  
RDP 的登陆用户，默认为 `user`
- `RDP_PASSEORD`  
RDP 的登陆密码，默认为 `password`

### 样例 1：默认用户

使用 `user` 用户登陆，密码是 `password`，端口为 3389。
> ⚠️ 建议仅测试时使用。

```sh
docker run -p 3389:3389 wcbing/alpine-desktop:latest
```

### 样例2：自定义用户

使用 `test` 用户登陆，密码是 `test`，端口为 13389。
```sh
docker run -d -p 13389:3389 \
    -e RDP_USER=test \
    -e RDP_PASSWORD=test \
    --name alpine-desktop \
    wcbing/alpine-desktop:latest
```

### 样例3：自定义用户，挂载本地目录

使用 `test` 用户登陆，密码是 `test`，端口为 13389，挂载 hostname 和 `test` 用户主目录。
> ⚠️ 挂载敏感目录时请小心。

```sh
docker run -d -p 13389:3389 \
    -e RDP_USER=test \
    -e RDP_PASSWORD=test \
    -v /etc/hostname:/etc/hostname:ro \
    -v /home/test/:/home/test/ \
    --name alpine-desktop \
    wcbing/alpine-desktop:latest
```

### 样例4：使用 compose.yaml

下载或复制 `compose.yaml`，使用 compose 工具管理。

## 定制构建

我只构建了 X86_64 平台的 Xfce 镜像。如果机器性能较高想使用体验更好的 GNOME 或 KDE Plasma 桌面，可以自行构建镜像。`Dockerfile.GNOME` 是使用 GNOME 的一个例子。

使用其他桌面请将其中
```
setup-desktop gnome
```

更换为需要的桌面，目前 Alpine 支持的桌面环境有

```
'gnome', 'plasma', 'xfce', 'mate', 'sway', 'lxqt'
```
