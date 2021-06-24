FROM alpine:edge

RUN apk add --no-cache lsyncd rsync bash
RUN mkdir -p /var/log/lsyncd/
ADD pihizi.lua /etc/lsyncd/
RUN mkdir -p /etc/lsyncd/pihizi/ 
ADD local-to-remote-sources.lua /etc/lsyncd/pihizi/

RUN mkdir -p /data/

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /tmp/* /var/cache/apk/*

CMD ["/entrypoint.sh"]
