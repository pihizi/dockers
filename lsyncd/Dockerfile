FROM --platform=linux/arm64/v8,linux/amd64 alpine:3.12

RUN apk update
RUN apk add --no-cache rsync=3.1.3-r3 lsyncd bash
RUN mkdir -p /var/log/lsyncd/
ADD pihizi.lua /etc/lsyncd/
RUN mkdir -p /etc/lsyncd/pihizi/ 
ADD local-to-remote-sources.lua /etc/lsyncd/pihizi/

RUN mkdir -p /data/

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /tmp/* /var/cache/apk/*

CMD ["/entrypoint.sh"]
