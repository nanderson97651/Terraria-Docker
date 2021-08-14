FROM alpine:3.11.6  
#Running older version to avoid 32-bit compatibility errors intruduced in alpine 3.13

LABEL Name=terrariaserver Version=0.0.1 Maintainer="nanderson97"

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add mono && \
    mkdir /terraria && \
    mkdir /terraria-server && \
    apk add unzip

ENV VERSION="1423"
ENV LINK=https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip
ENV FILE=terraria-server-${VERSION}.zip

ADD ${LINK} /${FILE}

RUN unzip /${FILE} -d \terraria && \
    mv *${VERSION}/Linux /terraria-server && \
    cd /terraria-server && \
    chmod +x /terraria-server/TerrariaServer && \
    chmod +x /terraria-server/TerrariaServer.bin.x86_64

EXPOSE 7777

VOLUME [ "/config", "/worlds" ]

ENTRYPOINT [ "mono", "/terraria-server/TerrariaServer.exe" ]

