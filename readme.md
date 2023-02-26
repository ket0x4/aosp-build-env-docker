# Docker image for building Android Custom ROMs

## Installation

1- Install Docker and docker-compose
2- Clone this repository  
3- Run `docker build -t aosp-build-env:a13 .`  
4- create `docker-compose.yml` file and add this code:
(Dont forget to change the volumes path and variables according to your needs)

NOTE: If you dont wanna sync repo while building image, open dockerfile and disable line 42,43

```docker
version: '3'
services:
  aosp-buildenv:
    image: aosp-build-env:a13
    stdin_open: true
    tty: true
    container_name: aosp-buildenv
    environment:
        - GITMAIL="you@example.com" #Git email 
        - GITNAME="YourName" #Git name
        - CORECOUNT="4"      #CPU thread count
        - CCACHE="1"         #1: Enable ccache, 0: disable.
        - CCACHESIZE="50G"   #ccache size: 50GB, 1024MB, 4096GB etc.
        - CCACHECOMP="true"  #true: Enables ccache compression, false: disables it
        - ROM="lineage"      #rom name like: lineage, aosp, pe, bliss etc.
        - ROMURL="https://github.com/LineageOS/android.git"     #repo URL for syncing.
        - ROMBRANCH="lineage-20.0"                              #branch for repo URL
        - DEVICE="bacon"     #device product name like daisy,surya,lemonade etc.
        # -JAVAVER=""
    volumes:
    #  - $HOME/$ROM/out:$ROM/out
```

5- Run `docker-compose run aosp-buildenv bash`