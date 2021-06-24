```yml
lsyncd:
  container_name: lsyncd
  image: pihizi/lsyncd
  privileged: true
  restart: always
  volumes:
  - /etc/localtime:/etc/localtime
  - /data/var/log/lsyncd:/var/log/lsyncd
  - ./etc/lsyncd/pihizi/local-to-remote-sources.lua:/etc/lsyncd/pihizi/local-to-remote-sources.lua
  - ./etc/lsyncd/pihizi/remote-to-local-sources.lua:/etc/lsyncd/pihizi/remote-to-local-sources.lua
```
