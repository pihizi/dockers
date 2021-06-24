FROM alpine:edge

RUN apk add --no-cache lsyncd rsync bash
RUN mkdir -p /var/log/lsyncd/
ADD pihizi.lua /etc/lsyncd/
RUN mkdir -p /etc/lsyncd/conf.d/ 
ADD pihizi-sources.lua /etc/lsyncd/conf.d/

RUN mkdir -p /data/

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /tmp/* /var/cache/apk/*

CMD ["/entrypoint.sh"]
