# Dockerized Vanilla Terraria Server
[![Build - Latest](https://github.com/kaysond/docker-terraria/actions/workflows/build-latest.yml/badge.svg)](https://github.com/kaysond/docker-terraria/actions/workflows/build-latest.yml)
## Instructions
Set up two folders, one should be mounted to `/world` and contain your world files. The other should be mounted to `/config` and contain a single file: `serverconfig.txt`. This file is your server config file as described [here](https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file). In your config file, make sure `worldpath=/world` and `world=/world/<worldname>.wld`. If you do not already have a world, you can use the `autocreate` option to make the server create the world. 

For security, you should set up a dedicated user for Terraria. Grant permissions on the two folders to that user.

### Sample docker-compose.yml

```yaml
---
services:
  terraria:
    image: kaysond/docker-terraria
    container_name: terraria
    user: 7777:65534
    restart: unless-stopped
    stdin_open: true
    tty: true
    ports:
      - 7777:7777
    volumes:
      - ./config:/config
      - ./world:/world
    read_only: true
    cap_drop:
      - ALL
    security_opt:
      - no-new-privileges
    pids_limit: 512
    mem_limit: 4G
    cpus: 2
```

If you want to use the interactive console, you can re-attach to the container via `docker attach terraria`.

### Sample serverconfig.txt

```
world=/world/World.wld # Do not change this unless you have a world file that has already been created
autocreate=2 # Auto create a medium size world if /world/World.wld doesn't exist
worldpath=/world # Auto create will save the world file to <worldpath>/World.wld
worldname=Terraria
difficulty=0 # Sets the difficulty of the map ; 0=Normal ; 1=Expert ; 2=Master ; 3=Journey
```
