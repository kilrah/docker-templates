FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:22.04 AS freefilesync-prep

RUN apt update -y && apt install -y --no-install-recommends wget ca-certificates 7zip
RUN mkdir /opt/ffs_dl \
    && mkdir /opt/freefilesync \
    && cd /opt/ffs_dl \
    && wget -q https://freefilesync.org/download/FreeFileSync_14.3_Linux.tar.gz \
    && 7zz x FreeFileSync_14.3_Linux.tar.gz \
    && 7zz x FreeFileSync_14.3_Linux.tar \
    && 7zz x FreeFileSync_14.3_Install.run \
    && 7zz x FreeFileSync.tar.gz \
    && mv FreeFileSync.tar /opt/freefilesync \
    && cd /opt/freefilesync \
    && 7zz x -y FreeFileSync.tar \
    && rm FreeFileSync.tar \
    && rm Bin/FreeFileSync_i686 \
    && rm Bin/RealTimeSync_i686 \
    && rm Bin/RealTimeSync_x86_64

FROM debian:buster

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu openssh-client libgtk2.0-bin \
      fonts-deva-extra fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core \
      firefox-esr xdg-utils \
    && rm -rf /var/lib/apt/lists && \
    apt autoclean -y && \
    apt autoremove -y \
    && useradd -u 99 -g 100 --create-home --home-dir /home/freefilesync freefilesync \
    && mkdir -p /home/freefilesync/path1 \
    && mkdir -p /home/freefilesync/path2 \
    && chown -R 99:100 /home/freefilesync \
    && ln -s /home/freefilesync/.config/FreeFileSync /home/freefilesync/appdata

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY --from=freefilesync-prep /opt/freefilesync /opt/freefilesync
COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/

ENV DISPLAY=:0

EXPOSE 8080

VOLUME /home/freefilesync/path1/
VOLUME /home/freefilesync/path2/
VOLUME /home/freefilesync/.config/FreeFileSync/

CMD ["bash", "-c", "chown -R 99:100 /dev/stdout && exec gosu freefilesync supervisord"]

    
    
    
    
    
    
    
    
    
    
    
    
    
    
