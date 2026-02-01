# Dockerized Vanilla Terraria Server
[![Build - Latest](https://github.com/kaysond/docker-terraria/actions/workflows/build-latest.yml/badge.svg)](https://github.com/kaysond/docker-terraria/actions/workflows/build-latest.yml)
## Instructions
Set up two folders, one should be mounted to `/world` and contain your world files. The other should be mounted to `/config` and contain a single file: `serverconfig.txt`. This file is your server config file as described [here](https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file). In your config file, make sure `worldpath=/world` and `world=/world/<worldname>.wld`. If you do not already have a world, you can use the `autocreate` option to make the server create the world. If you do not have a serverconfig.txt file, the container will create one for you that autocreates a medium world called "Terraria."

For security, you should set up a dedicated user and group for Terraria. Grant permissions on the two folders to that user/group, and record the uid/gid.

Run the container via the CLI with: `docker run -itd --name=terraria -e PUID=<PROCESS UID> -e PGID=<PROCESS GID> -p 7777:7777 -v <PATH TO WORLDS>:/world -v <PATH TO CONFIG>:/config kaysond/docker-terraria`
Replacing the items in `<>`. For paths, I use `/var/lib/terraria/world` and `/var/lib/terraria/config`.

You can also use the following `docker-compose.yml` file, and run with `docker compose up -d`.

```yaml
services:
  terraria:
    container_name: terraria
    image: kaysond/docker-terraria
    environment:
      PUID: "<PROCESS UID>"
      PGID: "<PROCESS GID>"
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 7777:7777
    volumes:
      - <PATH TO WORLDS>:/world
      - <PATH TO CONFIG>:/config
```

If you want to use the interactive console, you can re-attach to the container via `docker attach terraria`.

### Sample serverconfig.txt

```
world=/world/World.wld # Do not change this unless you have a world file that has already been created
autocreate=2 # Auto create a medium size world if /world/World.wld doesn't exist
worldpath=/world # Auto create will save the world file to <worldpath>/World.wld
worldname=Terraria
difficulty=0 # Sets the difficulty of the map ; 0=Normal ; 1=Expert ; 2=Master ; 3=Jorney
```
