FROM quay.io/justcontainers/base

ARG version="1436"
LABEL maintainer="github@aram.nubmail.ca"

ADD "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${version}.zip" /tmp/terraria.zip
RUN \
 echo "**** install terraria ****" && \
 apt-get update && \
 apt-get install -y unzip && \
 mkdir -p /root/.local/share/Terraria && \
 echo "{}" > /root/.local/share/Terraria/favorites.json && \
 mkdir -p /app/terraria/bin && \
 unzip /tmp/terraria.zip ${version}'/Linux/*' -d /tmp/terraria && \
 mv /tmp/terraria/${version}/Linux/* /app/terraria/bin && \
 echo "**** creating user ****" && \
 mkdir /config && \
 useradd -u 911 -U -d /config -s /bin/false terraria && \
 usermod -G users terraria && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 7777
VOLUME ["/world","/config"]

ENTRYPOINT ["/init"]
CMD ["/usr/bin/with-contenv", "s6-setuidgid", "terraria", "/app/terraria/bin/TerrariaServer.bin.x86_64", "-config", "/config/serverconfig.txt"]
