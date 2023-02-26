# Ubuntu LTS for Better compatilbility
FROM ubuntu:latest

# Variables
ENV GITMAIL "you@example.com"
ENV GITNAME "YourName"
ENV CORECOUNT "4"
ENV CCACHE "1"
ENV CCACHESIZE "50G"
ENV CCACHECOMP "true"
ENV ROM "lineage"
ENV ROMURL "https://github.com/LineageOS/android.git"
ENV ROMBRANCH "lineage-20.0"
ENV DEVICE "bacon"
#ENV JAVAVER ""

# Install necessary packages
RUN apt update
RUN apt install -y python3 python-is-python3 bc bison build-essential ccache curl flex \
g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev \
lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev \
libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev > /dev/null

# Setup Repo

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# Setup ccache
RUN export USE_CCACHE=$CCACHE
RUN export CCACHE_EXEC=/usr/bin/ccache
#RUN cache -M $CCACHESIZE
RUN ccache -o compression=$CCACHECOMP

# Configure git
RUN git config --global user.email $GITMAIL
RUN git config --global user.name $GITNAME

# Sync repo
RUN mkdir $ROM
WORKDIR $ROM
RUN repo init --depth=1 -u $ROMURL -b $ROMBRANCH
RUN repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j CORECOUNT
CMD /bin/bash