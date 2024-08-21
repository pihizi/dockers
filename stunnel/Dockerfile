FROM --platform=linux/arm64/v8,linux/amd64 alpine:edge
MAINTAINER pihizi <pihizi@msn.com>

RUN apk add --no-cache openssl stunnel libressl

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm -rf /tmp/* /var/cache/apk/*

VOLUME /etc/stunnel

CMD ["/entrypoint.sh"]
