FROM alpine:latest

RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories && \
    apk add --no-cache alpine-conf xrdp xorgxrdp font-noto-cjk adwaita-xfce-icon-theme && \
    setup-desktop xfce

EXPOSE 3389

RUN apk del xfce4-screensaver && \
    apk add --no-cache sudo && \
    groupadd sudo && \
    echo '%sudo ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
