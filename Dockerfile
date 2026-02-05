FROM debian:trixie-slim

ARG version="1454"
LABEL maintainer="github@aram.nubmail.ca"

ADD "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${version}.zip" /tmp/terraria.zip

RUN apt-get update && apt-get install -y --no-install-recommends unzip

WORKDIR /app/terraria/bin

RUN \
 unzip -j -d . /tmp/terraria.zip ${version}'/Linux/*' && \
 chmod +x ./TerrariaServer.bin.x86_64 ./TerrariaServer && \
 rm /tmp/terraria.zip

# TerrariaServer writes to paths under $HOME/.local/
ENV HOME=/world
EXPOSE 7777
VOLUME ["/world","/config"]

ENTRYPOINT ["/app/terraria/bin/TerrariaServer", "-config", "/config/serverconfig.txt"]
