FROM golang:1.26-trixie AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/sivchand/easy-novnc@v1.5.0 && \
    go build -o /bin/easy-novnc github.com/sivchand/easy-novnc

FROM ubuntu:24.04 AS freefilesync-prep

RUN apt update -y && apt install -y --no-install-recommends wget ca-certificates 7zip
RUN mkdir /opt/ffs_dl \
    && mkdir /opt/freefilesync \
    && cd /opt/ffs_dl \
    && wget -q https://freefilesync.org/download/FreeFileSync_14.8_Linux_x86_64.tar.gz \
    && 7z x FreeFileSync_14.8_Linux_x86_64.tar.gz \
    && 7z x FreeFileSync_14.8_Linux_x86_64.tar \
    && 7z x FreeFileSync_14.8_Install.run \
    && 7z x FreeFileSync.tar.gz \
    && mv FreeFileSync.tar /opt/freefilesync \
    && cd /opt/freefilesync \
    && 7z x -y FreeFileSync.tar \
    && rm FreeFileSync.tar \
    && rm Bin/RealTimeSync_x86_64

FROM debian:trixie

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends menu openbox tint2 tigervnc-standalone-server supervisor gosu openssh-client libgtk2.0-bin \
      fonts-deva-extra fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core \
      firefox-esr xdg-utils ncdu \
    && rm -rf /var/lib/apt/lists && \
    apt autoclean -y && \
    apt autoremove -y \
    && useradd --create-home --home-dir /home/freefilesync freefilesync \
    && ln -s /home/freefilesync/.config/FreeFileSync /home/freefilesync/appdata

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY --from=freefilesync-prep /opt/freefilesync /opt/freefilesync
COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/
COPY tint2.conf /opt/
COPY start.sh /opt/

ENV DISPLAY=:0
ENV PUID=1000
ENV PGID=1000
ENV RUN_AS_ROOT=false

EXPOSE 8080

VOLUME /home/freefilesync/

CMD ["bash", "/opt/start.sh"]

