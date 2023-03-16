FROM nextcloud

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y non-free \
    && apt-get update \
    && apt-get install -y ffmpeg intel-media-va-driver-non-free vainfo i965-va-driver \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists


    
    
    
    
    
    
    
    
    
    
    
    
    
    
