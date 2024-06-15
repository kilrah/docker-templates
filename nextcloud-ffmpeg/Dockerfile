FROM nextcloud

RUN sed -i "s/Components: main/Components: main non-free non-free-firmware/" /etc/apt/sources.list.d/debian.sources
RUN apt-get update \
    && apt-get install -y ffmpeg intel-media-va-driver-non-free vainfo i965-va-driver 
RUN apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists


    
    
    
    
    
    
    
    
    
    
    
    
    
    
