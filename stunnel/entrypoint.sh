#!/bin/bash

cd /etc/stunnel

if [ ! -f stunnel.pem ]; then
    openssl req -x509 -nodes -newkey rsa:2048 -days 36500 -subj '/CN=stunnel' -keyout stunnel.pem -out stunnel.pem
    chmod 600 stunnel.pem
fi

if [ ! -f stunnel.conf ]; then
    if [ -f stunnel.template ]; then
        content=$(cat stunnel.template)
        eval "cat <<EOF
$content
EOF" > stunnel.conf
    else
        cat > stunnel.conf <<EOF
client = ${PIHIZI_CLIENT:-'yes'}
cert = /etc/stunnel/stunnel.pem
setuid = stunnel
setgid = stunnel
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
[${PIHIZI_SERVICE}]
accept = ${PIHIZI_ACCEPT}
connect = ${PIHIZI_CONNECT}
EOF
    fi
fi

exec stunnel "$@"
