FROM alpine:edge
MAINTAINER pihizi <pihizi@msn.com>

RUN apk add --no-cache stunnel libressl

COPY entrypoint.sh /entrypoint.sh
chomd +x /entrypoint.sh

VOLUME /etc/stunnel

ENTRYPOINT ["/entrypoint.sh"]
