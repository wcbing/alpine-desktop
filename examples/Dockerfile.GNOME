FROM alpine:latest

RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories && \
    apk add --no-cache alpine-conf xrdp xorgxrdp font-noto-cjk && \
    setup-desktop gnome

EXPOSE 3389

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
