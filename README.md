# Terraria-Docker

This is a docker image created to be able to run a vanilla Terraria server on Raspberry Pi 4 based on the Alpine linux image and using Mono.

## Creating a world
This image is designed to be used with a `serverconfig` file configured to look in the appropriate directory for worlds and autogenerate if not found.  To use with an existing world, place that `.wld` file in the folder mapped to `/worlds` and update the `serverconfig` accordingly.  An example `serverconfig` is included but the most important lines are as follows
```
#All paths are relative to run.sh (/root)
#Load a world and automatically start the server
world=worlds/YOUR_WORLD_HERE

#Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
autocreate=2

#Sets the difficulty of the world when using autocreate 0(classic), 1(expert), 2(master), 3(journey)
difficulty=0

#Sets the name of the world when using autocreate
worldname=worlds/YOUR_AUTOCREATED_WORLD_HERE

#Sets the folder where world files will be stored
worldpath=/worlds
```

## Starting contianer
The container can be started using docker compose.  Be sure to expose host port `7777` and map the `/worlds` and `/config` folders to your desired location on the host.  `/config` should hold a valid `serverconfig` file and all worlds will be saved in `/worlds`.
```
services:
  terraria:
    container_name: terraria-server
    build:
      context: .
      dockerfile: ./Dockerfile
    ports:
      - "7777:7777/tcp"
    volumes:
      - "~/terraria/worlds:/worlds"
      - "~/terraria/config:/config"
    restart: unless-stopped
```
## TODO
Add [graceful shutdown](https://github.com/chrisjoj/terraria/commit/4b69568842afb262d30cca09e71784614820ac40)
### Credit
This is heavily inspired by the work of [ryshe](https://github.com/ryansheehan/terraria), [jonifen](https://github.com/jonifen/terraria-docker-raspberry-pi), and [beardedio](https://github.com/beardedio/terraria).