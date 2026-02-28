FROM golang:1.26-trixie AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/sivchand/easy-novnc@v1.5.0  && \
    go build -o /bin/easy-novnc github.com/sivchand/easy-novnc

FROM debian:trixie

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends menu openbox tint2 tigervnc-standalone-server supervisor gosu openssh-client ncdu nano wget ca-certificates \
		libnss3 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libgbm1 libasound2 libsecret-1-0 python3 python3-pip git gitg htop psmisc \
		xfce4-terminal dbus-x11 thunar thunar-archive-plugin firefox-esr geany python3-serial \
	&& apt-get install -y xarchiver \
    && rm -rf /var/lib/apt/lists && \
    apt autoclean -y && \
    apt autoremove -y \
    && mkdir /opt/arduino \
    && cd /opt/arduino \
    && wget -qO arduino-ide.AppImage https://downloads.arduino.cc/arduino-ide/arduino-ide_2.3.8_Linux_64bit.AppImage \
    && chmod +x arduino-ide.AppImage \
    && useradd -s /bin/bash --create-home --home-dir /home/arduino arduino

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/
COPY tint2.conf /opt/
COPY start.sh /opt/

ENV DISPLAY=:0 
ENV PUID=1000
ENV PGID=1000

EXPOSE 8080

VOLUME /home/arduino/

CMD ["bash", "/opt/start.sh"]

    
    
    
    
    
    
    
    
    
    
    
    
    
    
