FROM alpine:edge
MAINTAINER pihizi <pihizi@msn.com>

RUN apk add --no-cache openssl stunnel libressl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm -rf /tmp/* /var/cache/apk/*

VOLUME /etc/stunnel

ENTRYPOINT ["/entrypoint.sh"]
