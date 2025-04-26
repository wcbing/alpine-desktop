FROM alpine:latest

RUN sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.cernet.edu.cn/alpine#g' /etc/apk/repositories && \
    apk add --no-cache alpine-conf xrdp xorgxrdp font-noto-cjk adwaita-xfce-icon-theme && \
    setup-desktop xfce && \
    apk del xfce4-screensaver
    
RUN apk add --no-cache sudo && \
    groupadd sudo && \
    echo '%sudo ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo

# Use adwaita-xfce-icon-theme
COPY xsettings.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/
# Custom UI
COPY xfce4-panel.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3389
