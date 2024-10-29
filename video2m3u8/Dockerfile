FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -q update

# install inotify-tools
RUN apt-get install -yq inotify-tools
RUN apt-get install -yq ffmpeg

ADD run.sh /run.sh

CMD ["/run.sh"]
