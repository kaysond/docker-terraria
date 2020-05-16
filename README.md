# Dockerized Vanilla Terraria Server

## Instructions
Set up two folders, one should be mounted to `/world` and contain your world files. The other should be mounted to `/config` and contain a single file: `serverconfig.txt`. This file is your server config file as described [here](https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file). For security, you should set up a dedicated user and group for Terraria. Grant permissions on the two folders to that user/group, and record the uid/gid.

Run the container via the CLI with: `docker run -itd --name=terraria -e PUID=<PROCESS UID> -e PGID=<PROCESS GID> -p 7777:7777 -v <PATH TO WORLDS>:/world -v <PATH TO CONFIG>:/config kaysond/docker-terraria`
Replacing the items in `<>`. For paths, I use `/var/lib/terraria/world` and `/var/lib/terraria/config`.

You can also use the following `docker-compose.yml` file, and run with `docker-compose up -d`.

```yaml
version: '2.0'

services:
  terraria:
    container_name: terraria
    image: kaysond/docker-terraria
    environment:
      PUID: "<PROCESS UID>"
      PGID: "<PROCESS GID>"
    restart: always
    stdin_open: true
    tty: true
    ports:
      - 7777:7777
    volumes:
      - <PATH TO WORLDS>:/world
      - <PATH TO CONFIG>:/config
```

If you want to use the interactive console, you can re-attach to the container via `docker attach terraria`.
