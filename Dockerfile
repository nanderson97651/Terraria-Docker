FROM alpine

LABEL Name=terrariaserver Version=1.4.2.3 Maintainer="nanderson97"

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk add mono unzip curl && \
    mkdir /terraria-tmp && \
    mkdir /terraria-server

ARG VERSION="1423"
ENV LINK=https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip
ENV FILE=terraria-server-${VERSION}.zip
COPY run-server.sh ./run.sh

RUN curl -s ${LINK} --output ${FILE} && \
    unzip /${FILE} -d /terraria-tmp && \
    mv */${VERSION}/Linux/* /terraria-server && \
    rm ${FILE} && \
    chmod +x ./run.sh && \
    cd /terraria-server && \
    chmod +x /terraria-server/TerrariaServer && \
    chmod +x /terraria-server/TerrariaServer.bin.x86_64 && \
    rm -R /terraria-tmp && \
    rm /terraria-server/System* && \
    rm /terraria-server/Mono* && \
    rm /terraria-server/monoconfig && \
    rm /terraria-server/mscorlib.dll

EXPOSE 7777/tcp

VOLUME [ "/config", "/worlds" ]

ENTRYPOINT [ "./run.sh" ]
