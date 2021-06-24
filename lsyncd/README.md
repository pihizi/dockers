```yml
lsyncd:
  container_name: lsyncd
  image: pihizi/lsyncd
  privileged: true
  restart: always
  volumes:
  - /etc/localtime:/etc/localtime
  - /data/var/log/lsyncd:/var/log/lsyncd
  - ./etc/lsyncd/conf.d/pihizi.sources.lua:/etc/lsyncd/conf.d/pihizi.sources.lua
```
