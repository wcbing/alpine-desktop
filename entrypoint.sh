#!/bin/sh

# create and set the password for new rdp user
[ -z "$RDP_USER" ] && RDP_USER=user
if ! id "$RDP_USER" >/dev/null 2>&1; then
    useradd -G sudo -m "$RDP_USER"
    [ -z "$RDP_PASSWORD" ] && RDP_PASSWORD=password
    echo "$RDP_USER:$RDP_PASSWORD" | chpasswd
fi

# resolves that files already exist after container restart
[ -e /var/run/xrdp-sesman.pid ] && rm -f /var/run/xrdp-sesman.pid
[ -e /var/run/xrdp.pid ] && rm -f /var/run/xrdp.pid

/usr/sbin/xrdp-sesman
if [ "$#" -eq 0 ]; then
    /usr/sbin/xrdp --nodaemon
else
    /usr/sbin/xrdp
    exec "$@"
fi
