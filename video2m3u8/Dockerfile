FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

ENV GENEE_DEL_SRC_FILE 1

RUN apt-get -q update

# install inotify-tools
RUN apt-get install -yq inotify-tools
RUN apt-get install -yq ffmpeg

RUN mkdir -p /data/pending /data/parsing /data/tmp /data/parsed /data/backup

ADD run.sh /run.sh
ADD porter.sh /porter.sh

CMD ["/run.sh"]
