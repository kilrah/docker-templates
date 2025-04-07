FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM debian:buster

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu openssh-client ncdu nano wget ca-certificates \
		libnss3 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 libasound2 libsecret-1-0 python3 python3-pip git gitg htop psmisc \
		xfce4-terminal dbus-x11 thunar thunar-archive-plugin firefox-esr geany \
	&& apt-get install -y xarchiver \
    && rm -rf /var/lib/apt/lists && \
    apt autoclean -y && \
    apt autoremove -y \
    && mkdir /opt/arduino \
    && cd /opt/arduino \
    && wget -qO arduino-ide.AppImage https://downloads.arduino.cc/arduino-ide/arduino-ide_2.3.5_Linux_64bit.AppImage \
    && chmod +x arduino-ide.AppImage \
    && useradd -u 99 -g 100 -s /bin/bash --create-home --home-dir /home/arduino arduino \
    && chown -R 99:100 /home/arduino \ 
    && pip3 install pyserial   

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/

ENV DISPLAY=:0 PUID=99 PGID=100

EXPOSE 8080

VOLUME /home/arduino/

CMD ["bash", "-c", "groupmod -o -g ${PGID} users && usermod -o -u ${PUID} arduino && chown -R ${PUID}:${PGID} /dev/stdout /home/arduino && chmod 0666 /dev/tty* && exec gosu arduino supervisord"]

    
    
    
    
    
    
    
    
    
    
    
    
    
    
